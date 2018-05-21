create table tbl_board(
bno number not null,              -- 게시물 번호
title varchar2(200) not null,     -- 제목
content varchar2(4000),           -- 내용
writer varchar2(50) not null,     -- 이름
regdate date default sysdate,     -- 작성일자  
viewcnt number default 0,         -- 조회수
primary key(bno)                  -- 기본키 설정
);

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

-- mysql용

create table member(
	user_id VARCHAR(20) NOT NULL PRIMARY KEY,
	user_pw VARCHAR(20) NOT NULL,
	user_name VARCHAR(20) NOT NULL,
	user_email VARCHAR(40) NOT NULL,
	user_regdate DATE NOT NULL
);

create table tbl_board(
	bno INT NOT NULL PRIMARY KEY,
	title VARCHAR(50) NOT NULL,
	content TEXT NOT NULL,
	writer VARCHAR(30) NOT NULL,
	regdate DATETIME DEFAULT CURRENT_TIMESTAMP,
	viewcnt INT DEFAULT '0'
);

create table date_test(
	id VARCHAR(30) NOT NULL PRIMARY KEY,
	regdate DATETIME DEFAULT CURRENT_TIMESTAMP
);



--예제 데이터
insert into tbl_board (bno,title,content,writer) values (3,'title3','content입니다3','kwang33');

-- reply
create table tbl_reply(
	rno INT NOT NULL PRIMARY KEY,
	bno INT NOT NULL,
	replytext VARCHAR(50) NOT NULL,
	replyer VARCHAR(50) NOT NULL,
	user_name VARCHAR(50) NOT NULL,
	regdate DATETIME DEFAULT CURRENT_TIMESTAMP
);

create table tbl_reply(
rno number not null,     
bno number not null,              
replytext varchar2(200) not null, 
replyer varchar2(200) not null,
regdate date default sysdate,       
secret_reply varchar2(20),
primary key(rno)                 
);

CREATE SEQUENCE ..  -- reply_seq 를 사용하기위해 필요함

SELECT reply_seq.CURRVAL FROM DUAL;

INSERT INTO tbl_reply (rno, bno, replytext, replyer, secret_reply)
		VALUES (reply_seq.NEXTVAL, 18, '2222', 'lee', 'y')