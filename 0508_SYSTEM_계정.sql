SELECT * FROM USER_TABLES; -- 내가 만든(소유한) 테이블 (156개)

SELECT * FROM ALL_TABLES; -- 내가 접근 가능한 모든 테이블 (권한 포함) (2781개)

SELECT * FROM DBA_TABLES; -- 데이터베이스 전체 모든 테이블 (2781개)

-- **** 사용자 이니셜로 계정 2개를 만들고 비번 부여, 그리고 최소한의 권한 부여
-- 교제 --> 15장 참조  OPT :  SQL DEVELOPER, SQLPLUS

CREATE USER uid IDENTIFIED BY upwd;

GRANT RESOURCE, CONNECT TO uid;

select * from dba_users;

select * from all_users;
