-- 1. scott이 맡고 있는 업무 분석 --> table보고, Relation체크(업무:인사관리)
-- 2. tables 에 대해 이해 --> table 설명서
-- 3. DQL(QUERY) 실행


select * from user_tables; -- 모두 4개 table

select * from emp; -- 14개
select * from dept; -- 4개
select * from bonus; -- 0개
select * from SALGRADE; -- 5개


-- 문제
-- EMP 테이블에서 급여가 3000 이상인 직원만 조회

select * from emp where sal >=3000;

-- 테이블에서 직책이 'CLERK' 인 직원을 조회

select * from emp where job ='CLERK';

-- 급여(SAL)를 기준으로 오름차순 정렬

select * from emp order by sal;

-- EMP 테이블에서 ENAME, SAL, JOB 만 출력

select ename, sal, job from emp;

-- 커미션(COMM)이 NULL인 직원만 조회

select * from emp where comm is null;

-- EMP 테이블에서 중복되지 않는 JOB 목록을 조회

select distinct job from emp;

select distinct sal from emp;

select distinct deptno from emp;

-- 급여(SAL)가 가장 높은 직원의 급여

select * from (select * from emp order by sal desc) where rownum=1;

select max(sal) from emp;

select * from emp where sal = (select max(sal) from emp);

-- EMP 테이블에서 모든 급여의 평균은?

select AVG(sal) from emp ;

