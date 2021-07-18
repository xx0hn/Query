-- 별점 높은순, 치타배달, 배달비 3000원 이하, 최소주문 15000원이하

SELECT  a.id AS 식당id
			, a.name AS 식당명
			, a.imageUrl AS 식당사진
      , a.delCost AS 배달비
      , a.delTime AS 배달시간
      , CASE WHEN delTime <= 30 THEN '치타배달' ELSE '일반배달' END AS 배달유형 
      , starGrade AS 별점
      , starCount AS 리뷰수 
  FROM restaurant a
  LEFT JOIN ( SELECT restaurantId
							, ROUND(SUM(score) / COUNT(restaurantId), 1) AS 'starGrade'
							, COUNT (restaurantId) AS 'starCount'
				          FROM review
                  GROUP BY  restaurantId ) AS b
                  ON a.id = b.restaurantId
	WHERE a.delTime <= 30 AND a.delCost <= 3000 AND a.minCost <=15000
  ORDER BY starGrade DESC;
