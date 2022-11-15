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
    

#1 포켓몬 테이블에서 포켓몬의 이름과 이름의 글자 수를 이름의 글자 수로 정렬해서 가져와 주세요.
#  정렬 순서는 글자 수가 적은 것부터 많은 것 순으로 해주세요.
SELECT name, LENGTH(name) from mypokemon  ORDER BY LENGTH(name) ASC;

#2 포켓몬 테이블에서 방어력 순위를 봉져주는 컬럼을 새로 만들어서 'defense_rank'라는 별명으로 가져와주세요. 이 때, 포켓몬 이름 데이터도 같이 가져와주세요.
#  조건 1. 방어력 순위란 방어력이 큰 순서대로 나열한 순위입니다.
#  조건 2. 공동 순위가 있으면 다음 순서로 건너 뛰어 주세요.
SELECT name, RANK() OVER (ORDER BY defense DESC) AS defense_rank
FROM mypokemon;

#3 포켓몬 테이블에서 포켓몬을 포획한 지 기준 날짜까지 며칠이 지났는 지를 'days'라는 별명으로 가져와 주세요. 이 때, 포켓몬 이름 데이터도 같이 가져와주세요.
#  조건 1. 기준 날짜는 2022년 2월 4일 입니다.
SELECT name, DATEDIFF('2022-02-04', capture_date) AS days from mypokemon;

SELECT name, DATEDIFF(capture_date, '2022-02-04') AS days from mypokemon;