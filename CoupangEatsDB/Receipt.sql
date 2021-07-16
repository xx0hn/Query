-- 영수증
SELECT a.id AS 영수증id
			, a.userId AS 사용자id
			, e.name AS 식당명
			, a.createdAt AS 주문일시
      , d.name AS 메뉴명
      , d.cost  AS 가격
      , e.delCost AS 배달비
      , CASE WHEN f.benefits IS NULL THEN 0 ELSE f.benefits END AS 할인금액
      , CASE WHEN f.benefits IS NULL THEN d.cost + e.delCost ELSE d.cost + e.delCost - f.benefits END AS 합계
      , CASE WHEN a.status = 0 THEN '결제완료' END AS 상태 
 FROM orders a
 LEFT JOIN ( SELECT id
							      , userId
							      , status
				       FROM cart ) AS b
               ON a.cartId = b.id
 LEFT JOIN ( SELECT cartId
							      , menuId
							      , restaurantId
					    FROM cartedmenu 
              GROUP BY cartId ) AS c
              ON b.id = c.cartId
 LEFT JOIN ( SELECT id
							      , name
                    , cost
                    , restaurantId
					     FROM menu ) AS d
               ON c.menuId = d.id
 LEFT JOIN ( SELECT id
							      , name
                    , delCost
					     FROM restaurant
               GROUP BY id ) AS e
               ON c.restaurantId = e.id
 LEFT JOIN ( SELECT id
							     , benefits
							     , userId
					     FROM coupon ) AS f
               ON a.couponId = f.id
	WHERE a.userId = 3 AND a.status = 0;
