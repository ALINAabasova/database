# Backup and Restore Strategy (PostgreSQL)

This document describes how to back up and restore the **Manga Library and Reader Platform** database.

## 1. Assumptions

- Database name: `manga_library_db`
- PostgreSQL user: `postgres` 
- Database schema is created from `schema.sql`
- Initial data is loaded from `seed.sql`
- Advanced queries are stored in `queries_basic.sql` and `queries_advanced.sql`

---

## 2. Creating a Backup

### 2.1. Plain SQL Backup

A plain SQL backup stores the database structure and data in a readable SQL file.

```bash
pg_dump -U postgres -d manga_library_db -F p -f manga_library_db_backup.sql
```

## 3. Backup Schedule

- Full database backup: once per day
- Schema backup: after any structural changes
- Seed and query files: stored and versioned in Git