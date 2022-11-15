DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
	number int,
    name varchar(20),
    type varchar(10),
    height float,
    weight float
);
INSERT INTO mypokemon (number, name, type, height, weight)
VALUES (10, 'caterpie', 'bug', 0.3, 2.9),
	(25, 'pikachu', 'electric', 0.4, 6),
    (26, 'raichu', 'electric', 0.8, 30),
    (125, 'electabuzz', 'electric', 1.1, 30),
    (133, 'eevee', 'normal', 0.3, 6.5),
    (137, 'porygon', 'normal', 0.8, 36.5),
    (152, 'chikorita', 'grass', 0.9, 6.4),
    (153, 'bayleef', 'grass', 1.2, 15.8),
    (172, 'pichu', 'electric', 0.3, 2),
    (470, 'leafeon', 'grass', 1, 25.5);


SELECT * FROM mypokemon;

/*
	포켓몬 테이블에서 이름(name)의 길이가 5보다 큰 포켓몬들을 타입(type)을 기준으로 그룹화하고,
	몸무게(weight)의 평균이 20 이상인 그룹의 타입과, 몸무게의 평균을 가져와 주세요.
    이 때, 결과는 몸무게의 평균을 내림차순으로 정렬해 주세요.
*/
SELECT type, AVG(weight)
FROM mypokemon WHERE LENGTH(NAME) >5
GROUP BY type
HAVING AVG(weight) >= 20
ORDER BY 2 DESC;


/*
	포켓몬 테이블에서 번호(number)가 200보다 작은 포켓몬들을 타입(type)을 기준으로 그룹화한 후에,
    몸무게(weight)의 최댓값이 10보다 크거나 같고 최솟값은 2보다 크거나 같은 그룹의
    타입, 키(height)의 최솟값, 최댓값을 가져와 주세요. 이 때, 결과는 키의 최솟값의 내림차순으로 정렬해
    주시고, 만약 키의 최솟값이 같다면 키의 최댓값의 내림차순으로 정렬해주세요.
*/

SELECT type, MIN(height), MAX(height)
FROM mypokemon WHERE number < 200
GROUP BY type
HAVING MAX(weight) >= 10 && MIN(weight) >= 2
ORDER BY MIN(height) DESC, MAX(height) DESC;