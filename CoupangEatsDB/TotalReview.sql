-- 1번 식당의 전체 리뷰 조회

SELECT  a.id AS '리뷰 id'
			, f.name AS 식당
			, menuId AS 메뉴id
			, e.name AS 메뉴명 
            , b.name AS 고객명
            , contents AS 리뷰내용
            , score AS 별점
            , a.createdAt AS '리뷰시간(날짜)'
            , timestampdiff(day, a.createdAt, current_timestamp())AS '리뷰시간(일전)'
  FROM review a
         LEFT JOIN user b
         ON a.userId = b.id
         LEFT JOIN (select o.cartId
								, o.id
						FROM orders o) AS c
                        ON a.orderId = c.id
         LEFT JOIN (select cartId
								, menuId
                       FROM cartedmenu) AS d 
                       ON c.cartId = d.cartId
         LEFT JOIN (SELECT id
								, name
                    from menu) AS e
                    ON d.menuId = e.id
		LEFT JOIN ( SELECT id
								, name
						 FROM restaurant ) AS f
                         ON a.restaurantId = f.id
 WHERE restaurantId = 1;
