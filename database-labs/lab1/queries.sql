--Lab 1: Analytical Queries
--Author:Muhammad Anees
-- Query 1:Books by rating 
SELECT title, author, rating
FROM books_read
ORDER BY rating DESC;
--Query 2:Average pages by category
SELECT category, AVG(pages) as avg_pages
FROM books_read
GROUP BY category;
--Query 3:Top 3 Longest Books
SELECT
    title,
    author,
    pages,
    RANK() OVER (ORDER BY pages DESC) AS length_rank
FROM books_read
ORDER BY pages DESC
LIMIT 3;
-- Show what % of your total pages each long book represents
SELECT
    title,
    pages,
    ROUND(pages * 100.0 / SUM(pages) OVER (), 1) AS pct_of_total_pages
FROM books_read
ORDER BY pages DESC
LIMIT 3;

-- Top book PER category (not just overall)
SELECT * FROM (
    SELECT
        title, category, pages,
        RANK() OVER (PARTITION BY category ORDER BY pages DESC) AS rank_in_category
    FROM books_read
) ranked
WHERE rank_in_category = 1;
--Query 4: Average Rating by Category
SELECT
    category,
    COUNT(*)                        AS books_read,
    ROUND(AVG(rating), 2)           AS avg_rating,
    MIN(rating)                     AS lowest_rating,
    MAX(rating)                     AS highest_rating
FROM books_read
GROUP BY category
ORDER BY avg_rating DESC;
-- Only show categories where you've rated books above 4.0 on average
SELECT category, ROUND(AVG(rating), 2) AS avg_rating
FROM books_read
GROUP BY category
HAVING AVG(rating) > 4.0;  -- HAVING filters AFTER grouping (WHERE filters BEFORE)

-- Add a letter grade to each category
SELECT
    category,
    ROUND(AVG(rating), 2) AS avg_rating,
    CASE
        WHEN AVG(rating) >= 4.5 THEN 'A'
        WHEN AVG(rating) >= 4.0 THEN 'B'
        ELSE 'C'
    END AS grade
FROM books_read
GROUP BY category;
--Query 5: Reading Streak (Consecutive Months with Books)
WITH monthly_reading AS (
    -- Step 1: Find every distinct month you finished at least one book
    SELECT DISTINCT
        DATE_TRUNC('month', date_finished) AS read_month
    FROM books_read
),
month_gaps AS (
    -- Step 2: For each month, check if the PREVIOUS month also had reading
    SELECT
        read_month,
        LAG(read_month) OVER (ORDER BY read_month) AS prev_month,
        CASE
            WHEN read_month - INTERVAL '1 month' =
                 LAG(read_month) OVER (ORDER BY read_month)
            THEN 0  -- Consecutive month, same streak
            ELSE 1  -- Gap found, new streak starts
        END AS new_streak_flag
    FROM monthly_reading
),
streaks AS (
    -- Step 3: Assign a streak group ID by summing the flags cumulatively
    SELECT
        read_month,
        SUM(new_streak_flag) OVER (ORDER BY read_month) AS streak_group
    FROM month_gaps
)
-- Step 4: Count months per streak group and show the longest
SELECT
    streak_group,
    COUNT(*)              AS streak_length_months,
    MIN(read_month)       AS streak_start,
    MAX(read_month)       AS streak_end
FROM streaks
GROUP BY streak_group
ORDER BY streak_length_months DESC
LIMIT 1;
--Query 6: Authors You've Read Multiple Times
SELECT
    author,
    COUNT(*)                                    AS books_count,
    STRING_AGG(title, ' | ' ORDER BY date_finished) AS titles,
    ROUND(AVG(rating), 2)                       AS avg_rating
FROM books_read
GROUP BY author
HAVING COUNT(*) > 1
ORDER BY books_count DESC;
```

**Step-by-step logic:**
- `GROUP BY author` groups all books by the same author together
- `HAVING COUNT(*) > 1` filters *after* grouping to keep only authors with more than 1 book — `WHERE` can't do this because it runs before grouping
- `STRING_AGG(title, ' | ')` concatenates all titles in a group into one string like `"Book A | Book B"` — very useful for showing detail without multiple rows

**Advanced feature — HAVING vs WHERE:** This trips up most beginners.
```
WHERE  → filters individual rows BEFORE grouping
HAVING → filters grouped results AFTER grouping
-- Find authors where your average rating is consistently high
SELECT author, COUNT(*) AS books, ROUND(AVG(rating), 2) AS avg_rating
FROM books_read
GROUP BY author
HAVING COUNT(*) > 1 AND AVG(rating) >= 4.5;

-- See which category a repeat-author belongs to most
SELECT author, category, COUNT(*) AS count
FROM books_read
GROUP BY author, category
HAVING COUNT(*) > 1;

