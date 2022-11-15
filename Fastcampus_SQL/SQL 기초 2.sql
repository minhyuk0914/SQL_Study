CREATE DATABASE pokemon;

USE pokemon;
CREATE TABLE mypokemon (
		number INT,
        name VARCHAR(20),
        type VARCHAR(20),
        height FLOAT,
        weight FLOAT,
        attack FLOAT,
        defense FLOAT,
        speed FLOAT
);

INSERT INTO mypokemon (number, name, type, height, weight, attack, defense, speed)
VALUES (10, 'caterpie', 'bug', 0.3, 2.9, 39, 35, 45),
	(25, 'pikachu', 'electric', 0.4, 6, 55, 40, 90),
    (26,'raichu', 'electric', 0.8, 30, 90, 55, 110),
    (133, 'eevee', 'normal', 0.3, 6.5, 55, 50, 55),
    (152, 'chikorita', 'grass', 0.9, 6.4, 49, 65, 45);
 
 
 
#1 123 곱하기 456 
SELECT 123*456;

#2 2310 나누기 30
SELECT 2310/30;

#3 '피카츄'라는 문자열을 '포켓몬' 이라는 이름의 컬럼 별명으로 가져와주세요
SELECT '피카츄' AS '포켓몬'; 

#4 포켓몬 테이블에서 모든 포켓몬들의 컬럼과 값 전체 가져오기
SELECT * FROM mypokemon;

#5 포켓몬 테이블에서 모든 포켓몬들의 이름을 가져오기
SELECT name FROM mypokemon;

#6 포켓몬 테이블에서 모든 포켓몬들의 이름과 키, 몸무게 가져오기
SELECT name, height, weight FROM mypokemon;

#7 포켓몬 테이블에서 포켓몬들의 키를 중복 제거하고 가져와주세요
SELECT DISTINCT height FROM mypokemon;

#8 포켓몬 테이블에서 모든 포켓몬들의 공격력을 2배 해 'attack2'라는 별명으로 이름과 함께 가져오기
SELECT name, attack*2 AS attack2 FROM mypokemon;

#9 포켓몬 테이블에서 모든 포켓몬들의 이름을 '이름' 이라는 한글 별명으로 가져오기
SELECT name AS '이름' FROM mypokemon;

#10 포켓몬 테이블에서 모든 포켓몬들의 '공격력', '방어력' 이라는 한글 별명으로 가져오기
SELECT attack AS '공격력' , defense AS '방어력' FROM mypokemon;

#11 포켓몬 테이블의 키 컬럼은 m 단위입니다.
#   포켓몬 테이블에서 모든 포켓몬들의 키를 cm단위로 환산하여 'height(cm)'이라는 별명으로 가져오기
SELECT height*100 AS 'height(cm)' FROM mypokemon;

#12 포켓몬 테이블에서 첫번째 로우에 위치한 포켓몬 데이터만 컬럼 값 전체 가져오기
SELECT * FROM mypokemon LIMIT 1; 

#13 포켓몬 테이블에서 2개의 포켓몬 데이터만 이름은 '영문명'이라는 별명으로,
#   키는 '키(m)'라는 별명으로, 몸무게는 '몸무게(kg)'이라는 별명으로 가져오기
SELECT name AS '영문명', height AS '키(m)', weight AS '몸무게(kg)'FROM mypokemon LIMIT 2;

#14 포켓몬 테이블에서 모든 포켓몬들의 이름과 능력치의 합을 가져오고,
#	이 때 능력치의 합은 'total'이라는 별명으로 가져오기
#	조건1. 능력치의 합은 공격력, 방어력, 속도의 합을 의미한다.
SELECT name, attack+defense+speed AS total FROM mypokemon;

#15 포켓몬 테이블에서 모든 포켓몬들의 BMI 지수를 구해서 'BMI'라는 별명으로 가져오기
#	조건1. BMI = 몸무게(kg) / (키(m))^2
#	조건2. 포켓몬 테이블 데이터의 체중은 kg 단위, 키는 m 단위 입니다
SELECT name, weight/height^2 AS BMI FROM mypokemon;
