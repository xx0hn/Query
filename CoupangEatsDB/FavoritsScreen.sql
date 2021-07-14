-- 1번 사용자의 즐겨찾기 화면 

SELECT b.name as 식당명
		  ,b.delCost as 배달비
      ,b.imageUrl as 식당사진
      ,starGrade as 별점
      ,starCount as 리뷰수
FROM favorites a
LEFT JOIN ( SELECT id, name, delCost, imageUrl
			      FROM restaurant 
            GROUP BY id, name, delCost, imageUrl) AS b
            ON a.restaurantId = b.id
              
LEFT JOIN ( SELECT id
					      	,ROUND(SUM(score) / COUNT(restaurantId), 1) AS 'starGrade'
                  ,COUNT(restaurantId) AS 'starCount'
                  ,restaurantId
			      FROM review
            GROUP BY restaurantId) AS c
            ON a.restaurantId = c.restaurantId
              
WHERE a.userId=1;
