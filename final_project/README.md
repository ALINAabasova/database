# Manga Library and Reader Platform

## 1. Project Overview

This project implements a **full-featured relational database system** for managing **manga library and reader interactions**. The system stores detailed information about:

- Manga titles and their descriptions
- Authors and their biographies
- Genres and categorizations
- Users and their profiles
- User interactions with manga (reviews, reading lists, likes, favorites)

The platform allows users to browse, review, and organize manga, while providing analytics and reporting capabilities.

The project is designed to satisfy the final project requirements:

- ER-diagram and normalized database schema  
- PostgreSQL implementation  
- Basic and advanced SQL queries  
- Demonstration of transactions and indexing  
- Backup and restore strategy  

---

## 2. Functional Scope

### Core Features

- **Users**
  - Register, login, and manage profiles
  - Create reading lists
  - Leave reviews for manga
  - Interact with manga (like, favorite, mark as read)

- **Manga**
  - Store detailed information about manga titles
  - Link manga to authors (M:N) and genres (M:N)
  - Track average ratings from reviews

- **Authors**
  - Store author details and biographies
  - Linked to multiple manga titles (M:N)

- **Genres**
  - Define genres with unique names
  - Link multiple manga to each genre (M:N)

- **Reviews**
  - Users can rate and comment on manga
  - Rating validation (1–5)

- **Reading Lists**
  - Users can create multiple reading lists
  - Reading lists can contain multiple manga (M:N)

- **Interactions**
  - Users can like, favorite, or mark manga as read
  - Interaction history is stored with timestamp

---

### Extended Features

- **User Profiles**
  - 1-to-1 relation with users
  - Stores avatar, bio, and preferences

- **Analytics**
  - Aggregated data for ratings and reading lists
  - Reports using GROUP BY, JOINs, and subqueries

- **Normalization**
  - All reference data stored separately (authors, genres)
  - Many-to-many relationships resolved via junction tables
  - All tables in Third Normal Form (3NF)

---

## 3. ER Model – Main Entities and Relationships

### Core Entities

- **User**
  - 1-to-1 with `user_profiles`
  - 1-to-Many with `reviews` and `reading_lists`
  - M-to-N with `manga` via `interactions`

- **Manga**
  - 1-to-Many with `reviews`
  - M-to-N with `authors` via `manga_authors`
  - M-to-N with `genres` via `manga_genres`
  - M-to-N with `reading_lists` via `reading_list_manga`
  - M-to-N with `users` via `interactions`

- **Author**
  - M-to-N with `manga` via `manga_authors`

- **Genre**
  - M-to-N with `manga` via `manga_genres`

- **Review**
  - FK to `users` and `manga`

- **Reading List**
  - FK to `users`
  - M-to-N with `manga` via `reading_list_manga`

- **Interaction**
  - FK to `users` and `manga`

---

## 4. Normalization

- All reference and junction tables are separate:
  - `authors`, `genres`, `manga_authors`, `manga_genres`, `reading_list_manga`, `interactions`
- Non-key attributes depend only on the full primary key
- Ensures **Third Normal Form (3NF)** compliance

---

## 5. Implementation

- **DDL**: `schema.sql` – PostgreSQL implementation of all tables, keys, and constraints
- **Dataset**: `dataset.sql` – for filling and demonstration
- **Queries**:
  - `queries_basic.sql` – SELECT, JOIN, WHERE
  - `queries_advanced.sql` – GROUP BY, subqueries, analytics
- **Indexes**: created on PK, FK, and frequently queried columns
- **Backup/Restore**:
  - `pg_dump` for backups
  - `pg_restore` for restoration
  - Strategy: full backup weekly, incremental before major changes

---

## 6. Project Structure

```text
final_project/
  README.md
  schema.sql
  dataset.sql
  queries_basic.sql
  queries_advanced.sql
  backup.md
  er_diagram.png

---

## 7. Presentation

The project presentation is available at the following link: 

https://www.canva.com/design/DAG7f_YpJ9Y/8AdhZd5uSPVHQpkmfIEMZg/edit?utm_content=DAG7f_YpJ9Y&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton

---

## 8. Academic Pledge

I pledge that I will meet all project deadlines as required by the course.
I understand that failure to meet deadlines or course requirements may result in disciplinary action, and I accept full responsibility for this.