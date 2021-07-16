-- 내가 작성한 리뷰

SELECT a.id AS 리뷰id
        , b.id AS 사용자id
        , c.name AS 식당명
        , a.score AS 별점
        , a.contents AS 리뷰내용
        , a.imageUrl AS 리뷰사진
        , f.name AS 먹은음식
 FROM review a
 LEFT JOIN user b
				    ON a.userId = b.id
 LEFT JOIN ( SELECT id
							      , name
					     FROM restaurant ) AS c
               ON a.restaurantId = c.id
 LEFT JOIN ( SELECT id
							      , userId
					     FROM cart
               GROUP BY userId ) AS d
               ON a.userId = d.id
 LEFT JOIN ( SELECT id
							      , cartId
                    , menuId
					     FROM cartedmenu
               GROUP BY cartId ) AS e
               ON d.id = e.cartId
 LEFT JOIN ( SELECT id
							      , name
                    , restaurantId
					     FROM menu
               GROUP BY restaurantId ) AS f
               ON c.id = f.restaurantId
WHERE a.userId = 1;
