DELETE FROM S_AUTH WHERE AUTH_ID='S_LOGIN_LOG_LIST';
INSERT INTO S_AUTH (AUTH_ID,NAME,PARENT_ID,PARAM,MENU,SORT) SELECT AUTH_ID,NAME,PARENT_ID,PARAM,MENU,SORT FROM (select 'S_LOGIN_LOG_LIST' AUTH_ID,'登录日志' NAME, 'SYS' PARENT_ID, '/sys/LoginLog/list.do' PARAM, '1' MENU, '' SORT FROM dual) a where NOT EXISTS (select 1 from S_AUTH b where a.auth_id = b.auth_id);

DELETE FROM S_AUTH WHERE AUTH_ID='S_LOGIN_LOG_DOWNLOAD';
INSERT INTO S_AUTH (AUTH_ID,NAME,PARENT_ID,PARAM,MENU,SORT) SELECT AUTH_ID,NAME,PARENT_ID,PARAM,MENU,SORT FROM (select 'S_LOGIN_LOG_DOWNLOAD' AUTH_ID,'登录日志下载' NAME, 'S_LOGIN_LOG_LIST' PARENT_ID, '' PARAM, '' MENU, '' SORT FROM dual) a where NOT EXISTS (select 1 from S_AUTH b where a.auth_id = b.auth_id);


