--시나리오
--[시나리오 제시]
--온라인 쇼핑몰 데이터베이스를 구축하려고 한다. 아래의 요구사항을 참조하여 작업하시오.
--
--DBMS 는 Oracle을 사용합니다 (작업은 sqlplus에서 진행 - SYSTEM, 관련 sql과 실행결과 제출)
--
--데이터베이스명 : orcl
--계정 (user) : USER01
--비밀번호 : test
--권한부여 작업

-- sqlplus system/oracle -- 사용자 생성 및 권한 부여 resource, connect
--------------------------------------------

--테이블과 Data는 첨부 참조. 이하 작업은 생성된 계정에서 진행합니다

-- 테이블 생성, 제약조건 PK, FK구현

CREATE TABLE prod (
prod_no varchar2(4) PRIMARY KEY,
prodname varchar2(20),
price number(10)
);

CREATE TABLE cust (
cust_id varchar2(4) PRIMARY KEY,
name varchar2(10),
addr varchar2(10)
);

CREATE TABLE orders (
order_no varchar2(5) PRIMARY KEY,
cust_id varchar2(4) REFERENCES cust(cust_id),
prod_no varchar2(4) REFERENCES prod(prod_no),
o_payment varchar2(4),
qty number(4)
);

DESC prod;
DESC cust;
DESC orders;

-- 데이터 삽입

INSERT INTO prod (prod_no, prodname, price) VALUES ('0001','M.2 nvme SSD 1TB', 120000);
INSERT INTO prod (prod_no, prodname, price) VALUES ('0002','MOUSE', 10000);
INSERT INTO prod (prod_no, prodname, price) VALUES ('0003','GRAPHIC CARD XQ', 200000);
INSERT INTO prod (prod_no, prodname, price) VALUES ('0004','NOT_BOOK AT 100', 800000);

INSERT INTO cust (cust_id, name, addr) VALUES ('1000','이몽룡','한양');
INSERT INTO cust (cust_id, name, addr) VALUES ('2000','성춘향','남원');
INSERT INTO cust (cust_id, name, addr) VALUES ('3000','향단이','남원');
INSERT INTO cust (cust_id, name, addr) VALUES ('4000','방자','한양');

INSERT INTO orders (order_no, cust_id, prod_no, o_payment, qty) VALUES ('00001','1000','0001','CARD', 2);
INSERT INTO orders (order_no, cust_id, prod_no, o_payment, qty) VALUES ('00002','4000','0003','CASH', 1);
INSERT INTO orders (order_no, cust_id, prod_no, o_payment, qty) VALUES ('00003','2000','0002','CARD', 4);
INSERT INTO orders (order_no, cust_id, prod_no, o_payment, qty) VALUES ('00004','3000','0004','CASH', 1);
INSERT INTO orders (order_no, cust_id, prod_no, o_payment, qty) VALUES ('00005','1000','0002','CARD', 4);
INSERT INTO orders (order_no, cust_id, prod_no, o_payment, qty) VALUES ('00006','4000','0001','CARD', 1);
INSERT INTO orders (order_no, cust_id, prod_no, o_payment, qty) VALUES ('00007','1000','0004','CARD', 1);
INSERT INTO orders (order_no, cust_id, prod_no, o_payment, qty) VALUES ('00008','3000','0003','CARD', 1);
INSERT INTO orders (order_no, cust_id, prod_no, o_payment, qty) VALUES ('00009','2000','0001','CASH', 1);

SELECT * FROM prod;
SELECT * FROM cust;
SELECT * FROM orders;

--다음 작업을 수행하세요 (sql 명령문과 실행 결과를 제출)
--
--고객별로
--고객ID, 고객이름,주문번호, 주문상품번호, 주문상품명, 주문수량, 주문금액을
--출력하는 SQL을 작성하시오

--고객ID, 고객이름, -- cust
-- 주문번호, 주문상품번호, -- orders
-- 주문상품명, -- prod
-- 주문수량, -- orders
-- 주문금액 ==> price * qty 

--SELECT * FROM cust c, orders o, prod p -- join
--WHERE ((c.cust_id = o.cust_id) AND (o.prod_no =p.prod_no));

SELECT c.cust_id AS 고객ID, c.name 고객이름, o.order_no, o.prod_no, p.prodname, o.qty, (p.price * o.qty) , (p.price * o.qty) 주문금액
FROM cust c, orders o, prod p -- join
WHERE ((c.cust_id = o.cust_id) AND (o.prod_no =p.prod_no));

--
--주문회수가 3회 이상인
--고객 ID , 고객이름, 주문횟수합, 주문금액 합을 출력하는
--SQL을 작성하시오

SELECT c.cust_id AS 고객ID, c.name 고객이름, o.order_no, o.prod_no, p.prodname, o.qty, (p.price * o.qty) , (p.price * o.qty) 주문금액
FROM cust c, orders o, prod p -- join
WHERE ((c.cust_id = o.cust_id) AND (o.prod_no =p.prod_no))
ORDER BY c.cust_id;

-- 고객 ID , 고객이름, -- GROUP BY
-- 주문횟수합 ==> COUNT() 
-- 주문금액 합을 출력하는 == SUM()

SELECT c.cust_id AS 고객ID, c.name 고객이름, COUNT(*), SUM(p.price * o.qty)
FROM cust c, orders o, prod p -- join
WHERE ((c.cust_id = o.cust_id) AND (o.prod_no =p.prod_no))
GROUP BY c.cust_id, c.name
ORDER BY c.cust_id;

-- 주문횟수가 3회 이상 ==>주문테이블에 주문고객의 수가 3회 이상

SELECT c.cust_id AS 고객ID, c.name 고객이름, COUNT(*), SUM(p.price * o.qty)
FROM cust c, orders o, prod p -- join
WHERE ((c.cust_id = o.cust_id) AND (o.prod_no =p.prod_no))
GROUP BY c.cust_id, c.name
  HAVING (COUNT(*) >= 3)
--ORDER BY c.cust_id;

--
--CUST table에 GRADE컬럼을 추가하고 조건
--(주문금액 합이 100만원 이상 고객)에 해당하는 고객은 GRADR열에
--VIP로 등록하는 SQL을 작성하고
--결과를 출력하시오

-- 컬럼 추가
ALTER TABLE cust ADD grade varchar2(3);

select * from cust;

--(주문금액 합이 100만원 이상 고객)
SELECT c.cust_id AS 고객ID, c.name 고객이름, COUNT(*), SUM(p.price * o.qty)
FROM cust c, orders o, prod p -- join
WHERE ((c.cust_id = o.cust_id) AND (o.prod_no =p.prod_no))
GROUP BY c.cust_id, c.name
  HAVING (SUM(p.price * o.qty) >= 1000000);

-- 해당하는 고객은 GRADR열에 VIP로 등록하는 SQL을 작성하고 ==3000향단, 1000몽룡
UPDATE cust SET GRADE='VIP'
WHERE (cust_id = 3000 OR cust_id = 1000);

select * from cust;

--결제수단이 CASH인 고객을 조회하는 뷰 생성하여 저장하시오. ==> 뷰생성권한이 필요함
--- (VIEW 이름은 CASH_VIEW 로 지정)
--
--고객 ID, 고객이름, -- cust
-- 주문번호, -- orders  
-- 주문상품명, -- prod
-- 결제수단, --orders
-- 주문수량, orders
-- 주문금액 ==> p.price * o.qty 을 조회하는
----------------------------------------------------------------
--sqlplus
--SQL> SHOW USER; --현재 접속된 사용자 ==> system --> user03 권한줄수있음
--SQL> CONN system/oracle ==> system 접속
--SQL> SHOW USER; ==> USER은 "SYSTEM"입니다
--SQL> GRANT create view TO user03; ==> 권한이 부여되었습니다.
-----------------------------------------------------------------

SELECT c.cust_id AS 고객ID, c.name 고객이름, o.order_no, p.prodname, o.o_payment, o.qty, (p.price * o.qty)
FROM cust c, orders o, prod p -- join
WHERE (((c.cust_id = o.cust_id) AND (o.prod_no =p.prod_no)) AND o.o_payment='CASH'); -- 뷰를 만들 select.

-- 뷰생성
CREATE VIEW cash_view 
AS (SELECT c.cust_id, c.name, o.order_no, p.prodname, o.o_payment, o.qty, (p.price * o.qty) as qty_price
    FROM cust c, orders o, prod p -- join
    WHERE (((c.cust_id = o.cust_id) AND (o.prod_no =p.prod_no)) AND o.o_payment='CASH')) ;

SELECT * FROM cash_view;

--해당 뷰를 이용하여
--고객별로
--고객 ID, 고객이름, 주문번호, 주문상품명, 결제수단, 주문수량, 주문금액을 조회하는
--SQL을 작성하시오

SELECT * FROM cash_view;
--
--툴을 이용해서 ERD를 생성후 제출하세요


