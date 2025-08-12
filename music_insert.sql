-- Заполнение таблицы жанров
INSERT INTO musical_genre (name) VALUES 
('Рок'),
('Альтернатива'),
('Авторская песня'),
('Панк-рок'),
('Метал');

-- Заполнение таблицы исполнителей
INSERT INTO music_artist (name) VALUES 
('Ария'),
('Король и Шут'),
('Мельница'),
('Imagine Dragons'),
('Slipknot'),
('Muse'),
('Panic! At the Disco');

-- Заполнение таблицы альбомов
INSERT INTO music_album (name, year_of_release) VALUES 
('Проклятье морей', 2018),            -- Ария
('Кровь за кровь', 1991),             -- Ария
('Герои и злодеи', 2000),             -- Король и Шут
('Ангелофрения', 2012),               -- Мельница
('Зов крови', 2006),                  -- Мельница
('Evolve', 2017),                     -- Imagine Dragons
('Mercury – Act 1', 2021),            -- Imagine Dragons
('Birds', 2019),                      -- Imagine Dragons
('The End, So Far', 2022),            -- Slipknot
('Black Holes & Revelations', 2006),  -- Muse
('Vices & Virtues', 2011);            -- Panic! At the Disco

-- Заполнение таблицы треков
INSERT INTO music_track (name, duration, music_album_id) VALUES 
('От заката до рассвета', 371, 1),    -- Ария - Проклятье морей
('Кровь за кровь', 435, 2),           -- Ария - Кровь за кровь
('Дед на свадьбе', 269, 3),           -- Король и Шут - Герои и злодеи
('Ангел', 242, 4),                    -- Мельница - Ангелофрения
('Черная овечка', 238, 5),            -- Мельница - Зов крови
('Believer', 194, 6),                 -- Imagine Dragons - Evolve
('My Life', 225, 7),                  -- Imagine Dragons - Mercury – Act 1
('Birds', 210, 8),                    -- Imagine Dragons - Birds
('Yen', 265, 9),                      -- Slipknot - The End, So Far
('Supermassive Black Hole', 196, 10), -- Muse - Black Holes
('The Ballad of Mona Lisa', 200, 11); -- Panic! At Disco

-- Заполнение таблицы сборников
INSERT INTO collection (name, year_of_release) VALUES 
('Русский рок: Классика', 2020),
('Альтернатива 2000-х', 2023),
('Энциклопедия метала', 2022),
('Мировые хиты', 2021),
('Фолк и авторская песня', 2019),
('Панк-рок: Антология', 2018),
('Великие баллады', 2015),
('Готическая коллекция', 2016);

-- Связи жанров и исполнителей
INSERT INTO genre_artist (musical_genre_id, music_artist_id) VALUES
(1, 1), -- Рок - Ария
(5, 1), -- Метал - Ария
(3, 2), -- Авторская песня - Король и Шут
(4, 2), -- Панк-рок - Король и Шут
(3, 3), -- Авторская песня - Мельница
(2, 4), -- Альтернатива - Imagine Dragons
(5, 5), -- Метал - Slipknot
(2, 6), -- Альтернатива - Muse
(2, 7); -- Альтернатива - Panic! At the Disco

-- Связи альбомов и исполнителей
INSERT INTO album_artist (music_album_id, music_artist_id) VALUES
(1, 1), -- Проклятье морей - Ария
(2, 1), -- Кровь за кровь - Ария
(3, 2), -- Герои и злодеи - Король и Шут
(4, 3), -- Ангелофрения - Мельница
(5, 3), -- Зов крови - Мельница
(6, 4), -- Evolve - Imagine Dragons
(7, 4), -- Mercury – Act 1 - Imagine Dragons
(8, 4), -- Birds - Imagine Dragons
(9, 5), -- The End, So Far - Slipknot
(10, 6),-- Black Holes & Revelations - Muse
(11, 7);-- Vices & Virtues - Panic! At the Disco

-- Связи сборников и треков
INSERT INTO collection_track (collection_id, music_track_id) VALUES
(1, 1),   -- Русский рок: Классика - От заката до рассвета
(1, 2),   -- Русский рок: Классика - Кровь за кровь
(2, 6),   -- Альтернатива 2000-х - Believer
(2, 8),   -- Альтернатива 2000-х - Birds
(2, 10),   -- Альтернатива 2000-х - Supermassive Black Hole
(3, 1),   -- Энциклопедия метала - От заката до рассвета
(3, 9),   -- Энциклопедия метала - Yen
(4, 6),   -- Мировые хиты - Believer
(4, 7),   -- Мировые хиты - My Life
(4, 10),   -- Мировые хиты - Supermassive Black Hole
(4, 11),  -- Мировые хиты - The Ballad of Mona Lisa
(5, 3),   -- Фолк и авторская песня - Дед на свадьбе
(5, 4),   -- Фолк и авторская песня - Ангел
(6, 3),   -- Панк-рок: Антология - Дед на свадьбе
(7, 2),   -- Великие баллады - Кровь за кровь
(7, 10),   -- Великие баллады - Supermassive Black Hole
(8, 4),   -- Готическая коллекция - Ангел
(8, 11);  -- Готическая коллекция - The Ballad of Mona Lisa