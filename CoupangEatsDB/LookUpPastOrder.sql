-- 1번 사용자의 과거 주문 내역 조회

SELECT f.name AS 식당명
        ,CASE WHEN a.status = 0 THEN '배달 완료' ELSE '배달 취소' END AS 배달여부
        ,e.name AS 메뉴이름
        ,a.updatedAt AS 시간
        ,f.imageUrl AS 식당사진
	,productCount AS 수량
	,productCount * e.cost AS 금액
  FROM orders a
  LEFT JOIN ( SELECT id
		FROM user
                GROUP BY id) AS b
                ON a.userId = b.id
  LEFT JOIN ( SELECT userId
	     	    , id
		FROM cart
                GROUP BY userId) AS c
                ON a.userId = c.userId
  LEFT JOIN ( SELECT cartId
	     	    , menuId
	     	    , restaurantId
		FROM cartedmenu ) AS d
                ON a.restaurantId = d.restaurantId
  LEFT JOIN ( SELECT id
	     	    , name
	     	    , COUNT(id) AS 'productCount'
	     	    , cost
		FROM menu
                GROUP BY id, name, cost) AS e
                ON e.id = d.menuId
  LEFT JOIN ( SELECT id
	     	    , name
	     	    , imageUrl
                FROM restaurant
                GROUP BY id, name, imageUrl) AS f
                ON f.id = d.restaurantId
 WHERE b.id = 1 AND f.name IS NOT NULL
 ORDER BY  a.updatedAt DESC;
