-- 2020년 7월의 Revenue(수입 = sum(price))를 구해주세요

SELECT *
FROM fastcampus.tbl_purchase;

SELECT sum(price)
FROM fastcampus.tbl_purchase
WHERE purchased_at >= "2020-07-01"
  and purchased_at < "2020-08-01";
  
-- 2020년 7월의 MAU를 구해주세요.
SELECT * 
FROM fastcampus.tbl_visit;

SELECT count(*)
	,  count(customer_id)
 	,  count(distinct customer_id)   
FROM fastcampus.tbl_visit
WHERE visited_at >= "2020-07-01"
  and visited_at < "2020-08-01";
  
-- 2020년 7월의 우리 Active 유저의 구매율(Paying Rate)은 어떻게 되나요?
-- 구매유저 수 / 전체 활성유저

SELECT count(distinct customer_id)
FROM fastcampus.tbl_purchase
WHERE purchased_at >= "2020-07-01"
  and purchased_at < "2020-08-01";
  
SELECT count(distinct customer_id)
FROM fastcampus.tbl_visit
WHERE visited_at >= "2020-07-01"
  and visited_at < "2020-08-01";
  
-- 11174 12929
SELECT round(11174/12929*100,2);


-- 2020년 7월에 구매 유저의 월 평균 구매액은 어떻게 되나요?
-- ARPPU = Average Revenue per Paying User

SELECT avg(revenue)
from (SELECT customer_id
	,  sum(price) AS revenue
	FROM fastcampus.tbl_purchase
	WHERE purchased_at >= "2020-07-01"
	and purchased_at < "2020-08-01"
	group by customer_id) foo;


-- 2020년 7월에 가장 많이 구매한 Top 3 고객과 Top 10~15 고객을 뽑아주세요


SELECT customer_id
	,  sum(price) AS revenue
	FROM fastcampus.tbl_purchase
	WHERE purchased_at >= "2020-07-01"
	and purchased_at < "2020-08-01"
	group by customer_id
    ORDER BY revenue DESC
    LIMIT 3 offset 10 ;
    
    
    
    
-- 날짜 함수

SELECT NOW();
SELECT CURRENT_DATE();
SELECT EXTRACT(MONTH FROM '2021-01-01');
SELECT DAY('2021-01-01');
SELECT DATE_ADD('2021-01-01', INTERVAL 7 DAY);
SELECT DATE_SUB('2017-06-15', INTERVAL 7 DAY);
SELECT DATEDIFF('2017-06-25', '2017-06-15');
SELECT TIMEDIFF('2021-01-25 12:10:00', '2021-01-25 10:10:00');
SELECT DATE_FORMAT(NOW(), '%Y-%m-%d');


-- 2020년 7월의 평균 DAU를 구해주세요, Active User 수가 증가하는 추세인가요?\


SELECT *
FROM fastcampus.tbl_visit;

SELECT avg(users)
FROM
(SELECT date_format(visited_at - interval 9 hour, '%Y-%m-%d %T') as date_at
	,  count(distinct customer_id) as users
FROM fastcampus.tbl_visit
WHERE visited_at >= '2020-07-01'
 and  visited_at < '2020-08-01'
GROUP BY 1
ORDER BY 1) foo ;


-- 2020년 7월의 평균 WAU를 구해주세요

SELECT avg(users)
FROM (
SELECT date_format(visited_at - interval 9 hour, '%Y-%m-%U') as date_at
	,  count(distinct customer_id) as users
FROM fastcampus.tbl_visit
WHERE visited_at >= '2020-07-05'
 and  visited_at < '2020-07-26'
GROUP BY 1
ORDER BY 1 ) foo;

-- 1. 2020년 7월의 Daily Revenue는 증가하는 추세인가요? 평균 Daily Revenue도 구해주세요.

SELECT avg(revenue)
FROM (
SELECT date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as date_at
	,  sum(price) as revenue
FROM fastcampus.tbl_purchase
WHERE purchased_at >= '2020-07-01'
 and  purchased_at < '2020-08-01'
GROUP BY 1
ORDER BY 1) foo;

-- 2. 2020년 7월의 평균 Weekly Revenue를 구해주세요.
SELECT avg(revenue)
FROM (
SELECT date_format(purchased_at - interval 9 hour, '%Y-%m-%U') as date_at
	,  sum(price) as revenue
FROM fastcampus.tbl_purchase
WHERE purchased_at >= '2020-07-05'
 and  purchased_at < '2020-07-26'
GROUP BY 1
ORDER BY 1) foo;


-- 2020년 7월 요일별 Daily Revenue를 구해주세요. 어느 요일이 Revenue가 가장 높고 낮나요?

SELECT date_format(date_at, '%W') as day_name
	,  date_format(date_at, '%w') as day_order
	,  avg(revenue)
FROM (
SELECT date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as date_at
	,  sum(price) as revenue
FROM fastcampus.tbl_purchase
WHERE purchased_at >= '2020-07-01'
 and  purchased_at < '2020-08-01'
GROUP BY 1) foo
GROUP BY 1, 2
ORDER BY 1;



-- 2020년 7월 시간대별 시간당 총 Revenue를 구해주세요. 어느 시간대가 Revenue가 가장 높고 낮나요?


SELECT hour_at
	,  avg(revenue)
FROM (
SELECT date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as date_at
	,  date_format(purchased_at - interval 9 hour, '%H') as hour_at
	,  sum(price) as revenue
FROM fastcampus.tbl_purchase
WHERE purchased_at >= '2020-07-01'
 and  purchased_at < '2020-08-01'
GROUP BY 1, 2) foo
GROUP BY 1
ORDER BY 2 DESC;


-- 2020년 7월의 요일 및 시간대별 Revenue를 구해주세요


SELECT dayofweek_at
	,  hour_at
    ,  avg(revenue)
FROM (
SELECT date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as date_at
	,  date_format(purchased_at - interval 9 hour, '%H') as hour_at
    ,  date_format(purchased_at - interval 9 hour, '%W') as dayofweek_at
	,  sum(price) as revenue
FROM fastcampus.tbl_purchase
WHERE purchased_at >= '2020-07-01'
 and  purchased_at < '2020-08-01'
GROUP BY 1,2,3) foo
GROUP BY 1,2
ORDER BY 3 DESC;



-- 유저 세그먼트별 분석
-- 전체 유저의 Demographic을 알고 싶어요. 성연령별로 유저 숫자를 알려주세요.
-- 어느 세그먼트가 가장 숫자가 많나요? 참고로 기타 성별은 하나로, 연령은 5세 단위로 적당히 묶어주시고 유저수가 높은 순서대로 보여주세요.


SELECT CASE WHEN length(gender) < 1 THEN 'Others'
			ELSE gender END AS gender
	,  CASE WHEN age <= 15 THEN '15세 이하'
			WHEN age <= 20 THEN '20세 이하'
            WHEN age <= 25 THEN '25세 이하'
            WHEN age <= 30 THEN '30세 이하'
            WHEN age <= 35 THEN '35세 이하'
            WHEN age <= 40 THEN '40세 이하'
            WHEN age <= 45 THEN '45세 이하'
            WHEN age >= 46 THEN '46세 이상'
            END AS age
	,  count(*)
FROM fastcampus.tbl_customer
GROUP BY 1, 2
ORDER BY 3 DESC;


-- 위 결과의 성연령을 "남성25-29세" 와 같이 통합해주시고, 각 성연령이 전체 고객에서 얼마나 차지하는지 분포(%)를 알려주세요,
-- 역시 분포가 높은 순서대로 알려주세요.


 SELECT CONCAT (CASE WHEN length(gender) < 1 THEN '기타'
			WHEN gender = 'Others' THEN '기타'
            WHEN gender = 'M' THEN '남성'
            WHEN gender = 'F' THEN '여성'
            END
	, "("
	,  CASE WHEN age <= 15 THEN '15세 이하'
			WHEN age <= 20 THEN '20세 이하'
            WHEN age <= 25 THEN '25세 이하'
            WHEN age <= 30 THEN '30세 이하'
            WHEN age <= 35 THEN '35세 이하'
            WHEN age <= 40 THEN '40세 이하'
            WHEN age <= 45 THEN '45세 이하'
            WHEN age >= 46 THEN '46세 이상'
            END
	, ")" ) AS segement
	,  round(count(*) / (SELECT count(*) FROM fastcampus.tbl_customer) * 100, 2) AS per
FROM fastcampus.tbl_customer
GROUP BY 1;


-- 2020년 7월, 성별에 따라 구매 건수와, 총 Revenue를 구해주세요.
-- 이전 처럼 남녀 이외의 성별은 하나로 묶어주세요.


SELECT CASE WHEN length(B.gender) < 1 THEN '기타'
			WHEN B.gender = 'Others' THEN '기타'
            WHEN B.gender = 'M' THEN '남성'
            WHEN B.gender = 'F' THEN '여성'
            END AS gender
	, count(*) AS cnt
    , sum(price) AS revenue
FROM fastcampus.tbl_purchase A
LEFT JOIN fastcampus.tbl_customer B
ON A.customer_id = B.customer_id
WHERE A.purchased_at >= '2020-07-01'
AND A.purchased_at < '2020-08-01'

GROUP BY 1;


-- 2020년 7월의 성별연령에 따라 구매 건수와, 총 Revenue를 구해주세요

SELECT CASE WHEN length(B.gender) < 1 THEN '기타'
			WHEN B.gender = 'Others' THEN '기타'
            WHEN B.gender = 'M' THEN '남성'
            WHEN B.gender = 'F' THEN '여성'
            END AS gender
	,  CASE WHEN B.age <= 15 THEN '15세 이하'
			WHEN B.age <= 20 THEN '20세 이하'
            WHEN B.age <= 25 THEN '25세 이하'
            WHEN B.age <= 30 THEN '30세 이하'
            WHEN B.age <= 35 THEN '35세 이하'
            WHEN B.age <= 40 THEN '40세 이하'
            WHEN B.age <= 45 THEN '45세 이하'
            WHEN B.age >= 46 THEN '46세 이상'
            END age_group
	, count(*) AS cnt
    , sum(price) AS revenue
FROM fastcampus.tbl_purchase A
LEFT JOIN fastcampus.tbl_customer B
ON A.customer_id = B.customer_id
WHERE A.purchased_at >= '2020-07-01'
AND A.purchased_at < '2020-08-01'

GROUP BY 1,2
ORDER BY 4 DESC;




-- 매출 관련 추가 분석
-- 2020년 7월 일별 매출의 전일 대비 증감폭, 증감률을 구해주세요.


WITH tbl_revenue AS (
SELECT date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as d_date
	,  sum(price) AS revenue
FROM fastcampus.tbl_purchase
WHERE purchased_at >= '2020-07-01'
AND purchased_at < '2020-08-01'
GROUP BY 1
)

SELECT * 
	,  revenue - LAG(revenue) OVER(ORDER BY d_date ASC)
    ,  round(revenue - LAG(revenue) OVER(ORDER BY d_date ASC) / LAG(revenue) OVER(ORDER BY d_date ASC)*100, 2) AS chg_revenue
FROM tbl_revenue;



-- 일별로 많이 구매한 고객들한테 소정의 선물을 줄려고해요, 7월에 일별로 구매 금액 기준으로 가장 많이 지출한 고객 TOP3를 뽑아주세요.


SELECT *
FROM (
SELECT date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as d_date
	,  customer_id
	,  sum(price)
    ,  DENSE_RANK() OVER (PARTITION BY date_format(purchased_at - interval 9 hour, '%Y-%m-%d') ORDER BY sum(price) DESC) AS rank_rev
FROM fastcampus.tbl_purchase
WHERE purchased_at >= '2020-07-01'
AND purchased_at < '2020-08-01'
GROUP BY 1,2
) foo

WHERE rank_rev < 4;


-- 프로덕트 분석 심화
-- 2020년 7월에 우리 신규유저가 하루 안에 결제로 넘어가는 비율이 어떻게 되나요?
-- 그 비율이 어떤지 알고싶고, 결제까지 보통 몇 분 정도가 소요되는지 알고싶어요.


WITH rt_tbl AS (

	SELECT A.customer_id
		,  A.created_at
		,  B.customer_id AS paying_user
		,  B.purchased_at
		,  time_to_sec(timediff(B.purchased_at, A.created_at)) / 3600 AS diff_hour
	FROM fastcampus.tbl_customer A

	LEFT JOIN (SELECT customer_id
				,  min(purchased_at) AS purchased_at
				FROM fastcampus.tbl_purchase 
				GROUP BY 1) B

	ON A.customer_id = B.customer_id
	AND B.purchased_at < A.created_at + interval 1 day

	WHERE A.created_at >= '2020-07-01'
	AND A.created_at < '2020-08-01'
)

SELECT round(count(paying_user) / count(customer_id) * 100, 2)
FROM rt_tbl

UNION ALL 
SELECT avg(diff_hour)
FROM rt_tbl;


-- 우리 서비스는 유저의 재방문율이 높은 서비스인가요? 이를 파악하기 위해 7월 기준 Day1 Retention이 어떤지 구해주시고,
-- 추세를 보기위해 Daily로 추출해주세요.

SELECT date_format(A.visited_at - interval 9 hour, '%Y-%m-%d') AS d_date
	,  count(distinct A.customer_id) AS active_users
	,  count(distinct B.customer_id) AS retained_users
    ,  count(distinct B.customer_id) / count(distinct A.customer_id) AS retention
    
FROM fastcampus.tbl_visit A
LEFT JOIN fastcampus.tbl_visit B
ON A.customer_id = B.customer_id
AND date_format(A.visited_at - interval 9 hour, '%Y-%m-%d') = date_format(B.visited_at - interval 9 hour - interval 1 day, '%Y-%m-%d')

WHERE A.visited_at >= '2020-07-01'
AND A.visited_at < '2020-08-01'

GROUP BY 1;



-- 2020년 7월 우리 서비스는 신규유저가 많나요? 기존유저가 많나요? 가입기간별로 고객 분포가 어떤지 알려주세요, DAU 기준으로 부탁합니다.

-- tbl_visit 일자별로 고객의 last_visit created_at = service age


WITH tbl_visit_by_joined AS (
								SELECT date_format(A.visited_at - interval 9 hour, "%Y-%m-%d") AS d_date
									,  A.customer_id
									,  B.created_at AS d_joined
									,  max(A.visited_at) AS last_visit
									, datediff(max(A.visited_at), B.created_at) AS date_diff
								FROM fastcampus.tbl_visit A
								LEFT JOIN fastcampus.tbl_customer B
								ON A.customer_id = B.customer_id
								WHERE A.visited_at >= '2020-07-01'
								  AND A.visited_at < '2020-08-01'
								GROUP BY 1, 2, 3
)

SELECT A.d_date
	,  CASE WHEN A.date_diff >= '730' THEN '2년 이상'
			WHEN A.date_diff >= '365' THEN '1년 이상'
			WHEN A.date_diff >= '183' THEN '6개월 이상'
            WHEN A.date_diff >= '91' THEN '3개월 이상'
            WHEN A.date_diff >= '30' THEN '1개월 이상'
            ELSE '1개월 미만'
            END AS segment
    ,  B.all_users
	,  count(A.customer_id) AS users
    ,  round(count(A.customer_id)/B.all_users,2) AS per
    
FROM tbl_visit_by_joined A
LEFT JOIN (SELECT d_date
				, count(customer_id) AS all_users
		   FROM tbl_visit_by_joined
           GROUP BY 1) B
ON A.d_date = B.d_date
GROUP BY 1, 2, 3
ORDER BY 1, 2, 3
    


