-- final_proj.customers 데이터 확인 
select *
from final_proj.customers;

-- final_proj.orders 데이터 확인 
select * from final_proj.orders;


-- 1) 
-- 고객의 서비스 이용 데이터(총 구매금액)으로 기준
-- 고객아이디(customer_id)별 총 구매금액 확인
select customer_id, sum(payment) as total
from final_proj.orders
group by customer_id
order by 1;

-- customer_id별 총 구매금액으로 내림차순 정렬을 하여 기준 정하기
select customer_id, sum(payment) as total
from final_proj.orders
group by customer_id
order by 2 DESC;


-- 50000이하 5등급, 50000~100000 4등 100000~150000 3등급, 150000~2000002등급, 200000이상 1등급으로 구분.
-- 등급을 기준으로 오름차순 정렬
select customer_id, count(customer_id) as pay_count, round(sum(payment)/count(customer_id)) AS avg_payment, sum(payment),
			case when sum(payment) >= 200000 then '1등급'
				 when sum(payment) >= 150000 then '2등급'
				 when sum(payment) >= 100000 then '3등급'
				 when sum(payment) >= 50000 then '4등급'
				 else '5등급'
			end as grade
from final_proj.orders
group by customer_id
order by 4 DESC;



-- 1등급에 해당하는 고객의 랭킹, 고객의 아이디, 이름, 성별, 나이, 주소, 서비스 이용 데이터(총 구매횟수, 총 구매금액, 평균 구매금액) 확인
select A.customer_id,A.customer_name, A.gender,age, A.home_address, B.grade, rank() over(order by total_payment desc) as customer_rank, B.total_payment,B.total_paycount,B.avg_payment
from final_proj.customers A
	RIGHT JOIN (select customer_id, count(customer_id) as total_paycount, round(sum(payment)/count(customer_id)) AS avg_payment, sum(payment) as total_payment, 
			case when sum(payment) >= 200000 then '1등급'
				 when sum(payment) >= 150000 then '2등급'
				 when sum(payment) >= 100000 then '3등급'
				 when sum(payment) >= 50000 then '4등급'
				 else '5등급'
			end as grade
	from final_proj.orders
	group by customer_id
	order by 4 DESC) B
	ON A.customer_id = B.customer_id
where grade = '1등급';


-- 2) KPI 지표
-- 연령에 따른 매출 분석

-- 연령을 오름차순으로 정렬 후 데이터 확인을 통하여 구매고객 연령층은 20~80세라는 것을 확인
select *
from final_proj.customers A
	RIGHT JOIN final_proj.orders B
	ON A.customer_id = B.customer_id
    order by A.age;


-- 연령과 총 구매금액을 고객아이디별로 확인 
select A.customer_id, A.age, sum(B.payment)
from final_proj.customers A
	RIGHT JOIN final_proj.orders B
	ON A.customer_id = B.customer_id
    group by A.customer_id
	order by A.age;
    

-- 총 구매 금액과, 총 구매횟수을 연령대로 그룹화
-- 물건을 많이 구입하는 연령대부터 적게 구입하는 연령대를 확인
-- 가장 많이 물건을 구입하는 연령대는 20~30세 이며, 가장 적게 물건을 구입하는 연령대는 60~70세이다.
SELECT A.age_group, sum(B.payment) as total_payment, count(B.customer_id) as count_payment, rank() over(order by count(B.customer_id) desc) as age_payment_rank
from final_proj.orders B
left join	(select customer_id,
				case when age >= 70 then "70~80세"
					 when age >= 60 then "60~70세"
					 when age >= 50 then "50~60세"
					 when age >= 40 then "40~50세"
					 when age >= 30 then "30~40세"
					 else "20~30세"
				end as age_group
			from final_proj.customers) A
	ON A.customer_id = B.customer_id
group by 1;



-- 추가로 연령대 별로 구매하는 물건의 평균 값을 비교
-- 저렴한 물품들을 구매하였는지, 값이 있는 물건대를 구입하였는지를 연령대 별로 비교하기 위해.
-- 물품들의 평균 가격이 가장 높은 연령대는 20~30세이고, 가장 낮은 연령대는 30~40세이다.
SELECT A.age_group, sum(B.payment) as total_payment, count(B.customer_id) as count_payment, round(sum(B.payment)/count(B.customer_id)) as obj_payment, rank() over(order by round(sum(B.payment)/count(B.customer_id)) desc) as age_obj_pay_rate
from final_proj.orders B
left join	(select customer_id,
				case when age >= 70 then "70~80세"
					 when age >= 60 then "60~70세"
					 when age >= 50 then "50~60세"
					 when age >= 40 then "40~50세"
					 when age >= 30 then "30~40세"
					 else "20~30세"
				end as age_group
			from final_proj.customers) A
	ON A.customer_id = B.customer_id
group by 1;
			

    
-- 고객 아이디 수(가입자 수)와 주문자 수(구매자 수(유니크한 값))를 확인
-- 가입자 수 = 1000, 구매자 수 = 617
select count(customer_id) as count_customer
from final_proj.customers
union
select count(distinct customer_id) as count_order
from final_proj.orders;



-- 구매자들 중에서 두 번 이상 구매자들을 확인
select customer_id, count(customer_id)
from final_proj.orders
group by 1
having count(customer_id) > 1;



-- 구매자 수(1번 이상 구매자 수) = 617
select count(distinct customer_id) as count_order
from final_proj.orders;



-- 두 번 이상 구매자 수 = 263
select count(A.customer_id)
from (
	select customer_id, count(customer_id)
	from final_proj.orders
    group by 1
    having count(customer_id) > 1
) A;


-- 구매자 수(유니크한 값) 617이고, 이중에서 두 번 이상 구매자 수는 263 이라는 것을 알 수 있다. 
select round(263/617 * 100);
-- 구매자들 중에서 두 번 이상 재방문으로 구매를 한 사람 은 43%라는 것을 알 수 있다.







