CREATE TABLE Table1
    (Country varchar(3), City varchar(13), City_Rank int, Artist varchar(15), Artist_Rank int, Movie varchar(20), Movie_Rank int)
;
    
INSERT INTO Table1
    (Country, City, City_Rank, Artist, Artist_Rank, Movie, Movie_Rank)
VALUES
    ('INDIA', 'HYDERABAD', 2, 'M.F.HUSSSAIN', 2, 'Meenaxi', 3),
    ('CANADA', 'TORONTO', 3, 'UNKNOWN', 3, 'IT', 1),
    ('AUSI', 'SYDNEY', 1, 'UNKNOWN1', 1, 'IT-2', 2),
    ('SINGAPORE', 'MALAYSIA', 2, 'UNKNOWN2', 3, 'FANTASTIC BEASTS', 2),
    ('RUSSIA', 'MOSCOW', 1, 'UNKNOWN3', 2, 'JUNGLE BOOK', 3),
    ('INDIA', 'VIZAG', 3, 'JACQUELINE', 1, 'ROY', 1)
;




With unpivot_me As (
SELECT Country, 'City' as category, y as cat_value, City_Rank as rank_value
FROM Table1
UNION ALL
SELECT Country, 'Artist' as category, Artist as cat_value, Artist_Rank as rank_value
FROM Table1
UNION ALL
SELECT Country, 'Movie' as category, Movie as cat_value, Movie_Rank as rank_value
FROM Table1
)


SELECT Country,
       Max( case when category = 'City' Then cat_value End) As Best_Ranked_City,
       Max( case when category = 'Artist' Then cat_value End) As Best_Ranked_Artist,
       Max( case when category = 'Movie' Then cat_value End) As Best_Ranked_Movie
FROM unpivot_me
WHERE rank_value = 1
GROUP BY Country
