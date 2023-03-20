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
--�����Խù�
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'notice','���������Դϴ�','�����Դϴ�','������');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'notice','���������Դϴ�1','�����Դϴ�1','�׽���');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'notice','���������Դϴ�2','�����Դϴ�2','������');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'notice','���������Դϴ�3','�����Դϴ�3','�׽���');

--���ǰԽ���
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'question','���������Դϴ�','�����Դϴ�','ȸ��1');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'question','���������Դϴ�1','�����Դϴ�1','ȸ��2');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'question','���������Դϴ�2','�����Դϴ�2','ȸ��3');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'question','���������Դϴ�3','�����Դϴ�3','ȸ��4');

--��������Խ���
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'review','�������������Դϴ�','�����Դϴ�','������');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'review','�������������Դϴ�1','�����Դϴ�1','���');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'review','�������������Դϴ�2','�����Դϴ�2','��ҿ�');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'review','�������������Դϴ�3','�����Դϴ�3','�����');

--��Ÿ�Խ���
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'etc','��Ÿ�����Դϴ�','�����Դϴ�','ȫ�浿');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'etc','��Ÿ�����Դϴ�1','�����Դϴ�1','����ũ');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'etc','��Ÿ�����Դϴ�2','�����Դϴ�2','�̼���');
INSERT INTO BOARD(bno,tid,title,content,writer)
values(bno_seq.nextval,'etc','��Ÿ�����Դϴ�3','�����Դϴ�3','���߱�');

--ī�װ�
insert into board_category(tid,tname)values('notice','����');
insert into board_category(tid,tname)values('question','����');
insert into board_category(tid,tname)values('review','����');
insert into board_category(tid,tname)values('etc','��Ÿ');

commit;

select *from board;
select*from board_category;


---------
select top from board where tid='notice' order by bno desc ;
SELECT * FROM board
WHERE tid='notice' and ROWNUM < 4 order by bno desc;