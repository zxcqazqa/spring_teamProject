-- ī�װ� ���̺�
drop table book_category;
create table book_category(
    cate_id varchar2(1000) PRIMARY KEY, -- ī�װ� ���̵�
    cate_name varchar2(1000) -- ī�װ� �̸�
);
select *from book_category;
-- ������ ����
drop sequence cate_seq;
create sequence cate_seq;

-- ī�װ� �߰�
insert into book_category(cate_id, cate_name) VALUES('information_technology','IT');
insert into book_category(cate_id, cate_name) VALUES('language','���');
insert into book_category(cate_id, cate_name) VALUES('natural_science','�ڿ�����');
insert into book_category(cate_id, cate_name) VALUES('art','����');
insert into book_category(cate_id, cate_name) VALUES('hobby','���');
insert into book_category(cate_id, cate_name) VALUES('license','�ڰ���');

commit;
select * from book_category ; -- ī�װ� ���

-- ���� ī�װ� ���̺� 
drop table book_subCategory;
create table book_subCategory(
    cate_id varchar2(1000), -- �ܷ�Ű
    subCate_id varchar2(1000) PRIMARY KEY,
    subCate_name varchar2(1000),
    foreign key(cate_id) references book_category(cate_id)
    on delete cascade
);
-- ������ ����
drop sequence subCate_seq;
create sequence subCate_seq;

-- ���� ī�װ� �߰�
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('information_technology', 'programming_language', '���α׷��־��');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('information_technology', 'database', '�����ͺ��̽�');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('information_technology', 'website', '������Ʈ');

insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('language', 'english', '����');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('language', 'japanese', '�Ϻ���');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('language', 'chinese', '�߱���');

insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('natural_science', 'physics', '������');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('natural_science', 'chemistry', 'ȭ��');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('natural_science', 'biology', '�������');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('natural_science', 'earth_science', '��������');

insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('art', 'building', '����');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('art', 'dancing', '����');
insert into book_subCategory(cate_id, subCate_id, subCate_name) VALUES('art', 'music', '����');

commit;
select * from book_subCategory;

-- book ���̺� cascade constraint
drop table book_table ;
create table book_table(
    bookNo NUMBER(10), -- å ��ȣ
    cate_id VARCHAR2(1000) , -- ī�װ�, �ܷ�Ű
    subCate_id VARCHAR2(1000), -- ���� ī�װ�, �ܷ�Ű
    bookName VARCHAR2(1000) NOT NULL, -- å ����
    author VARCHAR2(1000), -- ����
    publisher VARCHAR2(1000),  -- ���ǻ�
    bookImage VARCHAR2(1000), -- ��ǰ �̹���
    price NUMBER(10), -- �ǸŰ���
    take varchar (300), -- �뿩����
    takePrice int not null, --�뿩�ݾ�
    takeDate DATE DEFAULT sysdate, -- �뿩����
    returnDate DATE DEFAULT sysdate+7, -- �ݳ�����
    regDate DATE DEFAULT sysdate, -- ��ǰ �����
    reason varchar(500), --���� ������ ����
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
		where rn > 1 and take ='��û���';
        
		select 
		    bookNo, cate_id, bookName, author, publisher, take, takePrice, takeDate, returnDate,reason
		from book_table where take ='����';