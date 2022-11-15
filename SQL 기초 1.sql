# database 생성
CREATE DATABASE pokemon;

# 1) USE 사용
USE pokemon;
CREATE TABLE mypokemon (
		number INT,
        name VARCHAR(20),
        type VARCHAR(50)
        );

# 2) USE 사용 x -> database 이름. 테이블 이름으로 설정 
CREATE TABLE pokemon.mypokemon (
		number INT,
        name VARCHAR(20),
        type VARCHAR(50)
        );

INSERT INTO mypokemon (number, name, type)
VALUES (10, 'caterpie', 'bug'),
	   (25, 'pikachu', 'electric'),
       (133, 'eevee', 'nomal');
       
SELECT * FROM mypokemon; -- 테이블 전체를 조회하는 쿼리 

USE pokemon;
CREATE TABLE mynewpokemon(
		number INT,
        name VARCHAR(20),
        type VARCHAR(10)
        );
INSERT INTO mynewpokemon (number, name, type)
VALUES (77, '포니타', '불꽃'),
	   (132, '메타몽', '노말'),
       (151, '뮤', '에스퍼');
       
SELECT * FROM mynewpokemon;

/* 
테이블 이름 및 컬럼 이름, 타입 변경하기 
*/

# 테이블 이름 변경 
ALTER TABLE mypokemon
RENAME myoldpokemon;
SELECT * FROM myoldpokemon;

# 컬럼 이름과 타입 변경
ALTER TABLE myoldpokemon
CHANGE COLUMN name eng_nm VARCHAR(20);
SELECT * FROM myoldpokemon;

ALTER TABLE mynewpokemon
CHANGE COLUMN name kor_nm VARCHAR(20);
SELECT * FROM mynewpokemon;

/*

*/

USE pokemon;
SELECT * FROM myoldpokemon;
TRUNCATE TABLE myoldpokemon; -- TRUNCATE TABLE : 테이블 값만 지우기

SELECT * FROM mynewpokemon;
DROP TABLE mynewpokemon; -- DROP TABLE 테이블 지우기 
SELECT * FROM mynewpokemon; 

DROP DATABASE pokemon; -- DROP DATABASE 데이터베이스 지우기