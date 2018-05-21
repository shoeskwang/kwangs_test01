-- mysql 용
create table tbl_test(
	geo_num VARCHAR(20) NOT NULL PRIMARY KEY,
	geo_name VARCHAR(20) ,
	geo_writer VARCHAR(20) ,
	geo_json VARCHAR(21000) NOT NULL,
	geo_distance VARCHAR(20) ,
	geo_regdate DATE 
);


--mysql
insert into tbl_test (geo_num,geo_name,geo_json) values('1','k','geo');
insert into tbl_member (user_id,user_pw,user_name,user_email,user_regdate) values ('park','1234','박군','park2@gmail.com',curdate()); 