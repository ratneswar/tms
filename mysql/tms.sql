-- tms database tables
--
DROP TABLE IF EXISTS role_users;
DROP TABLE IF EXISTS users_log;
DROP TABLE IF EXISTS tickets_work_flow;
DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS role_permissions;
DROP TABLE IF EXISTS role;
DROP TABLE IF EXISTS code_branches;
DROP TABLE IF EXISTS code_repos;
DROP TABLE IF EXISTS permissions;
DROP TABLE IF EXISTS admin_log;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS vcs_users;
DROP TABLE IF EXISTS applications;
DROP TABLE IF EXISTS ticket_types;
DROP TABLE IF EXISTS scrum_teams;
DROP TABLE IF EXISTS environments;
DROP TABLE IF EXISTS tickets_work_flow;

-- users table
create table users (
	adid        varchar(20) primary key, -- user loadid, this column used for login
	first_name  varchar(50) not null,    -- first name of the user
	last_name   varchar(50) not null,    -- last name of the user
	password    varchar(20) not null,    -- mandatory password for user
	email_id    varchar(50),             -- email id which used for login. 
	caption     varchar(45),             -- user picture caption
	image_id    longblob,                -- user photo
	mobile      varchar(20),             -- user contact number 
	country	    varchar(50),             -- user country 
	user_type   varchar(15),             -- user type such as admin or normal user
	user_status int not null,            -- user status 1 = active 0 = inactive
	remarks	    varchar(100)             -- enter any comments to the user
);

insert into users (adid,first_name,last_name,password,email_id,mobile,country,user_type,user_status,remarks) values('rmarre01','Ratneswar','Marre','Password01','ratneswar@aranyacloudtek.com','1234567890','USA','super_admin',1,'');
insert into users (adid,first_name,last_name,password,email_id,mobile,country,user_type,user_status,remarks) values('crayap01','Chaitanya','Rayapureddy','Password01','chaitanya@aranyacloudtek.com','2345678901','USA','admin',1,'');
insert into users (adid,first_name,last_name,password,email_id,mobile,country,user_type,user_status,remarks) values('smamel01','Subbaraju','Mamellapally','Password01','subbu@aranyacloudtek.com','3456789012','USA','admin',1,'');
insert into users (adid,first_name,last_name,password,email_id,mobile,country,user_type,user_status,remarks) values('sdama01','Srinivas','Dama','Password01','srinivas@aranyacloudtek.com','4567890123','USA','admin',1,'');
insert into users (adid,first_name,last_name,password,email_id,mobile,country,user_type,user_status,remarks) values('smanda01','Sasikanth','Mandali','Password01','sasi@aranyacloudtek.com','5678901234','India','admin',1,'');
insert into users (adid,first_name,last_name,password,email_id,mobile,country,user_type,user_status,remarks) values('mmanda01','Manohar','Mandali','Password01','manohar@aranyacloudtek.com','6789012345','India','admin',1,'');
insert into users (adid,first_name,last_name,password,email_id,mobile,country,user_type,user_status,remarks) values('bpasup01','Bhanu','Pasupuleti','Password01','bhanu@aranyacloudtek.com','7890123456','USA','admin',1,'');
insert into users (adid,first_name,last_name,password,email_id,mobile,country,user_type,user_status,remarks) values('mgoppi01','Manoj','Goppisetty','Password01','manoj@aranyacloudtek.com','8901234567','USA','admin',1,'');
insert into users (adid,first_name,last_name,password,email_id,mobile,country,user_type,user_status,remarks) values('vtorli01','Venkata','Torlikonda','Password01','venkat@aranyacloudtek.com','9012345678','USA','admin',1,'');
insert into users (adid,first_name,last_name,password,email_id,mobile,country,user_type,user_status,remarks) values('rkakar01','Raju','Kakarlapudi','Password01','raju@aranyacloudtek.com','1123456789','USA','user',1,'');
insert into users (adid,first_name,last_name,password,email_id,mobile,country,user_type,user_status,remarks) values('nnukal01','Naga','Nukala','Password01','naga@aranyacloudtek.com','1223456789','USA','user',1,'');
insert into users (adid,first_name,last_name,password,email_id,mobile,country,user_type,user_status,remarks) values('gchund01','Giri','Chunduru','Password01','giri@aranyacloudtek.com','1233456789','USA','user',1,'');

-- users_log table, dependent on users table
create table users_log (
	login_id     varchar(15),                       -- foreign key which refer to the login user from the user table, if not null will be inserted, that means unknown user or wrong login (adid / email_id) .. <>
	log_dt       timestamp default current_timestamp, -- system date time
	login_gloc	 varchar(100),                -- capture all possible values of the client machine, ip, geo location, timezone ect.. <>
	login_type   varchar(20),                 -- manual login or hacking by the system / program ect.. <> 
	login_ip     varchar(20), 			      -- system ip address from where user try to login or successfully login. 
	login_status varchar(20),                 -- login success or failure
	login_rem    varchar(500),                -- stores details of the issue in text format ex: if user_interaction - login failed, invalid credentials, if system_interaction - Sent password expiration message to user's email address: ....	
    foreign key(login_id) references users(adid)
);
insert into users_log (login_id,login_type,login_ip,login_status,login_rem) values('rmarre01','user_interaction','1.1.1.1','success','testing');
insert into users_log (login_id,login_type,login_ip,login_status,login_rem) values(null,'system_interaction','1.1.1.1','unsuccess','unknown user (testing) try to login');
insert into users_log (login_id,login_type,login_ip,login_status,login_rem) values(null,'system_interaction','1.1.1.1','unsuccess','Password will expire soon for the user id - gchand01, and sent email to giri@aranyacloudtek.com');

-- permissions table
create table permissions (
	permissions_id int not null auto_increment primary key,
	permission_name varchar(50) unique key not null
);

insert into permissions (permission_name) values('assign_permissions_to_role');
insert into permissions (permission_name) values('assign_users_to_role');
insert into permissions (permission_name) values('create_role');
insert into permissions (permission_name) values('create_user');
insert into permissions (permission_name) values('delete_role');
insert into permissions (permission_name) values('delete_user');
insert into permissions (permission_name) values('edit_role');
insert into permissions (permission_name) values('edit_user');
insert into permissions (permission_name) values('vies_permissions_by_role');
insert into permissions (permission_name) values('view_permissions');
insert into permissions (permission_name) values('view_users_by_role');
insert into permissions (permission_name) values('view_user');
insert into permissions (permission_name) values('view_role');

-- role table
create table role (
	id int not null auto_increment primary key,
	role_name varchar(50) unique key not null
);

insert into role (role_name) values('SuperUser');
insert into role (role_name) values('AdminUser');
insert into role (role_name) values('User');

-- role_permissions table, dependent on permissions table
-- id int not null auto_increment primary key,

create table role_permissions (
	role_id int,
	role_permission_id int, 
	foreign key (role_id) references role(id),
	foreign key (role_permission_id) references permissions(permissions_id)
);

insert into role_permissions (role_id,role_permission_id) values(1,1);
insert into role_permissions (role_id,role_permission_id) values(1,2);
insert into role_permissions (role_id,role_permission_id) values(1,3);
insert into role_permissions (role_id,role_permission_id) values(1,4);
insert into role_permissions (role_id,role_permission_id) values(1,5);
insert into role_permissions (role_id,role_permission_id) values(1,6);
insert into role_permissions (role_id,role_permission_id) values(1,7);
insert into role_permissions (role_id,role_permission_id) values(1,8);
insert into role_permissions (role_id,role_permission_id) values(1,9);
insert into role_permissions (role_id,role_permission_id) values(1,10);
insert into role_permissions (role_id,role_permission_id) values(1,11);
insert into role_permissions (role_id,role_permission_id) values(1,12);
insert into role_permissions (role_id,role_permission_id) values(1,13);

-- role_users table, dependent on  role and users tables
create table role_users (
	id int not null auto_increment primary key,
	role_id int,
	user_id varchar(20), 
    foreign key (role_id) references role(id),
    foreign key (user_id) references users(adid)
);

insert into role_users (role_id,user_id) values(1,'rmarre01');
insert into role_users (role_id,user_id) values(2,'bpasup01');

-- admin_log table
create table admin_log (
	log_id  int auto_increment primary key,
	adid    varchar(20) not null,
	log_dt  timestamp default current_timestamp,
	action  varchar(100) not null
);

insert into admin_log (adid,action) values('rmarre01','added new user - adid, firstName, lastName, eamilAddress');
 
-- departments table
create table departments (
	dept_id    int auto_increment primary key,       -- department id
	dept_name  varchar(15),                          -- department name
    create_dt  timestamp default current_timestamp   -- application creation timestamp 
);

insert into departments(dept_name) values('Finance');
insert into departments(dept_name) values('HR');
insert into departments(dept_name) values('IT');
insert into departments(dept_name) values('Marketing');
insert into departments(dept_name) values('Sales');

-- applications table 
create table applications (
    app_id      varchar(3) not null primary key,     -- application id which is three character length
    app_name    varchar(100) not null,               -- application name 
	create_dt   timestamp default current_timestamp, -- application creation timestamp 
    app_pdl	    varchar(100) not null,               -- application team email address or public distribution list
    app_status  varchar(1) not null default '1' check (app_status in('1','0')) --  CHECK (country IN ('USA','UK','India')), 
);

insert into applications(app_id,app_name,app_pdl) values('TMS','Ticket Management System','tms-team@test.com');
insert into applications(app_id,app_name,app_pdl,app_status) values('XYZ','XYZ Application','xyz-team@test.com','0');

-- tickets_types table
create table ticket_types (
	tt_desc varchar(50) not null primary key
);

insert into ticket_types (tt_desc) values ('Build');
insert into ticket_types (tt_desc) values ('Package');
insert into ticket_types (tt_desc) values ('Deploy');
insert into ticket_types (tt_desc) values ('git Repo Access');
insert into ticket_types (tt_desc) values ('Config/Ad-hoc/Release');
insert into ticket_types (tt_desc) values ('New Branch');
insert into ticket_types (tt_desc) values ('General');

-- scrum_teams table
create table scrum_teams (
	team_name varchar(50) not null primary key
);

insert into scrum_teams (team_name) values('Strickers');
insert into scrum_teams (team_name) values('Bahubali');
insert into scrum_teams (team_name) values('SuperKings');
insert into scrum_teams (team_name) values('Alpha');
insert into scrum_teams (team_name) values('Tesla');

-- environments table
create table environments (
	env_desc   varchar(50) not null primary key,
    create_dt  timestamp default current_timestamp -- environment creation timestamp 
);

insert into environments (env_desc) values('development');
insert into environments (env_desc) values('test');
insert into environments (env_desc) values('load and performance');
insert into environments (env_desc) values('stage');
insert into environments (env_desc) values('prod');

-- tickets table, dependent on applications and ticket_types tables
create table tickets (
	ticket_id   int auto_increment primary key,
	priority    int not null,
	status	    varchar(20),
	adid        varchar(20) not null,                       -- this will be taken from the login session of adid value. 
	app_id	    varchar(3),
    project     varchar(25) not null,
    ticket_type varchar(50),                                -- if ticket type is git access, related data needs to be added in git user table
    approved_by varchar(25) not null,
    ticket_desc varchar(4000) not null,
    foreign key (adid) references users(adid),    
    foreign key (app_id) references applications(app_id),
    foreign key (ticket_type) references ticket_types(tt_desc)
);

insert into tickets (priority,adid,app_id,project,ticket_type,approved_by,ticket_desc) 
values(1,'bpasup01','TMS','PJ001234','General','Ratneswar','bounce test environment during the noon maintenance window');

-- git_repos table, dependent on applications table

create table code_repos (
    repo_name   varchar(100) not null primary key,
    app_id      varchar(3) not null,
    create_dt   timestamp default current_timestamp,
    foreign key (app_id) references applications(app_id)
);

insert into code_repos(repo_name,app_id) values('TMS-Client','TMS');
insert into code_repos(repo_name,app_id) values('TMS-Backend-API','TMS');
insert into code_repos(repo_name,app_id) values('TMS-Database','TMS');

-- git_repos table, dependent on git_repo and applications tables
create table code_branches (
   branch_name varchar(100) not null, 
   repo_name   varchar(100) not null,
   app_id      varchar(3) not null,
   branch_dt  timestamp default current_timestamp,
   primary key(repo_name,branch_name),
   foreign key (repo_name) references code_repos(repo_name),
   foreign key (app_id) references applications(app_id)
);

insert into code_branches(branch_name,repo_name,app_id) values('TMS20.1.RELEASE','TMS-Client','TMS');
insert into code_branches(branch_name,repo_name,app_id) values('TMS20.1.RELEASE','TMS-Backend-API','TMS');
insert into code_branches(branch_name,repo_name,app_id) values('TMS20.1.RELEASE','TMS-Database','TMS');

-- git_branches table, dependent on applications table
create table vcs_users (
   adid          varchar(20) not null primary key, 
   first_name    varchar(50) not null,
   last_name     varchar(50) not null,
   app_id        varchar(3),
   email_adrs    varchar(100),
   git_pswd      varchar(25) default 'Password01', 
   create_dt     timestamp default current_timestamp,
   terminate_dt  timestamp,
   user_status   varchar(1) not null default '1' check (app_status in('1','0')), --  valid values are 1=active 2=inactive
   foreign key (app_id) references applications(app_id)   
);

insert into vcs_users (adid,first_name,last_name,app_id) values('rmarre01','Ratneswar','Marre','TMS');

-- tickets_work_flow table
create table tickets_work_flow (
	ticket_id   int,
	adid        varchar(20) not null,
	ticket_sts  varchar(20) not null,
	update_dt   timestamp default current_timestamp,
	update_desc varchar(1000) not null,
	foreign key (ticket_id) references tickets(ticket_id)
);

insert into tickets_work_flow (ticket_id,adid,ticket_sts,update_desc) values(1,'rmarre01','assigned','work in progress');
insert into tickets_work_flow (ticket_id,adid,ticket_sts,update_desc) values(1,'rmarre01','pending','work in progress, waiting for more details');
insert into tickets_work_flow (ticket_id,adid,ticket_sts,update_desc) values(1,'rmarre01','rejected','rejected');

commit;
commit;

