-- oracle 용
create table tbl_member(
	user_id varchar2(20) not null,
	user_pw varchar2(20) not null,
	user_name varchar2(20) not null,
	user_email varchar2(50) not null,
	user_regdate date default sysdate,
	primary key(user_id)
);

create table tbl_cart(
	cart_id NUMBER not null,
	user_id varchar2(20) not null,
	tno varchar2(20) not null,
	amount NUMBER DEFAULT 1,
	primary key(cart_id)
);

CREATE SEQUENCE seq_cart START WITH 10 INCREMENT BY 1;

-- 외래키 설정 ( 미적용 상태 )
ALTER TABLE tbl_cart ADD CONSTRAINT cart_userid_fk FOREIGN KEY(user_id) REFERENCES tbl_member(user_id);
ALTER TABLE tbl_cart ADD CONSTRAINT cart_ticket_fk FOREIGN KEY(tno) REFERENCES tbl_ticket(tno);
COMMIT;
