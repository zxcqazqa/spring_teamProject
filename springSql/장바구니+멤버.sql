drop table mem_tbl;
create table mem_tbl(
    mno number(10) primary key, 
    id varchar(20) not null unique,  
    pwd varchar(20) not null,
    name varchar(20) not null,
    age int,
    gender varchar(20),
    email varchar(50),
    profile varchar(50)
);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             


DROP SEQUENCE mno;
create sequence mno;

INSERT INTO mem_tbl(mno,id,pwd,name,age,gender,email,profile)
VALUES(mno.NEXTVAL,'jang','1234', '장봉준',20,'남자','jang@example.com', null);
INSERT INTO mem_tbl(mno,id,pwd,name,age,gender,email,profile)
VALUES(mno.NEXTVAL,'kang','1234', '강의식',20,'남자','kang@example.com', null);
INSERT INTO mem_tbl(mno,id,pwd,name,age,gender,email,profile)
VALUES(mno.NEXTVAL,'park','1234', '박성우',20,'남자','park@example.com', null);

select * from mem_tbl;



drop table cart_table;
create table cart_table(
    cartNo NUMBER(10) PRIMARY KEY, -- 카트번호
    id varchar(20), -- 회원아이디, 외래키
    bookNo NUMBER(10) UNIQUE, -- 책 번호, 외래키
    amount number(10),
    foreign key(id) references mem_tbl(id),
    foreign key(bookNo) references book_table(bookNo)
);

drop sequence cartNo_seq;
create sequence cartNo_seq;

select * from test_cart where mid='lee';
select * from test_cart where mid='hong';
select * from test_cart where mid='kim';