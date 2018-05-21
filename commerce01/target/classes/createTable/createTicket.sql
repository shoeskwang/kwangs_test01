-- oracle 용
create table tbl_board(
bno number not null,
title varchar2(200) not null,
content varchar2(4000),
writer varchar2(50) not null,
regdate date default sysdate,
viewcnt number default 0,
primary key(bno)
);









create table tbl_ticket(
tno varchar2(20) not null,
title varchar2(200) not null,
summary varchar2(200) not null,
sdate date not null,
edate date not null,
location varchar2(20) not null,
tclass varchar2(20) not null,
genre varchar2(20) not null,
rtime varchar2(20) not null,
rdate date default sysdate,
state varchar2(20) not null,
theme varchar2(20) not null,
content varchar2(4000),
poster varchar2(50) not null,
tcount number default 0,
tprice number not null,
primary key(tno)
);

insert 
into tbl_ticket (tno,title,summary,sdate,edate,location,tclass,genre,rtime,rdate,state,theme,content,poster,tcount,tprice)
values('t001','공연01','공연01입니다.',to_date('2017-06-08','YYYY-MM-DD'),to_date('2017-06-10','YYYY-MM-DD'),'1','4','5','100',to_date('2017-05-01','YYYY-MM-DD'),'1','1','공연01 콘텐츠입니다.','t001',35,200000);

insert 
into tbl_ticket (tno,title,summary,sdate,edate,location,tclass,genre,rtime,rdate,state,theme,content,poster,tcount,tprice)
values('t002','공연02','공연02입니다.',to_date('2017-06-09','YYYY-MM-DD'),to_date('2017-06-12','YYYY-MM-DD'),'2','2','4','100',to_date('2017-05-03','YYYY-MM-DD'),'1','2','공연02 콘텐츠입니다.','t002',40,190000);

insert 
into tbl_ticket (tno,title,summary,sdate,edate,location,tclass,genre,rtime,rdate,state,theme,content,poster,tcount,tprice)
values('t003','공연03','공연03입니다.',to_date('2017-06-10','YYYY-MM-DD'),to_date('2017-06-14','YYYY-MM-DD'),'3','3','3','100',to_date('2017-05-05','YYYY-MM-DD'),'1','3','공연03 콘텐츠입니다.','t003',45,180000);

insert 
into tbl_ticket (tno,title,summary,sdate,edate,location,tclass,genre,rtime,rdate,state,theme,content,poster,tcount,tprice)
values('t004','공연04','공연04입니다.',to_date('2017-06-11','YYYY-MM-DD'),to_date('2017-06-16','YYYY-MM-DD'),'4','1','2','100',to_date('2017-05-07','YYYY-MM-DD'),'1','4','공연04 콘텐츠입니다.','t004',40,170000);

insert 
into tbl_ticket (tno,title,summary,sdate,edate,location,tclass,genre,rtime,rdate,state,theme,content,poster,tcount,tprice)
values('t005','공연05','공연05입니다.',to_date('2017-06-12','YYYY-MM-DD'),to_date('2017-06-18','YYYY-MM-DD'),'5','4','1','100',to_date('2017-05-09','YYYY-MM-DD'),'1','3','공연05 콘텐츠입니다.','t005',55,160000);


insert 
into tbl_ticket (tno,title,summary,sdate,edate,location,tclass,genre,rtime,rdate,state,theme,content,poster,tcount,tprice)
values('t006','공연06','공연06입니다.',to_date('2017-06-13','YYYY-MM-DD'),to_date('2017-06-20','YYYY-MM-DD'),'4','2','5','100',to_date('2017-05-11','YYYY-MM-DD'),'2','4','공연06 콘텐츠입니다.','t006',60,150000);


insert 
into tbl_ticket (tno,title,summary,sdate,edate,location,tclass,genre,rtime,rdate,state,theme,content,poster,tcount,tprice)
values('t007','공연07','공연07입니다.',to_date('2017-06-14','YYYY-MM-DD'),to_date('2017-06-22','YYYY-MM-DD'),'3','1','4','100',to_date('2017-05-13','YYYY-MM-DD'),'2','3','공연07 콘텐츠입니다.','t007',65,140000);

insert 
into tbl_ticket (tno,title,summary,sdate,edate,location,tclass,genre,rtime,rdate,state,theme,content,poster,tcount,tprice)
values('t008','공연08','공연08입니다.',to_date('2017-06-15','YYYY-MM-DD'),to_date('2017-06-24','YYYY-MM-DD'),'2','1','3','100',to_date('2017-05-15','YYYY-MM-DD'),'2','2','공연08 콘텐츠입니다.','t008',70,130000);

insert 
into tbl_ticket (tno,title,summary,sdate,edate,location,tclass,genre,rtime,rdate,state,theme,content,poster,tcount,tprice)
values('t005','공연05','공연05입니다.',to_date('2017-06-12','YYYY-MM-DD'),to_date('2017-06-18','YYYY-MM-DD'),'5','4','1','100',to_date('2017-05-09','YYYY-MM-DD'),'1','3','공연05 콘텐츠입니다.','t005',55,160000);
t002,공연02,공연02입니다.,42895,42898,2,2,4,100,42858,1,2,공연02 콘텐츠입니다.,t002,40,190000


t003,공연03,공연03입니다.,42896,42900,3,3,3,100,42860,1,3,공연03 콘텐츠입니다.,t003,45,180000
