use madang;
-- TABLE 만들기
CREATE TABLE Book (
  bookid      INTEGER,
  bookname    VARCHAR(40),
  publisher   VARCHAR(40),
  price       INTEGER,
   PRIMARY KEY (bookid)
);

CREATE TABLE  Customer (
  custid      INTEGER,  
  name        VARCHAR(40),
  address     VARCHAR(50),
  phone       VARCHAR(20),
  PRIMARY KEY (custid)
);

CREATE TABLE Orders (
  orderid INTEGER ,
  custid  INTEGER ,
  bookid  INTEGER ,
  saleprice INTEGER ,
  orderdate DATE,
  PRIMARY KEY (orderid),
  FOREIGN KEY (custid) REFERENCES Customer(custid),
  FOREIGN KEY (bookid) REFERENCES Book(bookid)
);
-- 인스턴스 삽입
INSERT INTO Book VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO Book VALUES(2, '축구아는 여자', '나무수', 13000);
INSERT INTO Book VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO Book VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO Book VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO Book VALUES(6, '역도 단계별기술', '굿스포츠', 6000);
INSERT INTO Book VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO Book VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO Book VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 'Pearson', 13000);

INSERT INTO Customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO Customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');  
INSERT INTO Customer VALUES (3, '장미란', '대한민국 강원도', '000-7000-0001');
INSERT INTO Customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전',  NULL);

INSERT INTO Orders VALUES (1, 1, 1, 6000, STR_TO_DATE('2014-07-01','%Y-%m-%d')); 
INSERT INTO Orders VALUES (2, 1, 3, 21000, STR_TO_DATE('2014-07-03','%Y-%m-%d'));
INSERT INTO Orders VALUES (3, 2, 5, 8000, STR_TO_DATE('2014-07-03','%Y-%m-%d')); 
INSERT INTO Orders VALUES (4, 3, 6, 6000, STR_TO_DATE('2014-07-04','%Y-%m-%d')); 
INSERT INTO Orders VALUES (5, 4, 7, 20000, STR_TO_DATE('2014-07-05','%Y-%m-%d'));
INSERT INTO Orders VALUES (6, 1, 2, 12000, STR_TO_DATE('2014-07-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (7, 4, 8, 13000, STR_TO_DATE( '2014-07-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (8, 3, 10, 12000, STR_TO_DATE('2014-07-08','%Y-%m-%d')); 
INSERT INTO Orders VALUES (9, 2, 10, 7000, STR_TO_DATE('2014-07-09','%Y-%m-%d')); 
INSERT INTO Orders VALUES (10, 3, 8, 13000, STR_TO_DATE('2014-07-10','%Y-%m-%d'));

select bookname,price
FROM BOOK;

select price,bookname
from book;

select bookid,bookname,publisher,price
from book;

select *
from book;

select publisher
from book;

select distinct publisher
from book;

select *
from book
where price between 10000 and 20000;

select *
from book
where price >= 10000 and price <= 20000;

select *
from book
where publisher in('굿스포츠','대한미디어');

SELECT	*
FROM	Book
WHERE	publisher NOT IN ('굿스포츠', '대한미디어');


SELECT	bookname, publisher
FROM	Book
WHERE	bookname LIKE '축구의 역사';


SELECT	bookname, publisher
FROM	Book
WHERE	bookname LIKE '%축구%';


SELECT	*
FROM	Book
WHERE	bookname LIKE '_구%';


SELECT	*
FROM	Book
WHERE	bookname LIKE '%축구%' AND price >= 20000;


SELECT	*
FROM	Book
WHERE	publisher ='굿스포츠' OR publisher ='대한미디어';


SELECT	*
FROM	Book
ORDER BY	bookname;


SELECT	*
FROM	Book
ORDER BY	price, bookname;


SELECT 	*
FROM 	Book
ORDER BY 	price DESC, publisher ASC;

select SUM(SALEPRICE)
FROM ORDERS;

select SUM(SALEPRICE) AS 총매출
FROM ORDERS;

SELECT SUM(saleprice) 총매출 FROM	Orders;

SELECT SUM(saleprice) "전체 매출" FROM Orders;


SELECT	SUM(saleprice) AS 총매출
FROM	Orders
WHERE	custid=2;


SELECT	SUM(saleprice) AS Total,
		AVG(saleprice) AS Average,
		MIN(saleprice) AS Minimum,
		MAX(saleprice) AS Maximum
FROM	Orders;


SELECT	COUNT(*)
FROM	Orders;


SELECT	custid, COUNT(*) AS 도서수량, SUM(saleprice) AS 총액
FROM	Orders
GROUP BY	custid;


select * FROM	Orders
order by custid;

SELECT	custid, COUNT(*) AS 도서수량, SUM(saleprice) AS 총액
FROM	Orders
GROUP BY	custid 
ORDER BY  custid; 


SELECT	custid, COUNT(*) AS 도서수량
FROM	Orders
WHERE	saleprice >= 8000
GROUP BY	custid
HAVING	count(*) >= 2;


SELECT	custid, COUNT(*) AS 도서수량	
FROM	Orders				
WHERE	saleprice >= 8000		
GROUP BY	custid				
HAVING	count(*) > 1			
ORDER BY	custid;	


SELECT	custid, COUNT(*)  AS 도서수량	
FROM	Orders	
WHERE	saleprice >= 8000
GROUP BY	custid		
HAVING	count(*) > 1
ORDER BY	custid;	


SELECT	*
FROM	Customer, Orders
WHERE	Customer.custid=Orders.custid;


SELECT	*
FROM	Customer, Orders
WHERE	Customer.custid=Orders.custid
ORDER BY	Customer.custid;


SELECT	name, saleprice
FROM	Customer, Orders
WHERE	Customer.custid=Orders.custid;


SELECT	name, SUM(saleprice)
FROM	Customer, Orders
WHERE	Customer.custid=Orders.custid
GROUP BY	Customer.name
ORDER BY	Customer.name;


SELECT	Customer.name, book.bookname
FROM	Customer, Orders, Book
WHERE	Customer.custid=Orders.custid AND Orders.bookid=Book.bookid;


SELECT	Customer.name, book.bookname
FROM	Customer, Orders, Book
WHERE	Customer.custid=Orders.custid AND Orders.bookid=Book.bookid
			AND Book. price=20000;

SELECT	Customer.name, saleprice
FROM	Customer LEFT OUTER JOIN Orders 
			ON Customer.custid=Orders.custid;

SELECT	bookname
FROM	Book
WHERE	price = (SELECT MAX(price) FROM Book);


SELECT	name
FROM	Customer
WHERE	custid IN (SELECT custid 
                        FROM Orders);

SELECT	name
FROM	Customer
WHERE	custid IN(SELECT	custid
			 FROM		Orders
			 WHERE	bookid IN(SELECT	bookid
						  FROM		Book
						  WHERE	publisher='대한미디어'));


SELECT	b1.bookname
FROM	Book b1
WHERE	b1.price > (SELECT 	avg(b2.price)
			    FROM	Book b2
			    WHERE	b2.publisher=b1.publisher);


SELECT	name
FROM	Customer
WHERE 	address LIKE '대한민국%'
UNION  
SELECT	name
FROM	Customer
WHERE	custid IN (SELECT custid FROM Orders);


SELECT	name
FROM	Customer
WHERE address LIKE '대한민국%'
UNION ALL
SELECT	name
FROM	Customer
WHERE	custid IN (SELECT custid FROM Orders);


SELECT	name, address
FROM	Customer cs
WHERE	EXISTS (SELECT *
		         FROM	   Orders od
			 WHERE   cs.custid=od.custid);



CREATE TABLE	NewBook (
  bookid		INTEGER, 
  bookname		VARCHAR(20),
  publisher		VARCHAR(20),
  price		INTEGER);
  
  /*
  drop table newbook;
  
  CREATE TABLE	NewBook (
  bookid			INTEGER,
  bookname		VARCHAR(20),
  publisher		VARCHAR(20),
  price			INTEGER,
  PRIMARY KEY		(bookid)
);

  drop table newbook;
  
  CREATE TABLE	NewBook (
  bookid			INTEGER	PRIMARY KEY,
  bookname		VARCHAR(20),
  publisher		VARCHAR(20),
  price			INTEGER
);
  
drop table newbook;

CREATE TABLE 	NewBook (
  bookname		VARCHAR(20),
  publisher		VARCHAR(20),
  price 			INTEGER,
  PRIMARY KEY	(bookname, publisher)
);    
  
drop table newbook;


CREATE TABLE 	NewBook (
  bookname		VARCHAR(20)	NOT NULL,
  publisher		VARCHAR(20)	UNIQUE,
  price			INTEGER DEFAULT 10000 CHECK(price > 1000),
  PRIMARY KEY		(bookname, publisher)
);
  */
  
CREATE TABLE	NewCustomer (
  custid		INTEGER	PRIMARY KEY,
  name		VARCHAR(40),
  address		VARCHAR(40),
  phone		VARCHAR(30));
    

CREATE TABLE	NewOrders (
  orderid	INTEGER,
  custid	INTEGER	NOT NULL,
  bookid	INTEGER	NOT NULL,
  saleprice	INTEGER,
  orderdate	DATE,
  PRIMARY KEY(orderid),
  FOREIGN KEY(custid) REFERENCES NewCustomer(custid) ON DELETE CASCADE);


ALTER TABLE NewBook ADD isbn VARCHAR(13);

ALTER TABLE NewBook MODIFY isbn INTEGER;

ALTER TABLE NewBook DROP COLUMN isbn;

ALTER TABLE NewBook MODIFY bookid INTEGER NOT NULL;

ALTER TABLE NewBook ADD PRIMARY KEY(bookid);

DROP TABLE NewBook;

DROP TABLE NewCustomer;
select * from NewCustomer;

DROP TABLE NewOrders;
DROP TABLE NewCustomer;

select * from newbook;
select * from NewCustomer;
select * from neworders;


INSERT INTO Book(bookid, bookname, publisher, price)
	    VALUES (11, '스포츠 의학', '한솔의학서적', 90000);
        
select  * from book;        


INSERT INTO Book(bookid, bookname, publisher)
	   VALUES (14, '스포츠 의학', '한솔의학서적');
       
select * from book;

INSERT INTO Book(bookid, bookname, price, publisher)
	   SELECT	bookid, bookname, price, publisher
	   FROM 	Imported_book;
       
select * from book;


UPDATE	Customer
SET		address ='대한민국 부산'
WHERE	custid=5;


UPDATE book 
SET    publisher = (SELECT publisher 
                    FROM   imported_book 
                    WHERE  bookid = '21') 
WHERE  bookid = '14' ;

select * from book;


DELETE FROM Book 
WHERE  bookid = '11'; 

select * from book;


DELETE	FROM	Customer;

