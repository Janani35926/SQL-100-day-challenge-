USE challenge_day1_student;
DROP TABLE IF EXISTS cinemas;
CREATE TABLE cinemas
    (id SERIAL, seat_id INT);

INSERT INTO cinemas(seat_id)
VALUES
    (1),
    (0),
    (0),
    (1),
    (1),
    (1),
    (0);
-- Write a SQL query to find the id where the seat is empty
-- and both the seat immediately before and immediately after it are also empty
SELECT * FROM  cinemas;
-- 1 -->EMPTY
-- 0--> FULL
WITH seat_status AS(
                    SELECT id,
                            seat_id,
                            LAG(seat_id) OVER(ORDER BY id) AS previous_seat,
                            LEAD(seat_id) OVER(ORDER BY id) AS NXT_seat
					FROM cinemas
                    )
SELECT id,
	  seat_id,
      previous_seat,
      NXT_seat 
FROM seat_status 
WHERE seat_id=1
          AND
      previous_seat=1
          AND
      NXT_seat=1;


      