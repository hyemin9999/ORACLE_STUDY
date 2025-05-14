SELECT * FROM USER_TABLES; -- 내가 만든(소유한) 테이블 (954개)

SELECT * FROM ALL_TABLES; -- 내가 접근 가능한 모든 테이블 (권한 포함) (2781개)

SELECT * FROM DBA_TABLES; -- 데이터베이스 전체 모든 테이블 (2781개)

SELECT * FROM DBA_ROLES; -- 데이터베이스 전체 모든 롤 (55개)

SELECT * FROM DBA_SYS_PRIVS; -- SYS_PRIVS (딕셔너리 뷰), 시스템 권한을 누구에게 부여 받았는지 보여주는 
 -- GRANTEE 권한을 받은 사용자 또는 ROLE 이름
 -- PRIVILEGE 부여된 시스템 권한 (예:CREATE SESSION, CREATE TABLE등)
 -- ADMIN_OPTION YES이면, 이권한을 다른사용자에게도 부여 가능하다는 뜻
 
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'CONNECT'; -- CREATE SESSTION 
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'RESOURCE'; -- CREATE 관련 8개 권한 
 -- 즉 사용자(개발자)를 생성하고 2개의 ROLE만 권한부여하면 최소한의 작업이 가능함

sELECT * FROM DICTIONARY; -- 오라클에서 참조 가능 사전 (2553개)
 