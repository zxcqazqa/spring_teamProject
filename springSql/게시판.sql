drop table board;
create table board(
    bno int not null,
    tid varchar2(300) not null,
    TITLE VARCHAR2(500) NOT NULL,
    CONTENT VARCHAR2(4000),
    WRITER VARCHAR2(100),
    imageFileName VARCHAR2(100),
    fileType varchar2(500),
    WRITEDATE DATE DEFAULT SYSDATE,
    constraint primary_bno primary key(bno),
    constraint fk_tid foreign key(tid) 
    references board_category(tid)
    on delete cascade
);
drop SEQUENCE bno_seq;
create sequence bno_seq; 

drop table board_category;
create table board_category(
    tid varchar(100) primary key,
    tname varchar(200)not null
);
--공지게시물
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'notice','공지제목입니다','내용입니다','관리자');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'notice','공지제목입니다1','내용입니다1','테스터');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'notice','공지제목입니다2','내용입니다2','관리자');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'notice','공지제목입니다3','내용입니다3','테스터');

--문의게시판
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'question','문의제목입니다','내용입니다','회원1');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'question','문의제목입니다1','내용입니다1','회원2');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'question','문의제목입니다2','내용입니다2','회원3');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'question','문의제목입니다3','내용입니다3','회원4');

--도서리뷰게시판
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'review','도서리뷰제목입니다','내용입니다','윤동주');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'review','도서리뷰제목입니다1','내용입니다1','허균');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'review','도서리뷰제목입니다2','내용입니다2','김소월');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'review','도서리뷰제목입니다3','내용입니다3','손흥민');

--기타게시판
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'etc','기타제목입니다','내용입니다','홍길동');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'etc','기타제목입니다1','내용입니다1','히딩크');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'etc','기타제목입니다2','내용입니다2','이순신');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'etc','기타제목입니다3','내용입니다3','송중기');

--카테고리
insert into board_category(tid,tname)values('notice','공지');
insert into board_category(tid,tname)values('question','문의');
insert into board_category(tid,tname)values('review','리뷰');
insert into board_category(tid,tname)values('etc','기타');

commit;

select *from board;
select*from board_category;


---------
select top from board where tid='notice' order by bno desc ;
SELECT * FROM board
WHERE tid='notice' and ROWNUM < 4 order by bno desc;