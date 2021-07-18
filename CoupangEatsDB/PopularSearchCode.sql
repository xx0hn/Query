-- 인기 검색어 조회 

SELECT MIN(a.searchId) AS 검색어id
       , a.name AS  검색어 
       , ROW_NUMBER() OVER (ORDER BY searchCount DESC ) 검색순위
 FROM Search a
 LEFT JOIN ( SELECT searchId
                  , name
                  , COUNT(searchId) AS 'searchCount'
              FROM Search  ) AS b
              ON a.searchId = b.searchId
GROUP BY a.searchId;
