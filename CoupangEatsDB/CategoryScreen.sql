-- 카테고리 선택 후 보이는 화면

SELECT c.name AS 카테고리명
       ,a.id, a.name AS 식당명
       ,a.imageUrl AS 사진
       ,a.delCost AS 배달비
       ,starGrade AS 별점
       ,starCount AS 리뷰수
 FROM restaurant a
 LEFT JOIN ( SELECT id 
		   ,ROUND ( SUM(score) / COUNT(restaurantId), 1) AS 'starGrade'
                   ,COUNT(restaurantId) AS 'starCount'
                   ,restaurantId
              FROM review
              GROUP BY restaurantId) AS b
              ON a.id = b.restaurantId
              
  LEFT JOIN ( SELECT id, name, restaurantId
		FROM category
                GROUP BY id, name, restaurantId) AS c
                ON a.id = c.restaurantId

  LEFT JOIN ( SELECT restaurantId, imageUrl
                FROM menu
                GROUP BY restaurantId) AS d
                ON d.restaurantId = a.id
  WHERE c.id = 1;
