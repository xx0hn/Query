-- 3번 사용자의 카트 조회

  SELECT a.id AS 사용자id
	    , a.location AS 사용자위치
            , d.name AS 식당명
            , e.name AS 메뉴명
            , e.cost AS 가격
            , couponCount AS '사용가능쿠폰(장)'
            , SUM(e.cost) AS 주문금액
            , d.delCost AS 배달비
            , SUM(e.cost) + d.delCost AS 총결제금액
   FROM user a
   LEFT JOIN ( SELECT id
	      , userId
	      FROM cart
	      GROUP BY userId) AS b
	      ON a.id = b.userId
   LEFT JOIN ( SELECT id
	      	      , cartId
	      	      , menuId
                      , restaurantId
		FROM cartedmenu
		GROUP BY cartId ) AS c
		ON b.id = c.cartId
   LEFT JOIN ( SELECT id
		     , name
		     , delCost
		FROM restaurant
		GROUP BY id ) AS d
		ON c.restaurantId = d.id
   LEFT JOIN ( SELECT id
		      , name
		      , restaurantId
		      , cost
		FROM menu
		GROUP BY restaurantId ) AS e
		ON c.menuId = e.id
   LEFT JOIN ( SELECT id
		     , userId
		     , name
		     , COUNT(userId) AS 'couponCount'
		FROM coupon
		GROUP BY userId ) AS f
		ON a.id = f.userId
   LEFT JOIN ( SELECT id
		     , userId
		     , status
		FROM cart
		GROUP BY userId) AS g
		ON c.cartId = g.id
  WHERE a.id = 3;
