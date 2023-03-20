-- 카테고리 테이블
drop table book_category;
create table book_category(
    cate_id varchar2(1000) PRIMARY KEY, -- 카테고리 아이디
    cate_name varchar2(1000) -- 카테고리 이름
);
select *from book_category;
-- 시퀀스 생성
drop sequence cate_seq;
create sequence cate_seq;

-- 카테고리 추가
insert into book_category(cate_id, cate_name) VALUES('information_technology','IT');
insert into book_category(cate_id, cate_name) VALUES('language','언어');
insert into book_category(cate_id, cate_name) VALUES('natural_science','자연과학');
insert into book_category(cate_id, cate_name) VALUES('art','예술');
insert into book_category(cate_id, cate_name) VALUES('hobby','취미');
insert into book_category(cate_id, cate_name) VALUES('license','자격증');

commit;
select * from book_category ; -- 카테고리 목록

-- 서브 카테고리 테이블 
drop table book_subCategory;
create table book_subCategory(
    cate_id varchar2(1000), -- 외래키
    subCate_id varchar2(1000) PRIMARY KEY,
    subCate_name varchar2(1000),
    foreign key(cate_id) references book_category(cate_id)
    on delete cascade
);
-- 시퀀스 생성
drop sequence subCate_seq;
create sequence subCate_seq;

-- 서브 카테고리 추가
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('information_technology', 'programming_language', '프로그래밍언어');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('information_technology', 'database', '데이터베이스');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('information_technology', 'website', '웹사이트');

insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('language', 'english', '영어');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('language', 'japanese', '일본어');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('language', 'chinese', '중국어');

insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('natural_science', 'physics', '물리학');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('natural_science', 'chemistry', '화학');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('natural_science', 'biology', '생명과학');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('natural_science', 'earth_science', '지구과학');

insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('art', 'building', '건축');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('art', 'dancing', '무용');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('art', 'music', '음악');

commit;
select * from book_subCategory;

-- book 테이블 cascade constraint
drop table book_table ;
create table book_table(
    bookNo NUMBER(10), -- 책 번호
    cate_id VARCHAR2(1000) , -- 카테고리, 외래키
    subCate_id VARCHAR2(1000), -- 하위 카테고리, 외래키
    bookName VARCHAR2(1000) NOT NULL, -- 책 제목
    author VARCHAR2(1000), -- 저자
    publisher VARCHAR2(1000),  -- 출판사
    bookImage VARCHAR2(1000), -- 상품 이미지
    price NUMBER(10), -- 판매가격
    take varchar (300), -- 대여상태
    takePrice int not null, --대여금액
    takeDate DATE DEFAULT sysdate, -- 대여일자
    returnDate DATE DEFAULT sysdate+7, -- 반납일자
    regDate DATE DEFAULT sysdate, -- 상품 등록일
    reason varchar(500), --승인 거절시 사유
     constraint primary_bookNo primary key(bookNo),
    foreign key(cate_id) references book_category(cate_id),
    foreign key(subcate_id) references book_subCategory(subCate_id)
    on delete cascade
);

drop sequence bookNo_seq;
create sequence bookNo_seq;

commit;
select * from book_table;


commit;

		select 
			rn, bookNo, cate_id, bookName, author, publisher, take, takePrice, takeDate, returnDate
		from
		(
		    select 
		        rownum as rn, bookNo, cate_id, bookName, author, publisher, take, takePrice, takeDate, returnDate
		    from 
		        book_table
		    where rownum <= 200
    ) 
		where rn > 1 and take ='신청대기';
        
		select 
		    bookNo, cate_id, bookName, author, publisher, take, takePrice, takeDate, returnDate,reason
		from book_table where take ='거절';