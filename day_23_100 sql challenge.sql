-- day 23/100
-- spotify
USE challenge_day1_student;

DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    user_id INT,
    song_id INT,
    play_date DATE
);

INSERT INTO spotify (user_id, song_id, play_date) VALUES
(1, 101, '2023-01-01'), -- Week 1
(2, 101, '2023-01-01'), -- Week 1
(3, 101, '2023-01-02'), -- Week 1
(7, 101, '2023-01-09'), -- Week 2
(8, 101, '2023-01-09'), -- Week 2
(1, 101, '2023-01-09'), -- Week 2
(2, 101, '2023-01-09'), -- Week 2
(3, 101, '2023-01-10'), -- Week 2
(4, 101, '2023-01-10'), -- Week 2
(5, 101, '2023-01-11'), -- Week 2
(1, 102, '2023-01-01'), -- Week 1
(2, 102, '2023-01-08'), -- Week 2
(3, 102, '2023-01-09'), -- Week 2
(4, 102, '2023-01-09'), -- Week 2
(5, 102, '2023-01-09'), -- Week 2
(1, 103, '2023-01-01'), -- Week 1
(2, 103, '2023-01-02'), -- Week 1
(3, 103, '2023-01-03'), -- Week 1
(4, 103, '2023-01-10'), -- Week 2
(5, 103, '2023-01-10'), -- Week 2
(1, 104, '2023-01-01'), -- Week 1
(2, 104, '2023-01-05'), -- Week 1
(3, 104, '2023-01-07'), -- Week 1
(4, 104, '2023-01-12'), -- Week 2
(5, 104, '2023-01-13'); -- Week 2



/*
Question:
Identifying Trending Songs:
Spotify wants to identify songs that have suddenly gained popularity within a week.

Write a SQL query to find the song_id and week_start 
date of all songs that had a play count increase of 
at least 300% from one week to the next. 
Consider weeks starting on Mondays.
*/

-- 1. each song_id play cnt for each
-- 2. each song and their last week play cnt.
SELECT * from spotify;
WITH weekly_plays AS (
                       SELECT song_id,
                       DATE_ADD(play_date, INTERVAL(1- DAYOFWEEK(play_date)) DAY) AS week_start,
                       COUNT(*) AS play_count
                       FROM spotify
                       GROUP BY song_id, week_start),

play_trend AS (
    -- Step 2: Use LAG() to get the previous week's play count for each song
    SELECT
        song_id,
        week_start,
        play_count AS current_week_play_count,
        LAG(play_count) OVER (PARTITION BY song_id ORDER BY week_start) AS previous_week_play_count
    FROM weekly_plays
)
SELECT song_id,
       week_start,
       current_week_play_count,
       previous_week_play_count,
       CASE WHEN
                 previous_week_play_count>0
			THEN
                (current_week_play_count/previous_week_play_count)*100
			ELSE null
            END AS count_increase
FROM play_trend 
	WHERE previous_week_play_count IS NOT NULL
           AND
	 (current_week_play_count/previous_week_play_count)*100>=300;
    
       
       

                   

                       







   
