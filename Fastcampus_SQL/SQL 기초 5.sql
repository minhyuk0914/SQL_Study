DROP DATABASE IF EXISTS pokemon;

CREATE DATABASE pokemon;

USE pokemon; 
CREATE TABLE mypokemon (
		number INT,
        name VARCHAR(20),
        type VARCHAR(20),
        attack INT,
        defense INT,
        capture_date DATE
);

INSERT INTO mypokemon (number, name, type, attack, defense, capture_date)
VALUES	(10, 'caterpie', 'bug', 30, 35, '2019-10-14'),
	(25, 'pikachu', 'electric', 55, 40, '2018-11-04'),
    (26,'raichu', 'electric', 90, 55, '2019-05-28'),
    (125, 'electabuzz', 'eletric', 83, 56 , '2020-12-29'),
    (133, 'eevee', 'normal', 55, 50, '2021-10-03'),
    (137, 'porygon', 'normal', 60, 70, '2021-01-16'),
    (152, 'chikorita', 'grass', 49, 65, '2020-03-05'),
    (153, 'bayleef', 'grass', 62, 80, '2022-01-01');
    
#1 포켓몬의 이름을 마지막 3개 문자만, 'last_char'이라는 별명으로 가져와 주세요.
SELECT name, RIGHT(name, 3) AS last_char from mypokemon;

#2 포켓몬 이름을 왼쪽에서 2개 문자를 'left2'라는 별명으로 가져와 주세요.
SELECT name, LEFT(name, 2) AS left2 from mypokemon; 

#3 포켓몬 이름에서 이름에 o가 포함된 포켓몬만 모든 소문자 o를 대문자 O로 바꿔서 'bigO'라는 별명으로 가져와주세요
#  ex) 이름이 'pokemon'일 경우, 'bigO' 값은 'pOkemOn'이 됩니다.
SELECT name, REPLACE(name, 'o', 'O') from mypokemon WHERE name LIKE '%o%';

#4 포켓몬 타입을 가장 첫번째 글자 1자, 가장 마지막 글자 1자를 합친 후, 대문자로 변환해서
#  'type_code'라는 별명으로 가져와 주세요. 이 때, 이름도 함께 가져와 주세요.
#  ex) 타입이 'water'일 경우, 'type_code' 값은 'w' 와 'r'를 대문자로 바꾼 'WR'이 됩니다.
SELECT name, type, UPPER(CONCAT(LEFT(type, 1), RIGHT(type, 1))) AS type_code from mypokemon;

#5 포켓몬 이름의 글자 수가 8보다 큰 포켓몬의 데이터를 전부 가져와 주세요.
SELECT * from mypokemon WHERE LENGTH(name) > 8;

#6 모든 포켓몬의 공격력 평균을 정수로 반올림해서 'avg_of_attack'이라는 별명으로 가져와 주세요.
SELECT ROUND(SUM(ATTACK)/COUNT(ATTACK)) AS avg_of_attack from mypokemon;

#7 모든 포켓몬의 방어력 평균을 정수로 내림해서 'avg_of_defense'이라는 별명으로 가져와 주세요.
SELECT FLOOR(SUM(defense)/COUNT(defense)) AS avg_of_defense from mypokemon;

#8 이름의 길이가 8미만인 포켓몬의 공격력의 2 제곱을 'attack2'라는 별명으로 가져와 주세요.
#  이 때, 이름도 함께 가져와 주세요.
SELECT name, POWER(attack,2) from mypokemon WHERE LENGTH(name) < 8;

#9 모든 포켓몬의 공격력을 2로 나눈 나머지를 'div2'라는 별명으로 가져와 주세요. 
#  이 때, 이름도 함께 가져와 주세요.
SELECT name, MOD(attack, 2) AS div2 from mypokemon;

#10 공격력이 50이하인 포켓몬의 공격력을 방어력으로 뺀 값의 절댓값을 'diff'라는 별명으로 가져와 주세요.
#  이 때, 이름도 함께 가져와 주세요.
SELECT name, ABS(attack - defense) AS diff from mypokemon WHERE attack <= 50;

#11 현재 날짜와 시간을 가져와 주세요. 각각 now_date, now_time이라는 별명으로 가져와 주세요.
SELECT CURRENT_DATE() AS now_date, current_time() AS now_time;

#12 포켓몬을 포획한 달(월,MONTH)을 숫자와 영어로 가져와 주세요. 숫자는 month_num,
#   영어는 month_eng이라는 별명으로 가져와 주세요.
SELECT MONTH(capture_date) AS month_num, MONTHNAME(capture_date) AS month_eng from mypokemon;

#13 포켓몬을 포획한 날의 요일을 숫자와 영어로 가져와 주세요.
#   숫자는 day_num, 영어는 day_eng이라는 별명으로 가져와 주세요.
SELECT DAYOFWEEK(capture_date) AS day_num, DAYNAME(capture_date) AS day_eng
from mypokemon;

#14 포켓몬을 포획한 날의 연도, 월, 일을 각각 숫자로 가져와 주세요.
#   연도는 year, 월은 month, 일은 day라는 별명으로 가져와 주세요.
SELECT YEAR(capture_date) AS year, MONTH(capture_date) AS month, DAY(capture_date) AS day
from mypokemon;