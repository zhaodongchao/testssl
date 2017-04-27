prompt PL/SQL Developer import file
prompt Created on 2017年4月27日 by Administrator
set feedback off
set define off
prompt Creating CF_AUTHORITY...
create table CF_AUTHORITY
(
  authority_id   VARCHAR2(40) default sys_guid() not null,
  authority_name VARCHAR2(100),
  operation_uri  VARCHAR2(200),
  descriptions   VARCHAR2(300)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column CF_AUTHORITY.authority_id
  is '权限ID';
comment on column CF_AUTHORITY.authority_name
  is '权限名称';
comment on column CF_AUTHORITY.operation_uri
  is '对于菜单，此值为菜单的MENU_CODE;对于用户操作行为此值为 名词：操作（如user:delete）';
comment on column CF_AUTHORITY.descriptions
  is '描述';
alter table CF_AUTHORITY
  add constraint AUTHORITY_PRIMARY_KEY primary key (AUTHORITY_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CF_AUTHORITY
  add constraint AUTHORITY_UNIQUE_KEY unique (OPERATION_URI)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating CF_MENU...
create table CF_MENU
(
  menu_id   VARCHAR2(40) default sys_guid() not null,
  menu_name VARCHAR2(100),
  menu_code VARCHAR2(100),
  menu_type VARCHAR2(50),
  uri       VARCHAR2(500),
  leaf      NUMBER(1) default 0,
  parent_id VARCHAR2(40)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column CF_MENU.menu_id
  is '主键ID';
comment on column CF_MENU.menu_name
  is '菜单名称';
comment on column CF_MENU.menu_code
  is '菜单编码';
comment on column CF_MENU.menu_type
  is '菜单类型';
comment on column CF_MENU.uri
  is '菜单所对应的资源地址';
comment on column CF_MENU.leaf
  is '是否是末级，0=不是，1=是';
comment on column CF_MENU.parent_id
  is '上级菜单ID，当此值为ROOT表示一个模块的根菜单';
alter table CF_MENU
  add constraint MENU_PRIMARY_KEY primary key (MENU_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CF_MENU
  add constraint UNIQUE_MENU_CODE unique (MENU_CODE)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating CF_PRIVILEGE...
create table CF_PRIVILEGE
(
  privilege_id           VARCHAR2(40) default sys_guid() not null,
  privilege_master       VARCHAR2(100) not null,
  privilege_value        VARCHAR2(100) not null,
  privilege_access       VARCHAR2(100) not null,
  privilege_access_value VARCHAR2(40) not null,
  privilege_operation    VARCHAR2(40) not null,
  last_modify_time       DATE not null,
  user_id                VARCHAR2(40) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column CF_PRIVILEGE.privilege_master
  is '菜单权限分配给的用户名/角色名';
comment on column CF_PRIVILEGE.privilege_value
  is '菜单权限分配给的用户ID/角色ID';
comment on column CF_PRIVILEGE.privilege_access
  is '菜单的名称';
comment on column CF_PRIVILEGE.privilege_access_value
  is '菜单的ID';
comment on column CF_PRIVILEGE.privilege_operation
  is '权限说明，一般指启用或禁止。P_ENABLE=有权限；P_DISABLE=无权限';
alter table CF_PRIVILEGE
  add constraint PK_CF_PRIVILEGE primary key (PRIVILEGE_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating CF_ROLE...
create table CF_ROLE
(
  role_id      VARCHAR2(40) default sys_guid() not null,
  role_name    VARCHAR2(100) not null,
  role_code    VARCHAR2(100) not null,
  descriptions VARCHAR2(250),
  description  VARCHAR2(255 CHAR)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column CF_ROLE.role_id
  is '角色ID';
comment on column CF_ROLE.role_name
  is '角色名称';
comment on column CF_ROLE.role_code
  is '角色编码';
comment on column CF_ROLE.descriptions
  is '描述';
alter table CF_ROLE
  add constraint CF_ROLE_PRIMARY_KEY primary key (ROLE_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CF_ROLE
  add constraint CF_ROLE_CODE_UQ unique (ROLE_CODE)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CF_ROLE
  add constraint CF_ROLE_NAME_UQ unique (ROLE_NAME)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating CF_ROLE_AUTHORITY...
create table CF_ROLE_AUTHORITY
(
  role_id      VARCHAR2(40),
  authority_id VARCHAR2(40)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CF_ROLE_AUTHORITY
  add constraint ROLE_AUTHORITY_UQ unique (ROLE_ID, AUTHORITY_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating CF_USER...
create table CF_USER
(
  user_id         VARCHAR2(40) default sys_guid() not null,
  login_name      VARCHAR2(50) not null,
  login_password  VARCHAR2(64),
  password_salt   VARCHAR2(256),
  real_name       VARCHAR2(40),
  selfdeclare     VARCHAR2(512),
  city            VARCHAR2(30),
  address         VARCHAR2(256),
  age             NUMBER(2),
  sex             NUMBER(1),
  birthday        DATE,
  telphone        VARCHAR2(20),
  email           VARCHAR2(40),
  create_time     DATE default sysdate not null,
  login_count     NUMBER not null,
  last_login_time DATE not null,
  is_lock         NUMBER(1) default 0,
  is_expired      NUMBER(1) default 0,
  expired_time    NUMBER default 0
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column CF_USER.user_id
  is '用户ID';
comment on column CF_USER.login_name
  is '登录名';
comment on column CF_USER.login_password
  is '登录密码';
comment on column CF_USER.password_salt
  is '加密盐值';
comment on column CF_USER.real_name
  is '真实名';
comment on column CF_USER.selfdeclare
  is '自我描述';
comment on column CF_USER.city
  is '所在城市';
comment on column CF_USER.address
  is '住址';
comment on column CF_USER.age
  is '年龄';
comment on column CF_USER.sex
  is '性别 1=男 0=女';
comment on column CF_USER.birthday
  is '生日';
comment on column CF_USER.telphone
  is '电话号码';
comment on column CF_USER.email
  is '电子邮箱';
comment on column CF_USER.create_time
  is '创建时间';
comment on column CF_USER.login_count
  is '登录次数';
comment on column CF_USER.last_login_time
  is '最近一次登录的时间';
comment on column CF_USER.is_lock
  is '是否锁定';
comment on column CF_USER.is_expired
  is '是否过期';
comment on column CF_USER.expired_time
  is '账户过期天数，如果为0，表示永不过期';
alter table CF_USER
  add constraint PK_CF_USER primary key (USER_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating CF_USER_ROLE...
create table CF_USER_ROLE
(
  user_id VARCHAR2(40) not null,
  role_id VARCHAR2(40) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column CF_USER_ROLE.user_id
  is '用户ID';
comment on column CF_USER_ROLE.role_id
  is '角色ID';
alter table CF_USER_ROLE
  add constraint USER_ROLE_UQ unique (USER_ID, ROLE_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CF_USER_ROLE
  add constraint FOREGIN_TO_ROLE foreign key (ROLE_ID)
  references CF_ROLE (ROLE_ID);
alter table CF_USER_ROLE
  add constraint FOREGIN_TO_USER foreign key (USER_ID)
  references CF_USER (USER_ID);

prompt Disabling triggers for CF_AUTHORITY...
alter table CF_AUTHORITY disable all triggers;
prompt Disabling triggers for CF_MENU...
alter table CF_MENU disable all triggers;
prompt Disabling triggers for CF_PRIVILEGE...
alter table CF_PRIVILEGE disable all triggers;
prompt Disabling triggers for CF_ROLE...
alter table CF_ROLE disable all triggers;
prompt Disabling triggers for CF_ROLE_AUTHORITY...
alter table CF_ROLE_AUTHORITY disable all triggers;
prompt Disabling triggers for CF_USER...
alter table CF_USER disable all triggers;
prompt Disabling triggers for CF_USER_ROLE...
alter table CF_USER_ROLE disable all triggers;
prompt Loading CF_AUTHORITY...
insert into CF_AUTHORITY (authority_id, authority_name, operation_uri, descriptions)
values ('BB9883D75A1B457AA20D00F8DA938D31', '角色管理菜单的权限', 'SYSTEM_ROLE_MANAGE', null);
insert into CF_AUTHORITY (authority_id, authority_name, operation_uri, descriptions)
values ('90DE09A2C7EC4469B8A7F18FE86FD19F', '用户管理菜单的权限', 'SYSTEM_USER_MANAGE', null);
commit;
prompt 2 records loaded
prompt Loading CF_MENU...
insert into CF_MENU (menu_id, menu_name, menu_code, menu_type, uri, leaf, parent_id)
values ('D2AF284A8A9B428E90BB504E5F853576', '系统管理', 'SYSTEM_MANAGE', null, null, 0, 'ROOT');
insert into CF_MENU (menu_id, menu_name, menu_code, menu_type, uri, leaf, parent_id)
values ('C7A87D23D91E4F00B30B2A86533EA0DB', '用户管理', 'SYSTEM_USER_MANAGE', null, 'user/go', 1, 'D2AF284A8A9B428E90BB504E5F853576');
insert into CF_MENU (menu_id, menu_name, menu_code, menu_type, uri, leaf, parent_id)
values ('AF2F408D1BAD4926807684360F518C9B', '流程管理', 'PROCESS_MANAGE', null, null, 0, 'ROOT');
insert into CF_MENU (menu_id, menu_name, menu_code, menu_type, uri, leaf, parent_id)
values ('8920165490584E53871B82D24F7295CE', '角色管理', 'SYSTEM_ROLE_MANAGE', null, null, 1, 'D2AF284A8A9B428E90BB504E5F853576');
commit;
prompt 4 records loaded
prompt Loading CF_PRIVILEGE...
prompt Table is empty
prompt Loading CF_ROLE...
insert into CF_ROLE (role_id, role_name, role_code, descriptions, description)
values ('7832DE698B14498DAF789CCEFF71A69D', '系统普通用户', 'user', '一般用户', null);
insert into CF_ROLE (role_id, role_name, role_code, descriptions, description)
values ('0052FC08E08843D7B27F60AF41AE3165', '系统管理员', 'admin', '拥有系统最高权限', null);
commit;
prompt 2 records loaded
prompt Loading CF_ROLE_AUTHORITY...
insert into CF_ROLE_AUTHORITY (role_id, authority_id)
values ('0052FC08E08843D7B27F60AF41AE3165', 'BB9883D75A1B457AA20D00F8DA938D31');
insert into CF_ROLE_AUTHORITY (role_id, authority_id)
values ('0052FC08E08843D7B27F60AF41AE3165', '90DE09A2C7EC4469B8A7F18FE86FD19F');
commit;
prompt 2 records loaded
prompt Loading CF_USER...
insert into CF_USER (user_id, login_name, login_password, password_salt, real_name, selfdeclare, city, address, age, sex, birthday, telphone, email, create_time, login_count, last_login_time, is_lock, is_expired, expired_time)
values ('77039EC9A8464BBABE93035C628215C6', 'chuchu', '123', 'dongdong', 'dongdong', 'a nice man', '上海', '红安八里', 25, 1, to_date('10-06-1992', 'dd-mm-yyyy'), '17621008632', '997546127@qq.com', to_date('24-03-2017 14:02:25', 'dd-mm-yyyy hh24:mi:ss'), 1, to_date('25-03-2017 14:02:25', 'dd-mm-yyyy hh24:mi:ss'), 0, 0, 0);
insert into CF_USER (user_id, login_name, login_password, password_salt, real_name, selfdeclare, city, address, age, sex, birthday, telphone, email, create_time, login_count, last_login_time, is_lock, is_expired, expired_time)
values ('A8D4CD06A57C4A54BC3F5BDE4C57DED9', 'dongdong', '123', 'chuchun', 'chuchun', 'a guo fu ren ', '麻城', '红安八里', 25, 0, to_date('07-03-1992', 'dd-mm-yyyy'), '15717877581', '1965756390@qq.com', to_date('20-03-2017 18:31:22', 'dd-mm-yyyy hh24:mi:ss'), 1, to_date('21-03-2017 18:31:22', 'dd-mm-yyyy hh24:mi:ss'), 0, 0, 0);
commit;
prompt 2 records loaded
prompt Loading CF_USER_ROLE...
insert into CF_USER_ROLE (user_id, role_id)
values ('77039EC9A8464BBABE93035C628215C6', '7832DE698B14498DAF789CCEFF71A69D');
insert into CF_USER_ROLE (user_id, role_id)
values ('A8D4CD06A57C4A54BC3F5BDE4C57DED9', '0052FC08E08843D7B27F60AF41AE3165');
commit;
prompt 2 records loaded
prompt Enabling triggers for CF_AUTHORITY...
alter table CF_AUTHORITY enable all triggers;
prompt Enabling triggers for CF_MENU...
alter table CF_MENU enable all triggers;
prompt Enabling triggers for CF_PRIVILEGE...
alter table CF_PRIVILEGE enable all triggers;
prompt Enabling triggers for CF_ROLE...
alter table CF_ROLE enable all triggers;
prompt Enabling triggers for CF_ROLE_AUTHORITY...
alter table CF_ROLE_AUTHORITY enable all triggers;
prompt Enabling triggers for CF_USER...
alter table CF_USER enable all triggers;
prompt Enabling triggers for CF_USER_ROLE...
alter table CF_USER_ROLE enable all triggers;
set feedback on
set define on
prompt Done.
