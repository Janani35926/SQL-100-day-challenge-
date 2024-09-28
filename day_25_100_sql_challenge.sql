-- 25/100 sql challenge
USE challenge_day1_student;
DROP TABLE IF EXISTS Friends;
CREATE TABLE Friends (
    id INT,
    friend_id INT 
);


DROP TABLE IF EXISTS Ratings;
CREATE TABLE Ratings (
    id INT PRIMARY KEY,
    rating INT
);

INSERT INTO Friends (id, friend_id)
VALUES
(1, 2),
(1, 3),
(2, 3),
(3, 4),
(4, 1),
(4, 2),
(5,NULL),
(6,NULL);


INSERT INTO Ratings (id, rating)
VALUES
(1, 85),
(2, 90),
(3, 75),
(4, 88),
(5, 82),
(6, 91);





SELECT * FROM Friends;
SELECT * FROM Ratings;

-- MNC data analyst interview 

-- Retrieve all Ids of a person whose rating is greater than friend's id
-- If person does not have any friend, retrieve only their id only if rating greater than 85

SELECT R.rating, 
       F.*,
       R1.id
FROM Friends F 
LEFT JOIN  Ratings R 
       ON
F.id=R.id
LEFT JOIN Ratings R1
      ON
F.friend_id=R1.id
WHERE (F.friend_id IS NOT NULL 
                              AND
                                 R.rating>R1.rating)
	 OR 
        (F.friend_id IS NULL  AND R.rating>85);
        
        

