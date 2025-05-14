SELECT * FROM USER_TABLES; -- 내가 만든(소유한) 테이블 (4개)

SELECT * FROM ALL_TABLES; -- 내가 접근 가능한 모든 테이블 (권한 포함) (103개)

SELECT * FROM DBA_TABLES; -- 데이터베이스 전체 모든 테이블 (DBA 권한 필요) (접근 불가)

SELECT * FROM EMP; -- * ==> 모든열

SELECT EMPNO, ENAME FROM EMP; -- EMPNO, ENAME 두개의 열만 검색

SELECT * FROM EMP; -- 14
SELECT * FROM DEPT; -- 4
SELECT * FROM BONUS; -- 0
SELECT * FROM SALGRADE; -- 5

SELECT * FROM EMP, DEPT; -- EMP 14 x DEPT 4 = 56행 