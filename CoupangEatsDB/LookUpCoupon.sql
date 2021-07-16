-- 1번 사용자의 할인쿠폰 조회

SELECT a.id AS 사용자id
	, b.id AS 쿠폰id
	, b.name AS 쿠폰명
	, DATE_FORMAT(DATE_ADD(b.createdAt, INTERVAL 14 DAY), "%M-%D") AS '기간 (까지)'
 FROM user a
 LEFT JOIN ( SELECT id
		    , name
                    , userId
                    , createdAt
                    , status
	      FROM coupon ) AS b
              ON a.id = b.userId
 WHERE a.id = 1 AND b.status = 0;
