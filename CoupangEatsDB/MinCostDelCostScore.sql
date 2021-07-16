-- 최소주문, 배달비, 별점 높은순 조회

SELECT a.id AS 식당id
			, a.name AS 식당명
      , a.imageUrl AS 식당사진
      , starGrade AS 별점
      , starCount AS 리뷰수
      , a.delCost AS 배달비
      , a.delTime AS 배달시간
      , CASE WHEN a.delTime <= '30' THEN '치타배달' ELSE '일반배달' END AS 배달유형
  FROM restaurant a
  LEFT JOIN ( SELECT id
							       , restaurantId
                     , ROUND(SUM(score) / COUNT(restaurantId), 1) AS 'starGrade'
                     , COUNT(restaurantId) AS 'starCount'
				        FROM review 
                GROUP BY restaurantId ) AS b
                ON a.id = b.restaurantId
	WHERE a.minCost <= 12000 AND a.delCost <=3000
  ORDER BY starGrade desc;