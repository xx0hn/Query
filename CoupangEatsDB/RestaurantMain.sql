SELECT a.id AS 식당id
       , a.name AS 식당명 
       , starGrade AS 별점
       , starCount AS 리뷰수
       , delTime AS 배달시간
       , a.delTime + 10 AS 최대배달시간
       , delCost AS 배달비
       , minCost AS 최소주문 
       , c.id AS 메뉴id
       , c.name AS 메뉴명
       , c.imageUrl AS 메뉴사진
       , c.cost AS 가격
       , c.contents AS 메뉴설명
  FROM restaurant a 
  LEFT JOIN ( SELECT id
	       , restaurantId
	       , ROUND(SUM(score) / COUNT(restaurantId), 1) AS 'starGrade'
               , COUNT(restaurantId) AS 'starCount'
		FROM review
                GROUP BY restaurantId ) AS b
                ON a.id = b.restaurantId
  LEFT JOIN ( SELECT id
		    , restaurantId
		    , name
               	    , imageUrl
                    , contents
                    , cost
		FROM menu ) AS c
		ON a.id = c.restaurantId
 WHERE a.id = 1
 ORDER BY c.id ASC;
