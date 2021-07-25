-- 1번 사용자의 즐겨찾기 화면 

SELECT b.name AS 식당명
	, b.imageUrl AS 식당사진
	, b.delCost AS 배달비
	, b.delTime AS 배달시간
	, b.delTime + 10 AS 최대배달시간
	, CASE WHEN starGrade IS NULL THEN 0 ELSE starGrade END AS 별점
	, CASE WHEN starCount IS NULL THEN 0 ELSE starCount END AS 리뷰수
 FROM favorites a
 LEFT JOIN ( SELECT id
	    	    , name
	    	    , delCost
	            , delTime
	    	    , imageUrl
		FROM restaurant 
		GROUP BY id ) AS b
		ON a.restaurantId = b.id
 LEFT JOIN ( SELECT id
		    ,ROUND(SUM(score) / COUNT(restaurantId), 1) AS 'starGrade'
		    ,COUNT(restaurantId) AS 'starCount'
		    ,restaurantId
		FROM review
		GROUP BY restaurantId) AS c
		ON a.restaurantId = c.restaurantId  
 WHERE a.userId=1;
