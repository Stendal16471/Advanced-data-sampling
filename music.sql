-- Жанры музыкальных произведений
CREATE TABLE IF NOT EXISTS musical_genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Исполнители (музыканты, группы)
CREATE TABLE IF NOT EXISTS music_artist (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Музыкальные альбомы
CREATE TABLE IF NOT EXISTS music_album (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    year_of_release INTEGER NOT NULL CHECK (year_of_release > 1900 AND year_of_release <= EXTRACT(YEAR FROM CURRENT_DATE)),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Музыкальные треки
CREATE TABLE IF NOT EXISTS music_track (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    duration INTEGER NOT NULL CHECK (duration > 0 AND duration <= 3600),
    music_album_id INTEGER NOT NULL REFERENCES music_album(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Музыкальные сборники
CREATE TABLE IF NOT EXISTS collection (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    year_of_release INTEGER NOT NULL CHECK (year_of_release > 1900 AND year_of_release <= EXTRACT(YEAR FROM CURRENT_DATE)),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Связь жанров и исполнителей (многие-ко-многим)
CREATE TABLE IF NOT EXISTS genre_artist (
    musical_genre_id INTEGER NOT NULL REFERENCES musical_genre(id) ON DELETE CASCADE,
    music_artist_id INTEGER NOT NULL REFERENCES music_artist(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_genre_artist PRIMARY KEY (musical_genre_id, music_artist_id)
);

-- Связь альбомов и исполнителей (многие-ко-многим)
CREATE TABLE IF NOT EXISTS album_artist (
    music_album_id INTEGER NOT NULL REFERENCES music_album(id) ON DELETE CASCADE,
    music_artist_id INTEGER NOT NULL REFERENCES music_artist(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_album_artist PRIMARY KEY (music_album_id, music_artist_id)
);

-- Связь сборников и треков (многие-ко-многим)
CREATE TABLE IF NOT EXISTS collection_track (
    collection_id INTEGER NOT NULL REFERENCES collection(id) ON DELETE CASCADE,
    music_track_id INTEGER NOT NULL REFERENCES music_track(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_collection_track PRIMARY KEY (collection_id, music_track_id)
);

-- Индексы для улучшения производительности
CREATE INDEX idx_music_track_album_id ON music_track(music_album_id);
CREATE INDEX idx_collection_track_track_id ON collection_track(music_track_id);
CREATE INDEX idx_collection_track_collection_id ON collection_track(collection_id);