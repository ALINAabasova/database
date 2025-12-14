-- Users
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    is_active BOOLEAN DEFAULT TRUE
);

-- User Profiles (1-to-1)
CREATE TABLE user_profiles (
    profile_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL UNIQUE REFERENCES users(user_id),
    avatar_url VARCHAR(255),
    bio TEXT,
    preferences JSON
);

-- Manga
CREATE TABLE manga (
    manga_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    release_year INT,
    status VARCHAR(50),
    cover_image_url VARCHAR(255),
    average_rating NUMERIC
);

-- Authors
CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    bio TEXT,
    birth_date DATE
);

-- Genres
CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

-- Junction tables
CREATE TABLE manga_authors (
    manga_id INT NOT NULL REFERENCES manga(manga_id),
    author_id INT NOT NULL REFERENCES authors(author_id),
    PRIMARY KEY (manga_id, author_id)
);

CREATE TABLE manga_genres (
    manga_id INT NOT NULL REFERENCES manga(manga_id),
    genre_id INT NOT NULL REFERENCES genres(genre_id),
    PRIMARY KEY (manga_id, genre_id)
);

-- Reviews
CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id),
    manga_id INT NOT NULL REFERENCES manga(manga_id),
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Reading Lists
CREATE TABLE reading_lists (
    list_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id),
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Reading List Manga (M:N)
CREATE TABLE reading_list_manga (
    list_id INT NOT NULL REFERENCES reading_lists(list_id),
    manga_id INT NOT NULL REFERENCES manga(manga_id),
    PRIMARY KEY (list_id, manga_id)
);

-- Interactions
CREATE TABLE interactions (
    interaction_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id),
    manga_id INT NOT NULL REFERENCES manga(manga_id),
    type VARCHAR(50), 
    created_at TIMESTAMP DEFAULT NOW()
);
