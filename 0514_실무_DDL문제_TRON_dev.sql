select * from member;
select * from prod;
select * from orders;

desc prod;
desc member;
desc orders;

select * from user_constraints 
where table_name ='ORDERS';

select * from user_constraints 
where table_name ='MEMBER';

select * from all_users;

-- MEMBER 테이블에 이메일(EMAIL) 컬럼을 VARCHAR2(30)으로 추가하세요

alter table member add EMAIL VARCHAR2(30);

-- PROD 테이블의 상품명(P_NAME) 컬럼의 길이를 30자로 수정하세요

alter table prod modify p_name VARCHAR2(30);

-- MEMBER 테이블의 이름(NAME) 컬럼에 NOT NULL 제약조건을 추가하세요

alter table member modify name VARCHAR2(10) NOT NULL;

-- ORDERS 테이블의 수량(QTY) 컬럼에 1 이상만 입력되도록 CHECK 제약조건을 추가하세요

alter table orders add constraint CK_QTY check (qty >= 1);
alter table orders modify qty check (qty >= 1);
--alter table orders drop constraint SYS_C0011067;

-- MEMBER 테이블의 전화번호(TEL) 컬럼에 UNIQUE 제약조건을 추가하세요

alter table member modify tel unique; 
-- alter table member drop constraint SYS_C0011069;

-- MEMBER 테이블의 주소(ADDR) 컬럼명을 LOCATION으로 변경하세요

alter table member rename column addr to location;

-- ORDERS 테이블에 배송상태(STATUS) 컬럼을 추가하고, 기본값을 '대기중'으로 설정하세요

alter table orders add status VARCHAR2(10) default '대기중';

-- PROD 테이블에 제조사(MAKER) 컬럼을 VARCHAR2(20)으로 추가하고 NULL을 허용하지 않도록 하세요 (생각을 좀더)

alter table prod add maker varchar2(20) default '' not null;

-- 단계1. prod 테이블에 제조사(maker) 컬럼 추가
ALTER TABLE PROD
  ADD MAKER VARCHAR2(20);

-- 단계2. '기본 제조사' UPDATE
UPDATE PROD
  SET MAKER='기본제조사'; -- 전체행 데이터의 MAKER 항목 수정

--UPDATE PROD
--  SET MAKER='삼성전자'
--  WHERE (P_NO = '1000'); -- P_NO(상품번호)가 1000번인 항목들만 데이터 수정.

--UPDATE PROD
--  SET MAKER='LG전자'
--  WHERE (P_NO = '3000');

-- 단계3 NOT NULL 제약사항 추가 MODIFY 사용
ALTER TABLE PROD 
  MODIFY MAKER VARCHAR2(20) NOT NULL;
  
-- 검증작업 --> INSERT INTO 새로운 레코드 추가, 검증조건 MAKER 입력 안하고 실행
insert into prod (p_no, p_name, price) values('5000', '스페인1달여행', 13000000);
-- 오류발생 --> MAKER컬럼 NULL값 삽입 불가.. ==> ACID == 무결성 --> PK, FK, 제약조건
-- 반드시 MAKER 값이 입력 되어야 한다.
INSERT INTO PROD (P_NO, P_NAME, PRICE, MAKER) VALUES('5000', '스페인1달여행', 13000000, '하나여행사');


-- ORDERS 테이블에 주문 상태(STATUS)에 '배송중', '배송완료', '대기중'만 허용되도록 CHECK 제약조건을 추가하세요
-- ALTER TABLE table_name + ADD, MODIFY, RENAME 
-- CONSTRAINT 제약조건_이름

alter table orders add check (status in('배송중','배송완료','대기중'));

-- MEMBER 테이블에 등록일(REG_DATE) 컬럼을 추가하고, 기본값을 SYSDATE로 설정하세요

alter table member add reg_date date default sysdate;

