-- 새로 들어왔어요! 별점 높은순, 치타배달, 배달비 2000원 이하, 최소주문 15000원이하

SELECT a.id AS 식당id
      , a.name AS 식당명
      , a.imageUrl AS 식당사진 
      , CASE WHEN a.delTime <=30 THEN '치타배달' ELSE '일반배달' END AS 배달유형
      , starGrade AS 별점
      , starCount AS 리뷰수
      , a.location AS 위치
      , a.delTIme AS 배달시간
      , a.delCost AS 배달비
  FROM restaurant a
  LEFT JOIN ( SELECT restaurantId
                    , ROUND (SUM(score) / COUNT (restaurantId), 1 ) AS 'starGrade'
                    , COUNT (restaurantId) AS 'starCount'
                FROM review
                GROUP BY restaurantId ) AS b
                ON a.id = b.restaurantId
  WHERE a.createdAt >= '2021-07-14 15:05:00' AND a.delTime<=30 AND a.delCost <=2000 AND a.minCost <=15000
  ORDER BY starGrade DESC;
                            
