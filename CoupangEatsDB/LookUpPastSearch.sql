--1번 사용자의 검색 내역 조회
SELECT b.id AS 사용자id
        , a.searchId AS 검색어id
        , a.name AS 검색어
        , a.categoryId AS 검색어의카테고리
        , DATE_FORMAT ( a.createdAt, "%M-%D" ) AS 검색일시
 FROM Search a
 LEFT JOIN ( SELECT id
              FROM user
              GROUP BY id ) as b
              ON a.userId = b.id
 WHERE b.id = 1
 ORDER BY createdAt DESC;
