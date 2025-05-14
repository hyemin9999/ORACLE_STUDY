-- EMP 테이블에서 급여가 3000 이상인 직원만 조회
-- where 조건작업시 ()사용해서 명확하게 구분을 한다.
select * from emp where (sal >=3000);

-- join 필요 이유 --> 2개이상의 테이블을 하나의 테이블처럼 사용하기 위해서
-- 필요 내용 --> 별칭 : 컬럼, 테이블, 임의의 계산식
-- 공유방 --> 조인할때_db서버에서 벌어지는 단계와 sql간의 관계.png (반드시 이해)
select e.ename, e.job, e.deptno, d.dname, d.loc 
  from emp e, dept d -- 데카르트의 곱 (table a, table b 갯수의곱 ==> 14 * 4 = 56)
  where (E.DEPTNO = D.DEPTNO); -- 반드시 ( ) 사용 -- e.deptno 기준 ==> left inner join


-- do it 8장 --> join
-- 등가 조인 --> inner join --> join할 테이블 2개가 동일한 컬럼을 가질때 사용
-- 비등가 조인 --> EMP, SALGRADE join


-- do it 4-5 
-- 4-9
select ename, sal, (sal*12*comm), comm from emp; -- (sal*12*comm)검색값의 열이름은 (sal*12*comm)와 동일함.

-- 4-11
select ename, sal, (sal*12*comm) as annsal, comm from emp; -- (sal*12*comm)검색값의 열이름을 별칭으로 보이도록하고 별칭은 'annsal'
-- as annsal == anasal 사용가능. ==> as 생략 가능.

select e.ename, e.job, e.deptno, d.dname, d.loc from emp e, dept d where (E.DEPTNO = D.DEPTNO) and (sal >=3000);
-- deptno가 동일한것을 찾고(14) 그중 e.sal 의값을 검색하는것이
-- emp & dept 의값에서 (56) e.sal의 값을 검색하고 (emp 3* dept m) deptno가 동일한것을 찾는게 더 시간이 오래걸림...
-- 따라서 where문도 좀더 빠르게 데이터를 찾을수있도록 해야한다.

select * from salgrade;

-- 비등가 조인 emp, salgrade  
-- emp사원의 급여에 대해 salgrade을 사용해서 급여 등급을 알아보자
select * from emp e, salgrade s where (e.sal between s.losal and s.hisal);

-- 8-8
select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename 
  from emp e1, emp e2 
  where (e1.mgr=e2.empno); -- 결과값이 13개인이유는 king의경우 mgr값이 없기때문.

-- 8-13
select e.empno, e.ename,e.job, e.mgr,e.hiredate, e.sal, e.comm, e.deptno, d.dname, d.loc
  from emp e join dept d on (e.deptno = d.deptno)
  where sal >= 3000
  order by e.deptno, empno;

select e.empno, e.ename,e.job, e.mgr,e.hiredate, e.sal, e.comm, e.deptno, d.dname, d.loc
  from emp e , dept d 
  where (e.deptno = d.deptno) and sal >= 3000
  order by e.deptno, empno;


-- order by 
select sal, empno, ename, deptno from emp order by sal desc, empno;


/*
[ 잘못된 사용 ]

① job = NULL (NULL은 비교 연산자를 사용할 수 없다) 
② job != NULL (NULL은 비교 연산자를 사용할 수 없다) 
③ job = '' (빈 문자열은 비교 연산자를 사용할 수 없다) 
④ ☆☆☆☆ sal + NULL (수치값에 NULL을 사칙연산하면 결과는 NULL 이다) 

[ 올바른 사용 ]

① job IS NULL (NULL을 조건으로 사용할 때는 IS NULL을 사용한다)
② job IS NOT NULL (NULL을 조건으로 사용할 때는 IS NOT NULL을 사용한다)
③ job IS NULL (빈 문자열은 NULL을 사용한다)
④ sal + NVL(NULL, 0) (수치값 또는 컬럼은 NULL이 존재할 경우 NVL로 치환한다) -- NULL값을 전처리 사용 예시*/

-- 함수 교재 p127 6장 ==> 오라클 함수 DECODE함수와 CASE 문
-- do it 6장 --> LIKE 연산자 사용법 숙지 LIKE '%A%', 그외 필요시 구글링을 통해 검색;

-- MAX() --> 오라클 내장 함수 --> 외장함수의경우 import 필요
-- 급여(SAL)가 가장 높은 직원의 급여

select * from (select * from emp order by sal desc) where rownum=1;

select max(sal) from emp;

select * from emp where sal = (select max(sal) from emp);


-- AVG()
-- EMP 테이블에서 모든 급여의 평균은?

select AVG(sal) from emp ;


