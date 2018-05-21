
-- mysql 용
create table tbl_member(
	user_id VARCHAR(20) NOT NULL PRIMARY KEY,
	user_pw VARCHAR(20) NOT NULL,
	user_name VARCHAR(20) NOT NULL,
	user_email VARCHAR(40) NOT NULL,
	user_regdate DATE NOT NULL
);

-- oracle 용
create table tbl_member(
	user_id varchar2(20) not null,
	user_pw varchar2(20) not null,
	user_name varchar2(20) not null,
	user_email varchar2(50) not null,
	user_regdate date default sysdate,
	primary key(user_id)
);

insert into tbl_member (user_id,user_pw,user_name,user_email) values ('park','1234','박군','park1@gmail.com');


--mysql
insert into tbl_member (user_id,user_pw,user_name,user_email,user_regdate) values ('park','1234','박군','park2@gmail.com',curdate()); 