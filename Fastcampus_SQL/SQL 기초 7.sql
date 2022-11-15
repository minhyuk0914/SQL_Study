DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
	number INT,
    name VARCHAR(20),
    type VARCHAR(10),
    attack INT,
    defense INT
);

INSERT INTO mypokemon (number, name, type, attack, defense)
VALUES (10, 'caterpie', 'bug', 30, 35),
	(25, 'pikachu', 'electric', 55, 40),
    (26, 'raichu', 'electric', 90, 55),
    (125, 'electabuzz', 'electric', 83, 57),
    (133, 'eevee', 'normal', 55, 50),
    (137, 'porygon', 'normal', 55, 50),
    (152, 'chikorita', 'grass', 49, 65),
    (153, 'bayleef', 'grass', 62, 80),
    (172, 'pichu', 'electric', 40, 15),
    (470, 'leafeon', 'grass', 110, 130);


/*1 
	공격력과 방어력의 합이 120보다 크면 'very strong', 90보다 크면 'strong',
    모두 해당 되지 않으면 'not strong'를 반환하는 함수 'isStrong'을 만들고 사용해주세요.
    조건 1. attack과 defnese를 입력값으로 사용하세요.
    조건 2. 결과값 데이터 타입은 VARCHAR(20)로 해주세요.
*/

SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER //

CREATE FUNCTION isStrong(attack INT, defense INT)
	RETURNS VARCHAR(20) 
BEGIN
	DECLARE a INT;
    DECLARE b INT;
    DECLARE isStrong VARCHAR(20);
    SET a = attack;
    SET b = defense; 
    SELECT CASE 
		WHEN a + b > 120 THEN 'very strong'
        WHEN a + b > 90 THEN 'strong'
        ELSE 'not strong'
        END INTO isStrong;
	RETURN isStrong;
END
    

//
DELIMITER ; -- 꼭 띄어쓰기 후 ; 하기


SELECT name, isStrong(attack, defense) AS isStrong
FROM mypokemon;