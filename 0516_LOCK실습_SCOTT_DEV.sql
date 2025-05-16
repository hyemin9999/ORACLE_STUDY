select * from dept;

-- 교재 294 실습 11-1
create table dept_tcl
 as select * from dept;
 
select * from dept_tcl;
 
 -- 교재 294 실습 11-2
insert into dept_tcl values(50, 'DATABASE','SEOUL');
 
update dept_tcl set loc='BUSAN' where deptno=40;
 
delete from dept_tcl where dname='RESEARCH';
 
select * from dept_tcl;

-- 교재 295 실습 11-3
rollback;

select * from dept_tcl;


-- 교재 304 실습 11-9를하기위한 밑작업
drop table dept_tcl;

create table dept_tcl
 as select * from dept;
 
delete from dept_tcl where deptno =40;

commit;

-- 교재 304 실습 11-9
select * from dept_tcl;

--교재 304 실습 11-10
update dept_tcl set loc='SEOUL' where deptno=30;

select * from dept_tcl;

-- 교재 305 실습 11-11 sqlplus 에서 update 작업.. 쿼리실행시 멈춘것처럼 가만히 있음
-- 교재 306 실습 11-12 실습 11-10에서 update작업중이라서 11-11이 작동되지않음 == LOCK
commit; -- 실행하면 sqlplus 에 update 실행됨.

-- 교재306 실습 11-13
select * from dept_tcl; -- sqlplus 에서 update한 내용이 sql developer 에는 적용이 안됨
-- 교재 307 실습 11-14 commit; -- sqlplus 에서 작업한 내용이 적용됨

--교재 307 실습 11-15
select * from dept_tcl; 



select * from all_tables; -- 접속계정이 접근할 수 있는 테이블 수 104개
-- owner
-- sys => dba
-- system => 물리적으로 관리
-- scott 이 owner 인 테이블 => orcl DB안에 scott 이 만든 DB 4개 (dept_tcl제외)





