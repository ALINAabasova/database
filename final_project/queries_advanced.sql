-- Пользователи с более чем одним списком чтения
SELECT
    u.username,
    COUNT(rl.list_id) AS lists_count
FROM users u
JOIN reading_lists rl ON u.user_id = rl.user_id
GROUP BY u.username
HAVING COUNT(rl.list_id) > 1;


-- Манги, у которых больше одного жанра
SELECT
    m.title,
    COUNT(mg.genre_id) AS genres_count
FROM manga m
JOIN manga_genres mg ON m.manga_id = mg.manga_id
GROUP BY m.title
HAVING COUNT(mg.genre_id) > 1;


-- Средний рейтинг манги (только если есть минимум 2 отзыва)
SELECT
    m.title,
    AVG(r.rating) AS avg_rating,
    COUNT(r.review_id) AS reviews_count
FROM manga m
JOIN reviews r ON m.manga_id = r.manga_id
GROUP BY m.title
HAVING COUNT(r.review_id) >= 2;


-- Манги без отзывов (подзапрос)
SELECT
    m.title
FROM manga m
WHERE m.manga_id NOT IN (
    SELECT DISTINCT manga_id
    FROM reviews
);


-- Пользователи, которые оставили отзывы с рейтингом выше среднего
SELECT
    u.username,
    r.rating
FROM reviews r
JOIN users u ON r.user_id = u.user_id
WHERE r.rating > (
    SELECT AVG(rating)
    FROM reviews
);


-- Самая популярная манга (по количеству лайков)
SELECT
    m.title,
    COUNT(i.interaction_id) AS likes_count
FROM manga m
JOIN interactions i ON m.manga_id = i.manga_id
WHERE i.type = 'like'
GROUP BY m.title
HAVING COUNT(i.interaction_id) = (
    SELECT MAX(like_count)
    FROM (
        SELECT COUNT(interaction_id) AS like_count
        FROM interactions
        WHERE type = 'like'
        GROUP BY manga_id
    ) sub
);


-- Манги, которые есть в списках чтения, но не имеют отзывов
SELECT DISTINCT
    m.title
FROM manga m
JOIN reading_list_manga rlm ON m.manga_id = rlm.manga_id
LEFT JOIN reviews r ON m.manga_id = r.manga_id
WHERE r.review_id IS NULL;


-- Ранжирование манг по среднему рейтингу 
SELECT
    m.title,
    AVG(r.rating) AS avg_rating,
    RANK() OVER (ORDER BY AVG(r.rating) DESC) AS rating_rank
FROM manga m
LEFT JOIN reviews r ON m.manga_id = r.manga_id
GROUP BY m.title;


-- Средний рейтинг манги и отклонение от общего среднего
SELECT
    m.title,
    AVG(r.rating) AS manga_avg,
    AVG(AVG(r.rating)) OVER () AS overall_avg,
    AVG(r.rating) - AVG(AVG(r.rating)) OVER () AS deviation
FROM manga m
LEFT JOIN reviews r ON m.manga_id = r.manga_id
GROUP BY m.title;


-- Количество манг в каждом списке чтения с оконной функцией
SELECT
    rl.name AS reading_list,
    COUNT(rlm.manga_id) AS manga_count,
    SUM(COUNT(rlm.manga_id)) OVER () AS total_manga_in_lists
FROM reading_lists rl
LEFT JOIN reading_list_manga rlm ON rl.list_id = rlm.list_id
GROUP BY rl.name;


-- Пользователи, которые лайкнули больше манг, чем средний пользователь
SELECT
    u.username,
    COUNT(i.interaction_id) AS likes_count
FROM users u
JOIN interactions i ON u.user_id = i.user_id
WHERE i.type = 'like'
GROUP BY u.username
HAVING COUNT(i.interaction_id) > (
    SELECT AVG(like_count)
    FROM (
        SELECT COUNT(interaction_id) AS like_count
        FROM interactions
        WHERE type = 'like'
        GROUP BY user_id
    ) avg_likes
);


-- Авторы и средний рейтинг их манг
SELECT
    a.name AS author_name,
    AVG(r.rating) AS avg_rating
FROM authors a
JOIN manga_authors ma ON a.author_id = ma.author_id
JOIN manga m ON ma.manga_id = m.manga_id
LEFT JOIN reviews r ON m.manga_id = r.manga_id
GROUP BY a.name;


-- Жанры, у которых средний рейтинг выше общего среднего
SELECT
    g.name AS genre_name,
    AVG(r.rating) AS avg_rating
FROM genres g
JOIN manga_genres mg ON g.genre_id = mg.genre_id
JOIN manga m ON mg.manga_id = m.manga_id
JOIN reviews r ON m.manga_id = r.manga_id
GROUP BY g.name
HAVING AVG(r.rating) > (
    SELECT AVG(rating)
    FROM reviews
);


-- Манги, которые находятся хотя бы в двух списках чтения
SELECT
    m.title,
    COUNT(rlm.list_id) AS list_count
FROM manga m
JOIN reading_list_manga rlm ON m.manga_id = rlm.manga_id
GROUP BY m.title
HAVING COUNT(rlm.list_id) >= 2;


-- Топ-3 пользователя по количеству отзывов 
SELECT
    username,
    reviews_count,
    RANK() OVER (ORDER BY reviews_count DESC) AS review_rank
FROM (
    SELECT
        u.username,
        COUNT(r.review_id) AS reviews_count
    FROM users u
    LEFT JOIN reviews r ON u.user_id = r.user_id
    GROUP BY u.username
) sub
WHERE reviews_count > 0
ORDER BY review_rank
LIMIT 3;


-- Манги, у которых рейтинг выше среднего и есть лайки
SELECT DISTINCT
    m.title
FROM manga m
JOIN reviews r ON m.manga_id = r.manga_id
JOIN interactions i ON m.manga_id = i.manga_id
WHERE i.type = 'like'
  AND r.rating > (
      SELECT AVG(rating)
      FROM reviews
  );
