--Задание 2
--Название и продолжительность самого длительного трека
SELECT name, duration FROM tracks
ORDER BY duration DESC
LIMIT 1;

--Название треков, продолжительность которых не менее 3,5 минут
SELECT name, duration FROM tracks
WHERE duration >= 210;

--Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT name FROM compilations
WHERE year BETWEEN 2018 AND 2020;

--Исполнители, чьё имя состоит из одного слова
SELECT name FROM artists
WHERE name NOT LIKE '% %';

--Название треков, которые содержат слово «мой» или «my»
SELECT name FROM tracks
WHERE name ILIKE 'my %' 
OR name ILIKE '% my'
OR name ILIKE '% my %'
OR name ILIKE 'my';

--Задание 3
--Количество исполнителей в каждом жанре
SELECT g.name, COUNT(ag.artist_id) FROM genres g
JOIN artist_genre ag ON g.genre_id = ag.genre_id
GROUP BY g.name;

--Количество треков, вошедших в альбомы 2019–2020 годов
SELECT COUNT(tracks.track_id) FROM albums
JOIN tracks ON albums.album_id = tracks.album_id
WHERE albums.year BETWEEN 2019 AND 2020;

--Средняя продолжительность треков по каждому альбому
SELECT albums.name, AVG(tracks.duration) FROM albums
JOIN tracks ON albums.album_id = tracks.album_id
GROUP BY albums.name;

--Все исполнители, которые не выпустили альбомы в 2020 году
SELECT name FROM artists
WHERE name NOT IN (
	SELECT artists.name FROM artists
	JOIN album_artist alar ON artists.artist_id = alar.artist_id
	JOIN albums ON albums.album_id = alar.album_id
	WHERE albums.year = 2020
);

--Названия сборников, в которых присутствует конкретный исполнитель
SELECT c.name FROM compilations c
JOIN compilation_track ct ON ct.compilation_id = c.compilation_id
JOIN tracks t ON t.track_id = ct.track_id
JOIN albums al ON al.album_id = t.album_id
JOIN album_artist aa ON aa.album_id = al.album_id
JOIN artists ar ON ar.artist_id = aa.artist_id
WHERE ar.name LIKE 'Cream'

--Задание 4
--Названия альбомов, в которых присутствуют исполнители более чем одного жанра
SELECT DISTINCT albums.name FROM albums
JOIN album_artist alar ON albums.album_id = alar.album_id
JOIN artists ON artists.artist_id = alar.artist_id
JOIN artist_genre ag ON ag.artist_id = alar.artist_id
GROUP BY albums.name
HAVING COUNT(albums.name) > 1;

--Наименования треков, которые не входят в сборники
SELECT t.name FROM tracks t
LEFT JOIN compilation_track ct ON t.track_id = ct.track_id
WHERE ct.track_id IS NULL

--Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько
SELECT artists.name, tracks.name, tracks.duration FROM artists
JOIN album_artist alar ON artists.artist_id = alar.artist_id
JOIN tracks ON tracks.album_id = alar.album_id
WHERE tracks.duration = (SELECT MIN(duration) FROM tracks);

--Названия альбомов, содержащих наименьшее количество треков
SELECT albums.name, COUNT(albums.name) FROM albums
JOIN tracks ON tracks.album_id = albums.album_id
GROUP BY albums.name
HAVING COUNT(albums.name) = (SELECT MIN(album_count) FROM 
(SELECT COUNT(albums.name) album_count FROM albums
JOIN tracks ON tracks.album_id = albums.album_id
GROUP BY albums.name) c);