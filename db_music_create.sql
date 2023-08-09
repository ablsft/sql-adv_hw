CREATE TABLE IF NOT EXISTS Albums (
	album_id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	year INTEGER NOT NULL CHECK (year > 1900)
);

CREATE TABLE IF NOT EXISTS Artists (
	artist_id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Album_Artist (
	album_id INTEGER REFERENCES Albums(album_id),
	artist_id INTEGER REFERENCES Artists(artist_id),
	CONSTRAINT pk1 PRIMARY KEY (album_id, artist_id)
);

CREATE TABLE IF NOT EXISTS Genres (
	genre_id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Artist_Genre (
	artist_id INTEGER REFERENCES Artists(artist_id),
	genre_id INTEGER REFERENCES Genres(genre_id),
	CONSTRAINT pk2 PRIMARY KEY (artist_id, genre_id)
);

CREATE TABLE IF NOT EXISTS Compilations (
	compilation_id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	year INTEGER NOT NULL CHECK (year > 1900)
);

CREATE TABLE IF NOT EXISTS Tracks (
	track_id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	duration INTEGER NOT NULL CHECK (duration > 30),
	album_id INTEGER NOT NULL REFERENCES Albums(album_id)
);

CREATE TABLE IF NOT EXISTS Compilation_Track (
	compilation_id INTEGER REFERENCES Compilations(compilation_id),
	track_id INTEGER REFERENCES Tracks(track_id),
	CONSTRAINT pk3 PRIMARY KEY (compilation_id, track_id)
);