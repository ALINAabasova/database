BEGIN;

-- =========================
-- USERS
-- =========================
INSERT INTO users (user_id, username, email, password_hash, created_at, is_active) VALUES
(1, 'alina', 'alina@mail.com', 'hash1', NOW(), true),
(2, 'john_doe', 'john@mail.com', 'hash2', NOW(), true),
(3, 'manga_fan', 'fan@mail.com', 'hash3', NOW(), true),
(4, 'reader99', 'reader99@mail.com', 'hash4', NOW(), true),
(5, 'otaku_girl', 'otaku@mail.com', 'hash5', NOW(), true),
(6, 'casual_reader', 'casual@mail.com', 'hash6', NOW(), true);

-- =========================
-- USER PROFILES
-- =========================
INSERT INTO user_profiles (profile_id, user_id, avatar_url, bio, preferences) VALUES
(1, 1, 'https://img.com/a1.png', 'Loves manga', '{"theme":"dark"}'),
(2, 2, 'https://img.com/a2.png', 'Anime fan', '{"theme":"light"}'),
(3, 3, 'https://img.com/a3.png', 'Shonen reader', '{"theme":"dark"}'),
(4, 4, 'https://img.com/a4.png', 'Reads sometimes', '{"theme":"light"}'),
(5, 5, 'https://img.com/a5.png', 'Shojo & romance', '{"theme":"pink"}'),
(6, 6, 'https://img.com/a6.png', 'Just started manga', '{"theme":"default"}');

-- =========================
-- MANGA
-- =========================
INSERT INTO manga (manga_id, title, description, release_year, status, cover_image_url, average_rating) VALUES
(1, 'Naruto', 'Ninja story', 1999, 'completed', 'naruto.jpg', 4.5),
(2, 'Attack on Titan', 'Humans vs Titans', 2009, 'completed', 'aot.jpg', 4.8),
(3, 'One Piece', 'Pirate adventure', 1997, 'ongoing', 'op.jpg', 4.9),
(4, 'Death Note', 'Notebook of death', 2003, 'completed', 'dn.jpg', 4.7),
(5, 'Demon Slayer', 'Slaying demons', 2016, 'completed', 'ds.jpg', 4.6),
(6, 'Jujutsu Kaisen', 'Curses and sorcerers', 2018, 'ongoing', 'jjk.jpg', 4.6),
(7, 'Bleach', 'Soul reapers', 2001, 'completed', 'bleach.jpg', 4.4),
(8, 'Tokyo Ghoul', 'Dark fantasy', 2011, 'completed', 'tg.jpg', 4.3);

-- =========================
-- AUTHORS
-- =========================
INSERT INTO authors (author_id, name, bio, birth_date) VALUES
(1, 'Masashi Kishimoto', 'Naruto author', '1974-11-08'),
(2, 'Hajime Isayama', 'Attack on Titan author', '1986-08-29'),
(3, 'Eiichiro Oda', 'One Piece author', '1975-01-01'),
(4, 'Tsugumi Ohba', 'Death Note writer', '1969-01-01'),
(5, 'Koyoharu Gotouge', 'Demon Slayer author', '1989-05-05'),
(6, 'Gege Akutami', 'Jujutsu Kaisen author', '1992-02-26');

-- =========================
-- GENRES
-- =========================
INSERT INTO genres (genre_id, name, description) VALUES
(1, 'Action', 'Action-packed'),
(2, 'Adventure', 'Adventure stories'),
(3, 'Fantasy', 'Fantasy elements'),
(4, 'Dark Fantasy', 'Dark themes'),
(5, 'Supernatural', 'Supernatural powers'),
(6, 'Drama', 'Emotional stories');

-- =========================
-- MANGA_AUTHORS
-- =========================
INSERT INTO manga_authors (manga_id, author_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 1),
(8, 2);

-- =========================
-- MANGA_GENRES
-- =========================
INSERT INTO manga_genres (manga_id, genre_id) VALUES
(1, 1), (1, 2),
(2, 1), (2, 4),
(3, 1), (3, 2),
(4, 4), (4, 6),
(5, 1), (5, 3),
(6, 1), (6, 5),
(7, 1), (7, 3),
(8, 4), (8, 6);

-- =========================
-- READING LISTS
-- =========================
INSERT INTO reading_lists (list_id, user_id, name, created_at) VALUES
(1, 1, 'Favorites', NOW()),
(2, 1, 'To Read', NOW()),
(3, 2, 'Best Manga', NOW()),
(4, 3, 'Shonen List', NOW()),
(5, 4, 'Dark Manga', NOW()),
(6, 5, 'Romance Picks', NOW());

-- =========================
-- READING LIST MANGA
-- =========================
INSERT INTO reading_list_manga (list_id, manga_id) VALUES
(1, 1), (1, 2),
(2, 3),
(3, 4), (3, 5),
(4, 6), (4, 7),
(5, 8),
(6, 1);

-- =========================
-- REVIEWS
-- =========================
INSERT INTO reviews (review_id, user_id, manga_id, rating, comment, created_at) VALUES
(1, 1, 1, 5, 'Classic!', NOW()),
(2, 2, 2, 4, 'Very intense', NOW()),
(3, 3, 3, 5, 'Masterpiece', NOW()),
(4, 4, 4, 4, 'Very smart', NOW()),
(5, 5, 5, 5, 'Beautiful art', NOW()),
(6, 6, 6, 4, 'Great fights', NOW());

-- =========================
-- INTERACTIONS
-- =========================
INSERT INTO interactions (interaction_id, user_id, manga_id, type, created_at) VALUES
(1, 1, 1, 'like', NOW()),
(2, 1, 2, 'bookmark', NOW()),
(3, 2, 3, 'like', NOW()),
(4, 3, 4, 'like', NOW()),
(5, 4, 5, 'bookmark', NOW()),
(6, 5, 6, 'like', NOW());

COMMIT;
