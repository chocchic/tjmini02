create database mini02;
show databases;
use mini02;

select * from member;

create table member(
    mno Integer PRIMARY KEY auto_increment,
	email varchar(255) not null,
    password varchar(255) not null,
    nickname varchar(20),
    imageurl varchar(255),
    job varchar(20),
    age Integer,
    unlockdate datetime(6),
    regdate datetime(6),
    moddate datetime(6),
    lastlogindate datetime(6)
)engine=InnoDB DEFAULT CHARSET=UTF8MB4;

create table member_auth(
	mno Integer NOT null,
	auth varchar(20) NOT NULL,
	foreign key(mno) references member(mno) on delete cascade
)engine=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE question(
	qno Integer PRIMARY KEY auto_increment,
	age	Integer,
	job	varchar(20),	
	content	varchar(255) not null	
)engine=MyISAM DEFAULT CHARSET=UTF8MB4;

create table diary(
	dno	Integer	PRIMARY key auto_increment,
	mno	Integer,		
	title	varchar(255) not null,	
	content	varchar(2000) not null,	
	regdate	datetime(6) not null,
	moddate	datetime(6) not null,
	isSecret boolean not null default false,
	canReply boolean not null default true,
	foreign key(mno) references member(mno) on delete cascade
)engine=InnoDB DEFAULT CHARSET=UTF8MB4;

create table diary_image(
	dno	Integer,
	name varchar(255) not null,	
	imageurl varchar(255) not null,	
	foreign key(dno) references diary(dno) on delete cascade
)engine=InnoDB DEFAULT CHARSET=UTF8MB4;