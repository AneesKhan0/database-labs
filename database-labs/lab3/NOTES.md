# Lab 3 — Learning Notes

## Overview
Extended the e-commerce database with a new user_sessions table (56 records)
to practice aggregations, window functions, and CTEs on real behavioural data.

## Key Learnings

### New SQL Concepts Practiced
1. **Aggregate Functions** — COUNT, SUM, AVG, MIN, MAX to summarise data
2. **GROUP BY** — grouping rows and applying aggregates per group
3. **HAVING** — filtering groups after aggregation (not before like WHERE)
4. **Window Functions** — ROW_NUMBER, RANK, DENSE_RANK, LAG for analytics
5. **CTEs** — breaking complex queries into readable named steps with WITH
6. **NULLIF** — preventing division-by-zero errors in percentage calculations
7. **COALESCE** — replacing NULL with a fallback value (e.g. 0 for unspent)

### WHERE vs HAVING — The Key Difference
- WHERE filters individual rows BEFORE grouping
- HAVING filters groups AFTER aggregation
- You CANNOT use COUNT() or SUM() inside WHERE — use HAVING instead

### Window Functions vs GROUP BY
- GROUP BY collapses rows into one summary row per group
- Window functions ADD a computed column while keeping ALL rows visible
- Use GROUP BY for summaries, window functions for rankings and trends

### PARTITION BY
- Divides data into independent groups for window functions
- Like separate leaderboards — each group gets its own ranking from 1
- Without PARTITION BY, window function runs across all rows globally

### Biggest Surprises
- NULL = NULL is false in SQL — always use IS NULL
- NULLIF(value, 0) turns 0 into NULL to avoid division errors
- SUM(SUM(col)) OVER () is valid — window function inside aggregate
- LAG() returns NULL for the first row — there is nothing before it

## Challenges Faced

1. **Challenge:** GROUP BY error — column must appear in GROUP BY or aggregate
   - **Solution:** Every SELECT column must be in GROUP BY or inside AGG()
   - **Lesson:** GROUP BY collapses rows — ambiguous columns are not allowed

2. **Challenge:** PARTITION BY was confusing at first
   - **Solution:** Think of it as separate classrooms with independent rankings
   - **Lesson:** PARTITION BY restarts the window function for each group

3. **Challenge:** LAG appeared 3 times in Query 8 — seemed inefficient
   - **Solution:** Wrapped in a CTE to compute once and reuse
   - **Lesson:** CTEs prevent recalculation and make queries more readable

## Query Highlights

- **Query 9** — Customer segmentation: 2 VIP customers drive 43.7% of revenue
- **Query 10** — Funnel analysis: Kamran Javed browsed twice, bought nothing (churn risk)
- **Query 8** — November 2024 had 132.9% revenue growth vs October

## Performance Notes
- Query 3 (monthly revenue): 0.178ms — Seq Scan + HashAggregate + Sort
- Query 9 (CTE segmentation): 0.621ms — added Hash Left Join + WindowAgg
- New operations this week: HashAggregate (GROUP BY) and WindowAgg (OVER)

## AI Usage
- Used Claude 3 times during this lab
- Most helpful: PARTITION BY analogy and NULLIF explanation
- All AI responses verified by running queries and checking outputs
- Modified every AI suggestion before using it

## GitHub
- Repo: github.com/AneesKhan0/database-labs
- Files: lab3/queries.sql, lab3/NOTES.md

## Next Steps
- Week 4: JOINs — already had early exposure in Queries 2, 4, 9, 10
- Learn about indexes and when to create them
- Practice subqueries vs CTEs — when to use each
