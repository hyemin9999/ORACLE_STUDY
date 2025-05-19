--create table prod(
--p_no varchar2(4) primary key,
--p_name varchar2(20),
--price number(10)
--);
--
--create table cust(
--id varchar2(4) primary key,
--name varchar2(10),
--addr varchar2(10)
--);
--
--create table orders(
--o_no varchar2(5) primary key,
--id varchar2(4) references cust(id),
--p_no varchar2(4) references prod(p_no),
--pay varchar2(5),
--qty number(3)
--);
--
--desc prod;
--desc cust;
--desc orders;
--
--
--insert into prod (p_no, p_name, price) values('0001','M.2 nvme SSD 1TB', 120000);
--insert into prod (p_no, p_name, price) values('0002','MOUSE', 10000);
--insert into prod (p_no, p_name, price) values('0003','GRAPHIC CARD XQ', 200000);
--insert into prod (p_no, p_name, price) values('0004','NOTE_BOOK AT 100', 800000);
--
--insert into cust(id, name, addr) values ('1000', '손흥민', '서울');
--insert into cust(id, name, addr) values ('2000', '이강인', '부천');
--insert into cust(id, name, addr) values ('3000', '황희찬', '인천');
--insert into cust(id, name, addr) values ('4000', '박지성', '수원');
--
--insert into orders(o_no, id, p_no, pay, qty) values ('00001','1000','0001','CARD',2);
--insert into orders(o_no, id, p_no, pay, qty) values ('00002','4000','0003','CASH',1);
--insert into orders(o_no, id, p_no, pay, qty) values ('00003','2000','0002','CARD',4);
--insert into orders(o_no, id, p_no, pay, qty) values ('00004','3000','0004','CASH',1);
--insert into orders(o_no, id, p_no, pay, qty) values ('00005','1000','0002','CARD',4);
--insert into orders(o_no, id, p_no, pay, qty) values ('00006','4000','0001','CARD',1);
--insert into orders(o_no, id, p_no, pay, qty) values ('00007','1000','0004','CARD',1);
--insert into orders(o_no, id, p_no, pay, qty) values ('00008','3000','0003','CARD',1);
--insert into orders(o_no, id, p_no, pay, qty) values ('00009','2000','0001','CASH',1);
--
--COMMIT;
--
--select * from prod;
--select * from cust;
--select * from orders;


-- c.id, c.name, o.o_no, o.p_no, p.p_name, o.qty, (o.qty * p.price)

select c.id 고객ID, c.name 고객이름, o.o_no 주문번호, o.p_no 주문상품번호, p.p_name 주문상품명, o.qty 주문수량, (o.qty * p.price) 주문금액
from cust c, prod p, orders o
where (c.id = o.id and o.p_no = p.p_no)
order by c.id; 


-- count( o.o_no) 주문횟수 3회이상, c.id, c.name, count(o.o_no), sum(o.qty * p.price)
select c.id 고객ID, c.name 고객이름, count(*) 주문횟수합, sum(o.qty * p.price) 주문금액합
from cust c, prod p, orders o
where (c.id = o.id and o.p_no = p.p_no)
group by c.id, c.name
having count(*) >= 3; 


-- 주문금액합 >= 100만원 c.ic, c.name, sum(o.qty * p.price)

select c.id 고객ID, c.name 고객이름, sum(o.qty * p.price) 주문금액합
from cust c, prod p, orders o
where (c.id = o.id and o.p_no = p.p_no)
group by c.id, c.name
having sum(o.qty * p.price) >= 1000000; 

-- cust T grade add 3번문제 해당하는 고객 grade='vip'

alter table cust add grade varchar2(6);

desc cust;


update cust set grade = 'VIP' 
where id in (select o.id
               from prod p, orders o
               where (o.p_no = p.p_no)
               group by o.id
               having sum(o.qty * p.price) >= 1000000); 

commit;

select * from cust;



-- view 생성

-- card_view, c.id, c.name, p.p_name, o.qty, (o.qty * p.price)

select c.id, c.name, p.p_name, o.qty, (o.qty * p.price) o_price
from cust c, prod p, orders o
where (c.id = o.id and o.p_no = p.p_no) and o.pay='CARD'
order by c.id; 


create view card_view as (select c.id, c.name, p.p_name, o.qty, (o.qty * p.price) o_price
from cust c, prod p, orders o
where (c.id = o.id and o.p_no = p.p_no) and o.pay='CARD');

select * from card_view;

desc card_view;

select id 고객ID, name 고객이름, p_name 주문상품명, qty 주문수량, o_price 주문금액 from card_view;






