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

alter table orders add check (qty >= 1);
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

-- ORDERS 테이블에 주문 상태(STATUS)에 '배송중', '배송완료', '대기중'만 허용되도록 CHECK 제약조건을 추가하세요

alter table orders add check (status in('배송중','배송완료','대기중'));

-- MEMBER 테이블에 등록일(REG_DATE) 컬럼을 추가하고, 기본값을 SYSDATE로 설정하세요

alter table member add reg_date date default sysdate;

