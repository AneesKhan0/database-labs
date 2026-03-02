# Lab 2 — Learning Notes

## Overview
E-commerce database with 4 tables: customers, products, orders, order_items

## Key Learnings

### SQL Concepts Practiced
1. **SELECT & Columns** — listing specific columns vs SELECT *
2. **WHERE Filtering** — comparisons, BETWEEN, IN, LIKE, IS NULL
3. **ORDER BY & LIMIT** — sorting and top-N results
4. **CASE WHEN** — conditional columns (CRITICAL/URGENT/NORMAL)
5. **Computed Columns** — price * 0.80 for discounts using ROUND()
6. **NULL Handling** — IS NULL vs = NULL (= NULL is always wrong)

### Biggest Surprises
- NULL is not a value — it's the absence of one
- SQL execution order is different from writing order (FROM → WHERE → SELECT → ORDER BY → LIMIT)
- WHERE runs before SELECT so aliases don't work in WHERE

### Challenges Faced
1. **Challenge:** WHERE shipped_date = NULL returned zero rows
   - **Solution:** Changed to IS NULL
   - **Lesson:** Never use = NULL, always IS NULL

2. **Challenge:** Wrong path when loading SQL file in psql
   - **Solution:** Used find ~ -name "lab2" to locate correct path
   - **Lesson:** Always verify file paths before running \i command

## AI Usage
- Used Claude 3 times during this lab
- Most helpful: Understanding NULL handling and CASE WHEN logic
- Verified all AI responses by running queries myself

## GitHub
- Repo: github.com/AneesKhan0/database-labs
- Files: ecommerce_setup.sql, queries.sql, NOTES.md

## Next Steps
- Learn GROUP BY and aggregate functions (Week 3)
- Practice window functions
- Understand when and how to use indexes
