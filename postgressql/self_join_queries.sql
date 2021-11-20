SELECT
    *
FROM sandbox.public.numbers
ORDER BY id ASC;

--match all of the smaller numbers
SELECT
    *
FROM sandbox.public.numbers as n1 
    left join  sandbox.public.numbers as n2
        on n1.id > n2.id 
ORDER BY n1.id ASC;

--match to the next value
SELECT
    *
FROM sandbox.public.numbers as n1 
    INNER JOIN sandbox.public.numbers as n2
        on n1.id > n2.id 
ORDER BY n1.id ASC;

-------------------------------------------------------------------------
-- Create a table of numbers with a query based on base of 10 digits 
-------------------------------------------------------------------------
DROP TABLE IF EXISTS Digits;

CREATE TABLE Digits  
(
    digit int
);

INSERT INTO Digits(digit) values
    (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);

SELECT d3.digit * 100 + d2.digit * 10 + d1.digit + 1 AS n
FROM Digits AS d1
    ,Digits AS d2
    ,Digits AS d3
ORDER BY n
-------------------------------------------------------------------------

