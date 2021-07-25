 -- 주문많은순 음식점 조회
 
 SELECT CASE WHEN orderCount IS NULL THEN 0 ELSE orderCount END AS 주문횟수
        , a.name AS 식당명
        , a.imageUrl AS 식당사진
        , CASE WHEN a.delTime <= 30 THEN'치타배달' ELSE '일반배달' END AS 배달유형
        , CASE WHEN starGrade IS NULL THEN 0 ELSE starGrade END AS 별점
        , CASE WHEN starCount IS NULL THEN 0 ELSE starCount END AS 리뷰수
        , a.location AS 위치
        , a.delCost AS 배달비
        , a.delTime AS 배달시간
	, a.delTime + 10 AS 최대배달시간
  FROM restaurant a
  LEFT JOIN ( SELECT id
                    , restaurantId
                    , ROUND ( SUM ( score ) / COUNT ( restaurantId ), 1) AS 'starGrade'
                    , COUNT(restaurantId) AS 'starCount'
                FROM review 
                GROUP BY restaurantId ) AS b
                ON a.id = b.restaurantId
	LEFT JOIN ( SELECT restaurantId
                     , COUNT(restaurantId) AS 'orderCount'
					      FROM orders 
                GROUP BY restaurantId ) AS c
                ON a.id = c.restaurantId
	ORDER BY orderCount DESC;
