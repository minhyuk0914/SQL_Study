DROP DATABASE IF EXISTS pokemon;

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
VALUES	(10, 'caterpie', 'bug', 0.3, 2.9, 30, 35, 45),
	(25, 'pikachu', 'electric', 0.4, 6, 55, 40, 90),
    (26,'raichu', 'electric', 0.8, 30, 90, 55, 110),
    (133, 'eevee', 'normal', 0.3, 6.5, 55, 50, 55),
    (152, 'chikorita', 'grass', 0.9, 6.4, 49, 65, 45);
    


#1 이브이의 타입 가져오기
SELECT type FROM mypokemon WHERE name = 'eevee';

#2 캐터피의 공격력과 방어력을 가져오기
SELECT attack, defense FROM mypokemon WHERE name = 'caterpie';

#3 몸무게가 6kg보다 큰 포켓몬 데이터 가져오기
SELECT * FROM mypokemon WHERE weight > 6;



#4 키가 0.5m 보다 크고, 몸무게가 6kg보다 크거나 같은 포켓몬들의 이름 가져오기
SELECT name FROM mypokemon WHERE height > 0.5 AND weight >= 6;

#5 포켓몬 테이블에서 공격력이 50 미만이거나, 방어력 50 미만 포켓몬 이름을 'weak_pokemon'이라는 별명으로 가져오기
SELECT name AS weak_pokemon FROM mypokemon WHERE attack < 50 OR defense < 50;

#6 노말 타입이 아닌 포켓몬들의 데이터를 전부 가져오기 
SELECT * FROM mypokemon WHERE type != 'normal';

#7 타입이 (normal, fire, water, grass)중에 하나인 포켓몬들의 이름과 타입을 가져오기
SELECT name, type FROM mypokemon WHERE type IN('normal', 'fire', 'water', 'grass');

#8 공격력이 40 과 60 사이인 포켓몬들의 이름과 공격력을 가져오기
SELECT name, attack FROM mypokemon WHERE attack BETWEEN 40 AND 60;

#9 이름에 'e'가 포함되는 포켓몬들의 이름을 가져오기
SELECT name FROM mypokemon WHERE name LIKE '%e%';

#10 이름에 'i'가 포함되고, 속도가 50 이하인 포켓몬 데이터를 전부 가져오기
SELECT * FROM mypokemon WHERE name LIKE '%i%' AND speed <= 50;

#11 이름이 'chu'로 끝나는 포켓몬들의 이름, 키, 몸무게를 가져오기
SELECT name, height, weight FROM mypokemon WHERE name LIKE '%chu';

#12 이름이 'e'로 끝나고, 방어력이 50미만인 포켓몬들의 이름, 방어력 가져오기
SELECT name, defense FROM mypokemon WHERE name LIKE '%e' AND defense < 50;

#13 공격력과 방어력의 차이가 10 이상이고 raichu만 이름, 공격력, 방어력 가져오기
SELECT name, attack, defense FROM mypokemon
WHERE (attack - defense > 10 OR defense - attack > 10) AND name = 'raichu';

#14 능력치의 합이 150 이상인 포켓몬의 이름과 능력치의 합 가져오기
#	이 때, 능력치의 합은 'total'이라는 별명으로 가져오기
#	조건1. 능력치의 합은 공격력, 방어력, 속도의 합을 의미합니다
SELECT name, attack + defense + speed AS total FROM mypokemon WHERE attack + defense + speed > 150;






