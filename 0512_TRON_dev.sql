--create table MEMBER
--(
--    ID      varchar2(4) PRIMARY KEY,
--    NAME    varchar2(10),
--    ADDR    varchar2(10),
--    TEL     varchar2(4)
--);
--
--select * from user_tables;
--
--select * from member;
--    
--desc member;
--
-- drop table member; -- DDL(Define --> auto commit) 정의어
-- drop table prod;
 drop table orders;
--
--create table PROD
--(
--    P_NO        varchar2(4) primary key,
--    P_NAME      varchar2(20),
--    PRICE       number(8)
--);
-- -- 제약사항 2번 simple 방식 FK
--create table ORDERS
--(
--    O_NO        varchar2(8) primary key,
--    ID          varchar2(4) REFERENCES member(id),
--    P_NO        varchar2(4) references prod(p_no),
--    O_DATE      date,
--    QTY         number(4)
--);

-- -- 제약사항 기본방식 FK
--create table ORDERS
--(
--    O_NO        varchar2(8) primary key,
--    ID          varchar2(4) CONSTRAINT FK_ID REFERENCES member(id),
--    P_NO        varchar2(4) CONSTRAINT FK_P_NO references prod(p_no),
--    O_DATE      date,
--    QTY         number(4)
--);


--
-- -- DML
--insert into member values ('1000','홍길동','전국구','1234');
--insert into member values ('2000','이몽룡','서울','5678');
--insert into member values ('3000','성춘향','남원','8765');
--insert into member values ('4000','향단이','남원','1000');
--
--insert into prod values ('1000','노트북 X-100',1200000);
--insert into prod values ('2000','마우스 M-5000',50000);
--insert into prod values ('3000','M.2 1T',100000);
--insert into prod values ('4000','VGA RTX-4070',1300000);
--
--insert into orders values ('23121001', '2000','4000','2023-12-01',1);
--insert into orders values ('23121002', '2000','1000','2023-12-05',1);
--insert into orders values ('23121003', '3000','1000','2023-12-10',1);
--insert into orders values ('23121004', '4000','2000','2023-12-13',5);
--insert into orders values ('23121005', '1000','3000','2023-12-13',1);


select * from member;
select * from prod;
select * from orders;

commit;


select * from USER_CONSTRAINTS;

desc member;


