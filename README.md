# 100 Days SQL Challenge - Najirh Community
## Status:

**Challenge Duration:** 100 Days
**Completed:** 20 Days
Each day I have worked on solving queries and learning different aspects of MySQL. Below is a summary of the topics covered during the first 20 days, along with additional learnings that I plan to expand further in the upcoming days.

### MySQL Learnings

- **MySQL Data Types (with a focus on `SERIAL`):**
  - **`SERIAL`**: An alias for `BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE`. It simplifies the process of assigning unique, auto-incrementing values to a column, usually for primary keys.
  
- **Regular Expressions (`REGEX`):**
  - Learned how to use regular expressions to match patterns in strings within SQL queries, useful for validating or extracting specific data formats such as emails, phone numbers, etc.

- **`COALESCE`:**
  - This function helps return the first non-null value in a list of expressions. It's incredibly useful when dealing with datasets that may contain null values and you need to provide default fallbacks.

- **Format Handling:**
  - Understanding how to handle different data formats, especially when formatting numerical or date data for better presentation or calculations.

- **Default Frame Clause:**
  - Familiarized with the default frame clause, especially in window functions (e.g., `ROW_NUMBER`, `RANK`). Understanding how frames work is critical for defining the set of rows that a window function should act upon.

- **Self Join:**
  - Learned how to use self joins to join a table with itself to compare rows within the same table.

- **Multiple Joins in a Single Query:**
  - Gained experience using multiple types of joins (INNER, LEFT, RIGHT) in a single query to combine data from different tables based on relationships.

- **Window Functions:**
  - Explored how window functions like `ROW_NUMBER`, `RANK`, and `LEAD`/`LAG` can be used for performing calculations across a set of table rows that are related to the current row.
 
  As part of my **100-day SQL challenge**, I tackled interview problems from various companies across different domains. One of the key challenges I faced was handling time series data effectively. Managing and retrieving time-based results according to specific conditions proved to be particularly difficult.

**Key difficulties included:**

- Handling missing or irregular time intervals.
- Applying complex conditions over time windows (e.g., calculating trends or moving averages).
- Ensuring query performance remains efficient when dealing with large time-based datasets.
