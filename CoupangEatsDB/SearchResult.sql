 -- 검색어 검색 결과
 
SELECT d.name AS 검색
      , a.id AS 식당id
      , a.name AS 식당명
      , a.imageUrl AS 식당사진
      , CASE WHEN starGrade IS NULL THEN 0 ELSE starGrade END AS 별점
      , CASE WHEN starCount IS NULL THEN 0 ELSE starCount END AS 리뷰수
      , a.location AS 위치
      , a.delCost AS 배달비
      , a.delTime AS 배달시간
      , a.delTime + 10 AS 최대배달시간
      , CASE WHEN a.status = 0 THEN '주문가능' ELSE '주문불가' END AS 상태 
  FROM restaurant a
  LEFT JOIN ( SELECT restaurantId
                      , ROUND(SUM(score) / COUNT(restaurantId), 1) AS 'starGrade'
                      , COUNT(restaurantId) AS 'starCount'
                FROM review
                GROUP BY restaurantId ) AS b
                ON a.id = b.restaurantId
  LEFT JOIN ( SELECT id
                    , restaurantId
                FROM category ) AS c
                ON a.id = c.restaurantId
  LEFT JOIN ( SELECT searchId
                    , name
                    , categoryId
                FROM Search
                GROUP BY categoryId) AS d
                ON c.id = d.categoryId
  WHERE d.categoryId = 13;
