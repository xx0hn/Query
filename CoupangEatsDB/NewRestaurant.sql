-- 새로 들어왔어요! 새로 추가된 식당 조회

SELECT a.id
	  , a.name AS 식당명
          , CASE WHEN a.createdAt > '2021-07-14 15:06:00' THEN '신규' END AS 상태
          , a.delCost AS 배달비
          , a.imageUrl AS 식당사진
          , a.delTime AS 배달시간
          , a.createdAt AS 등록시간
  FROM restaurant a
  WHERE a.createdAt > '2021-07-14 15:06:00'
  ORDER BY a.createdAt DESC;
