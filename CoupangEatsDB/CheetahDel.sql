 -- 치타배달 (30분 이내에 배달되는 식당)
 
 SELECT a.id AS 식당id
      , a.name AS 식당명 
      , a.imageUrl AS 식당사진
      , starGrade AS 별점
      , starCount AS 리뷰수
      , a.delTime AS 배달시간
      , a.delCost AS 배달비
      , CASE WHEN a.delTime <= '30' THEN '치타배달' END AS 배달유형 
  FROM restaurant a
  LEFT JOIN ( SELECT id
		    , ROUND(SUM(score) / COUNT(restaurantId), 1) AS 'starGrade'
                    , COUNT(restaurantId) AS 'starCount'
                    , restaurantId
		FROM review
               GROUP BY restaurantId ) AS b
               ON a.id = b.restaurantId
  WHERE a.delTime <= '30';
