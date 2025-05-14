-- EMP 테이블에서 SAL이 2000 이상이고 3000 이하인 직원은 -- 이고 ==> and
select * from emp where (2000 <= sal and sal <= 3000);

select * from emp where sal between 2000 and 3000;

-- 부서별(DEPTNO) 급여 평균을 출력하려면?(중급)
-- group by에 사용했던 열과관련해서 select 열이름에 사용가능
select deptno, avg(sal) 급여평균 from emp
  group by deptno 
  order by deptno;

select e.deptno, d.dname, avg(e.sal) 급여평균 from emp e inner join dept d on e.deptno = d.deptno 
  group by e.deptno, d.dname
  order by e.deptno;

select e.deptno, d.dname, round(avg(e.sal)) 급여평균_반올림 from emp e inner join dept d on e.deptno = d.deptno 
  group by e.deptno, d.dname
  order by e.deptno;

-- 직원 이름(ENAME)에 'S'가 포함된 직원은?
select * from emp where ename like '%S%';

select * from emp where upper(ename) like '%S%'; -- like 뒤에 대문자 사용시 ename에 upper함수 사용 대문자로 변경 후 검색
-- 대소문자 가리지 않고 검색하겠다.

select * from emp where instr(ename,'S')>0;

-- EMP 테이블에서 이름(ENAME)이 'A'로 시작하는 직원만 조회하려면?
select * from emp where ename like 'A%';

select * from emp where lower(ename) like 'a%'; -- like 뒤에 소문자 사용시 ename에 lower함수 사용 소문자로 변경 후 검색
-- 대소문자 가리지 않고 검색하겠다.

select * from emp where substr(ename,1,1)='A';

-- EMP 테이블의 입사일(HIREDATE)이 가장 빠른 직원은? (중급|고급)
-- 입사일이 가장 빠른직원 = 제일 먼저 입사한 직원
select * from emp
    where hiredate = (select min(hiredate) from emp);
   
select * from (select * from emp order by hiredate) where rownum=1;

/*select * from emp order by hiredate fetch first 1 rows only; -- 11g안됨 12이상?*/

-- 직원 수를 세는 SQL은?
select count(*) as 직원수 from emp;

-- 부서별 직원수 -- select 에서 count(*) 를 작업해서 order by 에서도 사용가능. asc = 기본,오름차순/ desc = 내림차순
select e.deptno, d.dname, count(*) as 직원수 from emp e join dept d on e.deptno = d.deptno 
group by e.deptno, d.dname
order by count(*);

-- 부서별 직원수 sal>=2000
select e.deptno, d.dname, count(*) as 직원수 from emp e join dept d on e.deptno = d.deptno 
where e.sal >= 2000
group by e.deptno, d.dname
order by count(*) desc;

-- SALGRADE 테이블에서 등급 3에 해당하는 최소급여는?
select losal as 최소급여 from salgrade where grade = 3;

-- 직원의 급여(SAL)를 10% 인상한 결과를 NEW_SAL이라는 별칭으로 출력하는 SQL은?
select (sal * 1.1) as NEW_SAL, emp.* from emp; 

select (NEW_SAL - SAL) as 증가액, e.* from (select (sal * 1.1) as NEW_SAL, emp.* from emp) e; 

select (sal * 1.1) as 인상액,((sal * 1.1)-sal) as 증가액, emp.* from emp; 

select (sal * 1.1) as 인상액,(sal * 0.1) as 증가액, emp.* from emp; 

select (sal * 1.1) as "인상(10%)결과", emp.* from emp; 

-- EMP 테이블에서 급여(SAL)가 3000 이상이거나 직책(JOB)이 'CLERK'인 직원은?
select * from emp where (sal >=3000 or job='CLERK') order by sal, job;

-- EMP 테이블에서 10번 부서가 아닌 직원들을 조회하세요? (3가지 방법으로)
select * from emp where deptno != 10
  order by deptno;
  
select * from emp where deptno ^= 10
  order by deptno;
  
select * from emp where deptno <> 10
  order by deptno;

select * from emp where deptno > 10
  order by deptno;

select * from emp where not deptno = 10 
  order by deptno;
  
  select * from emp where (not deptno = 10) 
  order by deptno;

select * from emp where deptno not in(10)
  order by deptno;

select * from emp 
  where deptno in (select distinct(deptno) from emp where deptno != 10)
  order by deptno;

select * from emp 
  where deptno 
    between (select min(deptno) from emp where deptno!=10 ) and (select max(deptno) from emp where deptno!=10)
  order by deptno;

select * from emp where deptno not like 10
  order by deptno;






