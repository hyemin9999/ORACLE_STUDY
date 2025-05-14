-- 부서별(DEPTNO) 평균 급여가 2000 이상인 부서의 부서 번호와 평균 급여를 조회하시오 (고급)

select deptno, AVG(sal) as avg_sal from emp 
group by deptno
  having avg(sal) >= 2000;

select deptno 급여, avg_sal 평균급여
from (select deptno, AVG(sal) as avg_sal from emp group by deptno)
where avg_sal >= 2000;

select e1.deptno 부서번호, d.dname 부서이름, e1.avg_sal 평균급여 
from (select deptno, avg_sal
      from (select deptno, AVG(sal) as avg_sal from emp group by deptno)
      where (avg_sal >= 2000)) e1 join dept d on e1.deptno = d.deptno; 

-- + job(직책)이 'CLERK' 제외

select deptno, AVG(sal) as avg_sal from emp 
where job !='CLERK'
group by deptno
  having avg(sal) >= 2000;

select e1.deptno 부서번호, d.dname 부서명, e1.avg_sal 평균급여 
from (select deptno, AVG(sal) as avg_sal from emp 
      where job !='CLERK'
        group by deptno
          having avg(sal) >= 2000) e1
join dept d on e1.deptno = d.deptno;                                                
                                                
-- 직원 이름(ENAME)과 해당 직원의 부서 이름(DNAME)을 출력하시오. 단, DALLAS에 있는 부서의 직원만 조회하시오

select e.ename, d.dname , d.loc
from emp e, dept d 
where (e.deptno = d.deptno and d.loc = 'DALLAS'); 

select e.ename 이름, d.dname 부서이름, d.loc 지역 
from emp e , (select * from dept where loc='DALLAS') d
where e.deptno = d.deptno;

-- 급여가 전체 평균 급여보다 높은 직원의 이름과 급여를 조회하시오
select avg(sal) from emp; -- 급여 전체 평균

select ename 직원, sal 급여 from emp where sal > (select avg(sal) from emp);

-- 커미션(COMM)을 받는 직원 수를 구하시오 -- COMM 컬럼명을 알려주는건 상세한 상황
-- 추가수당을 받는 직원 수를 구하시오 
-- 기본적으로 컬럼명 외 다른 단어로 이야기하면 해당 단어가 어떤 컬럼인지 알아야 한다. ==> 테이블 명세서 필요
-- select count(comm) 커미션받는직원수 from emp where comm != 0; -- DB관점에서는 comm에 값이 0이 있어도 not null이므로
-- 0도 추가수당을 받는것으로 함.

select count(comm) 커미션받는직원수 from emp; -- DB관점으로는 comm값이 is not null 이면 값이 있는것으로 함. ☆☆☆ 시험때 안봐줄것.

-- 급여가 2000 이상 3000 이하이고, 직책(JOB)이 'MANAGER'인 직원의 이름과 급여를 조회하시오

select ename 이름, sal 급여, job 직책 from emp where (2000 <= sal and sal <= 3000) and job='MANAGER';

-- 직원의 이름, 급여, 그리고 SALGRADE 등급을 함께 출력하시오.

select e.ename 이름, e.sal 급여, s.grade 등급 from emp e, salgrade s 
where s.losal <= e.sal and e.sal <= s.hisal;

-- 각 직원의 '이름'과 그 직원의 '상사' 이름을 함께 출력하시오. (상사가 없는 경우는 제외) (별칭 사용 : '이름' , '상사')
-- 셀프 조인 
select e1.empno, e1.ename 이름, e2.ename 상사, e2.empno from emp e1, emp e2 where e1.mgr = e2.empno;

select e2.ename 이름, e2.empno, e1.empno, e1.ename 상사 from emp e1, emp e2 where e1.empno  = e2.mgr;
select e1.empno, e1.ename 상사, e2.ename 이름, e2.empno, e2.mgr from emp e1, emp e2 where e1.empno  = e2.mgr;

