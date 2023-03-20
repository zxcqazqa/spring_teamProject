drop table hopeBook;
create table hopeBook( --비치희망도서 신청 테이블
    rno int not null, --새도서 신청번호
    mNum Number(10)not null ,
    mid VARCHAR2(1000) not null , 
    mname varchar(1000)not null ,-- 멤버번호 신청자는 나중에 회원작성되면 바뀜
    nbookName varchar(500) not null, --새 책이름 차후에 조인필요
    nbookWriter varchar(500) not null, -- 새책의 저자
    npublisher varchar(500) not null, -- 새 책의 출판사
    requestDate Date Default sysdate, -- 신청날짜
    result varchar(500), -- 신청결과 입력받아야함
    etc varchar(500), -- 비고란 (거절시 사유입력받기)
    constraint primary_rno primary key(rno),
    constraint fk_mid foreign key(mid)
    references test_member(mid)
    on delete cascade
);

drop SEQUENCE rno_seq;
create SEQUENCE rno_seq;

insert into hopeBook(rno,mNum,mid,mname,nbookName,nbookWriter,npublisher,result,etc)
values(rno_seq.nextval,1,'hong','홍길동','홍길동전','허균','대구시','승인대기','');
insert into hopeBook(rno,mNum,mid,mname,nbookName,nbookWriter,npublisher,result,etc)
values(rno_seq.nextval,2,'lee','이순신','그것이 알고싶다','김상중','서울','승인대기','');
insert into hopeBook(rno,mNum,mid,mname,nbookName,nbookWriter,npublisher,result,etc)
values(rno_seq.nextval,3,'kim','김유신','수학의정석','김수학','나비출판사','승인대기','');

select* from hopeBook;
SELECT MAX(Rno)+1 as NewRno FROM hopeBook;
commit;


--update hopeBook set result ='거절', etc='그냥' where rno=1;

select *from hopeBook where result='승인대기' and mname = '홍길동';

		select 
		    rno,mNum,mid,mname,nbookName,nbookWriter,npublisher,result,etc
		from
		(
		    select 
		        /*+ index_desc(hopeBook primary_rno) */
		       rownum as rn, rno,mNum,mid,mname,nbookName,nbookWriter,npublisher,result,etc
		    from 
		        hopeBook
		    where rownum <= 10
        ) 
		where rn > 1 and result ='승인대기';