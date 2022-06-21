create database mini02;
show databases;
use mini02;

create table member(
    mno Integer PRIMARY KEY auto_increment,
	email varchar(255) not null,
    password varchar(255) not null,
    nickname varchar(20),
    job varchar(20),
    age Integer,
    unlockdate datetime(6),
    regdate datetime(6),
    moddate datetime(6),
    lastlogindate datetime(6)
)engine=InnoDB DEFAULT CHARSET=UTF8MB4;

create table member_auth(
	member_mno Integer NOT null,
	auth varchar(20) NOT NULL,
	foreign key(member_mno) references member(mno) on delete cascade
)engine=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE question(
	qno Integer PRIMARY KEY auto_increment,
	age	Integer,
	job	varchar(20),	
	content	varchar(255) not null	
)engine=MyISAM DEFAULT CHARSET=UTF8MB4;

create table diary(
	dno	Integer	PRIMARY key auto_increment,
	title	varchar(255) not null,	
	content	varchar(2000) not null,	
	regdate	datetime(6) not null,
	moddate	datetime(6) not null,
	weather varchar(20) not null,
	isSecret integer not null default 0,
	canReply integer not null default 1,
	member_mno Integer,
	foreign key(member_mno) references member(mno) on delete cascade
)engine=InnoDB DEFAULT CHARSET=UTF8MB4;

create table diary_image(
	ino integer primary key auto_increment,
	name varchar(255) not null,	
	imageurl varchar(255) not null,	
	diary_dno integer,
	foreign key(diary_dno) references diary(dno) on delete cascade
)engine=InnoDB DEFAULT CHARSET=UTF8MB4;

select * from diary;
select * from diary_image;
select * from member;
select * from member_auth;
select * from question;

-- alter table [테이블명] add [컬럼명] [타입] [옵션]
alter table diary add weather varchar(20) not null;
alter table member drop imageurl;

-- UPDATE [테이블] SET [열] = '변경할값' WHERE [조건].
update question set age = 10 where age > 10 and age < 20;
update question set age = 20 where age > 20 and age < 30;
update question set age = 30 where age > 30 and age < 40;
update question set age = 40 where age > 40 and age < 50;
update question set age = 50 where age > 50 and age < 60;
update question set age = 60 where age > 60 and age < 70;
-- drop table diary;
-- drop table diary_image;
-- drop table member;
-- drop table member_auth;
