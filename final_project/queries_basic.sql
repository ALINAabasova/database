-- Index for faster lookups of users by email
CREATE INDEX idx_users_email ON users(email);

-- Index for faster searches of manga by title
CREATE INDEX idx_manga_title ON manga(title);

-- Получить всех пользователей с их профилями
SELECT 
    u.user_id,
    u.username,
    up.bio,
    up.preferences
FROM users u
JOIN user_profiles up ON u.user_id = up.user_id;

-- Список всех манг с их авторами
SELECT 
    m.manga_id,
    m.title AS manga_title,
    a.name AS author_name
FROM manga m
JOIN manga_authors ma ON m.manga_id = ma.manga_id
JOIN authors a ON ma.author_id = a.author_id;

-- Все манги определённого жанра (по Action)
SELECT 
    m.title AS manga_title,
    g.name AS genre_name
FROM manga m
JOIN manga_genres mg ON m.manga_id = mg.manga_id
JOIN genres g ON mg.genre_id = g.genre_id
WHERE g.name = 'Action';

-- Все списки чтения пользователей
SELECT 
    u.username,
    rl.name AS reading_list_name
FROM users u
JOIN reading_lists rl ON u.user_id = rl.user_id;

-- Манги в конкретном списке чтения
SELECT 
    rl.name AS reading_list,
    m.title AS manga_title
FROM reading_lists rl
JOIN reading_list_manga rlm ON rl.list_id = rlm.list_id
JOIN manga m ON rlm.manga_id = m.manga_id
WHERE rl.name = 'Favorites';

-- Все отзывы пользователей о мангах
SELECT 
    u.username,
    m.title AS manga_title,
    r.rating,
    r.comment
FROM reviews r
JOIN users u ON r.user_id = u.user_id
JOIN manga m ON r.manga_id = m.manga_id;

-- Средний рейтинг каждой манги
SELECT 
    m.title,
    AVG(r.rating) AS average_rating
FROM manga m
JOIN reviews r ON m.manga_id = r.manga_id
GROUP BY m.title;

-- Манги со средним рейтингом выше 4.5
SELECT 
    m.title,
    AVG(r.rating) AS avg_rating
FROM manga m
JOIN reviews r ON m.manga_id = r.manga_id
GROUP BY m.title
HAVING AVG(r.rating) > 4.5;

-- Все взаимодействия пользователей (лайки, закладки)
SELECT 
    u.username,
    m.title AS manga_title,
    i.type AS interaction_type,
    i.created_at
FROM interactions i
JOIN users u ON i.user_id = u.user_id
JOIN manga m ON i.manga_id = m.manga_id;

-- Все манги, которые пользователь лайкнул
SELECT 
    u.username,
    m.title
FROM interactions i
JOIN users u ON i.user_id = u.user_id
JOIN manga m ON i.manga_id = m.manga_id
WHERE i.type = 'like';

-- Количество манг в каждом списке чтения
SELECT 
    rl.name AS reading_list,
    COUNT(rlm.manga_id) AS manga_count
FROM reading_lists rl
LEFT JOIN reading_list_manga rlm ON rl.list_id = rlm.list_id
GROUP BY rl.name;

-- Все жанры каждой манги
SELECT 
    m.title AS manga_title,
    g.name AS genre_name
FROM manga m
JOIN manga_genres mg ON m.manga_id = mg.manga_id
JOIN genres g ON mg.genre_id = g.genre_id
ORDER BY m.title;

-- Все манги, добавленные конкретным пользователем в списки
SELECT DISTINCT
    u.username,
    m.title AS manga_title
FROM users u
JOIN reading_lists rl ON u.user_id = rl.user_id
JOIN reading_list_manga rlm ON rl.list_id = rlm.list_id
JOIN manga m ON rlm.manga_id = m.manga_id
WHERE u.username = 'alina';


-- Авторы и количество их манг в базе
SELECT 
    a.name AS author_name,
    COUNT(ma.manga_id) AS manga_count
FROM authors a
JOIN manga_authors ma ON a.author_id = ma.author_id
GROUP BY a.name;


-- Топ-5 самых популярных манг (по лайкам)
SELECT 
    m.title,
    COUNT(i.interaction_id) AS likes_count
FROM manga m
JOIN interactions i ON m.manga_id = i.manga_id
WHERE i.type = 'like'
GROUP BY m.title
ORDER BY likes_count DESC
LIMIT 5;
