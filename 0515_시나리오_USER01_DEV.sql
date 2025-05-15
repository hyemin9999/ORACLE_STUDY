
-- SYS 계정으로 만듬, 사용자 생성 및 권한을 줄수있는 권한이 있는 사용자여야함.
----[시나리오 제시]
----온라인 쇼핑몰 데이터베이스를 구축하려고 한다. 아래의 요구사항을 참조하여 작업하시오.
----
----DBMS 는 Oracle을 사용합니다 (관련 sql과 실행결과 제출)
----
----데이터베이스명 : orcl
----계정 (user) : USER01
----비밀번호 : test
--
--CREATE USER USER01 IDENTIFIED BY test;
--GRANT RESOURCE, CONNECT TO USER01;
--GRANT CREATE VIEW TO USER01;
--
--SELECT * FROM ALL_USERS WHERE USERNAME='USER01';
--SELECT * FROM DBA_USERS WHERE USERNAME='USER01';

---- 테이블과 Data는 첨부 참조

CREATE TABLE PROD (
  PROD_NO VARCHAR2(4) PRIMARY KEY,
  PRODNAME VARCHAR2(20),
  PRICE NUMBER(10)
);

CREATE TABLE CUST (
  CUST_ID VARCHAR2(4) PRIMARY KEY,
  NAME VARCHAR2(10),
  ADDR VARCHAR2(10)
);

CREATE TABLE ORDERS(
  ORDER_NO VARCHAR2(5) PRIMARY KEY,
  CUST_ID VARCHAR2(4) REFERENCES CUST(CUST_ID),
  PROD_NO VARCHAR2(4) REFERENCES PROD(PROD_NO),
  O_PAYMENT VARCHAR2(4),
  QTY NUMBER(3)
);

DESC PROD;
DESC CUST;
DESC ORDERS;

INSERT INTO PROD (PROD_NO, PRODNAME, PRICE)
  VALUES ('0001', 'M.2 nvme SSD 1TB', 120000);
INSERT INTO PROD (PROD_NO, PRODNAME, PRICE)
  VALUES ('0002', 'MOUSE', 10000);
INSERT INTO PROD (PROD_NO, PRODNAME, PRICE)
  VALUES ('0003', 'GRAPHIC CARD', 200000);
INSERT INTO PROD (PROD_NO, PRODNAME, PRICE)
  VALUES ('0004', 'NOTE_BOOK AT 100', 800000);

INSERT INTO CUST (CUST_ID, NAME, ADDR)
  VALUES ('1000', '이몽룡', '한양');
INSERT INTO CUST (CUST_ID, NAME, ADDR)
  VALUES ('2000', '성춘향', '남원');
INSERT INTO CUST (CUST_ID, NAME, ADDR)
  VALUES ('3000', '향단이', '남원');
INSERT INTO CUST (CUST_ID, NAME, ADDR)
  VALUES ('4000', '방자', '한양');
  
INSERT INTO ORDERS (ORDER_NO, CUST_ID, PROD_NO, O_PAYMENT, QTY)
  VALUES ('00001', '1000', '0001', 'CARD', 2);
INSERT INTO ORDERS (ORDER_NO, CUST_ID, PROD_NO, O_PAYMENT, QTY)
  VALUES ('00002', '4000', '0003', 'CASH', 1);
INSERT INTO ORDERS (ORDER_NO, CUST_ID, PROD_NO, O_PAYMENT, QTY)
  VALUES ('00003', '2000', '0002', 'CARD', 4);  
INSERT INTO ORDERS (ORDER_NO, CUST_ID, PROD_NO, O_PAYMENT, QTY)
  VALUES ('00004', '3000', '0004', 'CASH', 1);  
INSERT INTO ORDERS (ORDER_NO, CUST_ID, PROD_NO, O_PAYMENT, QTY)
  VALUES ('00005', '1000', '0002', 'CARD', 4);  
INSERT INTO ORDERS (ORDER_NO, CUST_ID, PROD_NO, O_PAYMENT, QTY)
  VALUES ('00006', '4000', '0001', 'CARD', 1);  
INSERT INTO ORDERS (ORDER_NO, CUST_ID, PROD_NO, O_PAYMENT, QTY)
  VALUES ('00007', '1000', '0004', 'CARD', 1);  
INSERT INTO ORDERS (ORDER_NO, CUST_ID, PROD_NO, O_PAYMENT, QTY)
  VALUES ('00008', '3000', '0003', 'CARD', 1);  
INSERT INTO ORDERS (ORDER_NO, CUST_ID, PROD_NO, O_PAYMENT, QTY)
  VALUES ('00009', '2000', '0001', 'CASH', 1);
  
    
SELECT * FROM PROD;
SELECT * FROM CUST;
SELECT * FROM ORDERS;

--다음 작업을 수행하세요 (sql 명령문과 실행 결과를 제출)
--고객별로
--고객ID, 고객이름,주문번호, 주문상품번호, 주문상품명, 주문수량, 주문금액을
--출력하는 SQL을 작성하시오

select c.cust_id 고객ID, c.name 고객이름, o.order_no 주문번호, 
       p.prod_no 주문상품번호, p.prodname 주문상품명, 
       o.qty 주문수량, (p.price * o.qty) 주문금액 
  from orders o, cust c, prod p
  where o.cust_id = c.cust_id and o.prod_no = p.prod_no
  order by c.cust_id;
  
  
--주문회수가 3회 이상인
--고객 ID , 고객이름, 주문횟수합, 주문금액 합을 출력하는
--SQL을 작성하시오

select c.cust_id 고객ID, c.name 고객이름, count(*) 주문횟수합, sum(p.price * o.qty) 주문금액합
from orders o, cust c, prod p
where o.cust_id = c.cust_id and o.prod_no = p.prod_no
group by c.cust_id , c.name
  having count(*)>=3;
  
--CUST table에 GRADE컬럼을 추가하고 조건
--(주문금액 합이 100만원 이상 고객)에 해당하는 고객은 GRADR열에
--VIP로 등록하는 SQL을 작성하고
--결과를 출력하시오

ALTER TABLE CUST 
  ADD GRADE VARCHAR2(5); -- 컬럼 추가 


select c.cust_id 고객ID, sum(p.price * o.qty) 주문금액합
from orders o, cust c, prod p
where o.cust_id = c.cust_id and o.prod_no = p.prod_no
group by c.cust_id , c.name
having sum(p.price * o.qty) >= 1000000;

--select cust_id
--               from (select o.cust_id, (p.price * o.qty) oprice
--                     from orders o, prod p
--                     where o.prod_no = p.prod_no
--                     order by o.cust_id)
--               group by cust_id
--               having sum(oprice)>= 1000000;

update cust 
set grade='VIP'
where cust_id in(select c.cust_id 
                 from orders o, cust c, prod p
                 where o.cust_id = c.cust_id and o.prod_no = p.prod_no
                 group by c.cust_id , c.name
                 having sum(p.price * o.qty) >= 1000000);
  
select * from cust;
  
--결제수단이 CASH인 고객을 조회하는 뷰 생성하여 저장하시오.
--(VIEW 이름은 CASH_VIEW 로 지정)

-- 결제수단 CASH 고객정보 -- 하단문제의 뷰 사용값을 생각후 해당 뷰를 만들어야함.
select c.cust_id, c.name, o.order_no, p.prodname, o.o_payment, 
       o.qty, (p.price * o.qty) qty_price 
from orders o, cust c, prod p
where (o.cust_id = c.cust_id and o.prod_no = p.prod_no) and o.o_payment='CASH';

-- 뷰 생성 -- 뷰생성을 위한 권한 CREATE VIEW가 필요
create view CASH_VIEW 
  as (select c.cust_id, c.name, o.order_no, p.prodname, o.o_payment, o.qty, (p.price * o.qty) qty_price 
from orders o, cust c, prod p
where (o.cust_id = c.cust_id and o.prod_no = p.prod_no) and o.o_payment='CASH');

select * from user_views where view_name='CASH_VIEW';

--해당 뷰를 이용하여
--고객별로
--고객 ID, 고객이름, 주문번호, 주문상품명, 결제수단, 주문수량, 주문금액을 조회하는
--SQL을 작성하시오

select * from cash_view;

-- 툴을 이용해서 ERD를 생성후 제출하세요

