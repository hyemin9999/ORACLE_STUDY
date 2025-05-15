--[시나리오 제시]
--온라인 쇼핑몰 데이터베이스를 구축하려고 한다. 아래의 요구사항을 참조하여 작업하시오.
--
--DBMS 는 Oracle을 사용합니다 (관련 sql과 실행결과 제출)
--
--데이터베이스명 : orcl
--계정 (user) : USER01
--비밀번호 : test

CREATE USER USER01 IDENTIFIED BY test;
GRANT RESOURCE, CONNECT TO USER01;
GRANT CREATE VIEW TO USER01;
