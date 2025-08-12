-- Задание 2

-- Название и продолжительность самого длительного трека
SELECT name, duration 
FROM music_track
WHERE duration = (SELECT MAX(duration) FROM music_track);

-- Название треков, продолжительность которых не менее 3,5 минут
SELECT name, duration 
FROM music_track
WHERE duration >= 210;

-- Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT name, year_of_release 
FROM collection
WHERE year_of_release BETWEEN 2018 AND 2020;

-- Исполнители, чьё имя состоит из одного слова
SELECT name 
FROM music_artist
WHERE name NOT LIKE '% %';

-- Название треков, которые содержат слово «мой» или «my»
SELECT name 
FROM music_track
WHERE name ILIKE '%мой%' OR name ILIKE '%my%';


-- Задание 3

-- Количество исполнителей в каждом жанре
SELECT 
    mg.name AS genre_name,
    COUNT(ga.music_artist_id) AS artist_count
FROM 
    musical_genre mg
LEFT JOIN 
    genre_artist ga ON mg.id = ga.musical_genre_id
GROUP BY 
    mg.name
ORDER BY 
    artist_count DESC;

-- Количество треков, вошедших в альбомы 2019–2020 годов
SELECT 
    a.name AS album_name,
    COUNT(t.id) AS track_count,
    a.year_of_release
FROM 
    music_album a
JOIN 
    music_track t ON a.id = t.music_album_id
WHERE 
    a.year_of_release BETWEEN 2019 AND 2020
GROUP BY 
    a.id, a.name, a.year_of_release
ORDER BY 
    track_count DESC;


-- Средняя продолжительность треков по каждому альбому
SELECT 
    a.name AS album_name,
    COUNT(t.id) AS track_count,
    ROUND(AVG(t.duration), 2) AS avg_duration_seconds,
    CONCAT(
        FLOOR(AVG(t.duration) / 60), ' мин ', 
        ROUND(AVG(t.duration) % 60), ' сек'
    ) AS avg_duration_formatted
FROM 
    music_album a
JOIN 
    music_track t ON a.id = t.music_album_id
GROUP BY 
    a.id, a.name
ORDER BY 
    avg_duration_seconds DESC;

-- Все исполнители, которые не выпустили альбомы в 2020 году
SELECT DISTINCT
    ma.name AS artist_name
FROM 
    music_artist ma
WHERE    
    ma.id NOT IN (        
        SELECT DISTINCT aa.music_artist_id
        FROM album_artist aa
        JOIN music_album mal ON aa.music_album_id = mal.id
        WHERE mal.year_of_release = 2020
    )
ORDER BY 
    artist_name;

-- Названия сборников, в которых присутствует конкретный исполнитель
SELECT DISTINCT
    c.name AS collection_name
FROM 
    collection c
JOIN 
    collection_track ct ON c.id = ct.collection_id
JOIN 
    music_track t ON ct.music_track_id = t.id
JOIN 
    music_album a ON t.music_album_id = a.id
JOIN 
    album_artist aa ON a.id = aa.music_album_id
JOIN 
    music_artist ma ON aa.music_artist_id = ma.id
WHERE 
    ma.name = 'Imagine Dragons'
ORDER BY 
    collection_name;


-- Задание 4

-- Названия альбомов, в которых присутствуют исполнители более чем одного жанра
SELECT 
    a.name AS album_name,
    COUNT(DISTINCT ga.musical_genre_id) AS genre_count
FROM 
    music_album a
JOIN 
    album_artist aa ON a.id = aa.music_album_id
JOIN 
    genre_artist ga ON aa.music_artist_id = ga.music_artist_id
GROUP BY 
    a.id, a.name
HAVING 
    COUNT(DISTINCT ga.musical_genre_id) > 1
ORDER BY 
    genre_count DESC;

-- Наименования треков, которые не входят в сборники
SELECT 
    t.name AS track_name,
    a.name AS album_name,
    ar.name AS artist_name
FROM 
    music_track t
JOIN 
    music_album a ON t.music_album_id = a.id
JOIN 
    album_artist aa ON a.id = aa.music_album_id
JOIN 
    music_artist ar ON aa.music_artist_id = ar.id
WHERE 
    t.id NOT IN (SELECT music_track_id FROM collection_track)
ORDER BY 
    track_name;

-- Исполнитель или исполнители, написавшие самый короткий по продолжительности трек
SELECT 
    ma.name AS artist_name,
    mt.name AS track_name,
    mt.duration AS duration_seconds
FROM 
    music_track mt
JOIN 
    music_album mal ON mt.music_album_id = mal.id
JOIN 
    album_artist aa ON mal.id = aa.music_album_id
JOIN 
    music_artist ma ON aa.music_artist_id = ma.id
WHERE 
    mt.duration = (SELECT MIN(duration) FROM music_track)
ORDER BY 
    ma.name;

-- Названия альбомов, содержащих наименьшее количество треков
SELECT 
    ma.name AS album_name,
    COUNT(mt.id) AS track_count
FROM 
    music_album ma
LEFT JOIN 
    music_track mt ON ma.id = mt.music_album_id
GROUP BY 
    ma.id, ma.name
HAVING 
    COUNT(mt.id) = (
        SELECT COUNT(mt2.id)
        FROM music_album ma2
        LEFT JOIN music_track mt2 ON ma2.id = mt2.music_album_id
        GROUP BY ma2.id
        ORDER BY COUNT(mt2.id) ASC
        LIMIT 1
    )
ORDER BY 
    album_name;