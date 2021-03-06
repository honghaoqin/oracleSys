DELETE FROM S_AUTH WHERE AUTH_ID='S_DICT_LIST';
INSERT INTO S_AUTH (AUTH_ID,NAME,PARENT_ID,PARAM,MENU,SORT) SELECT AUTH_ID,NAME,PARENT_ID,PARAM,MENU,SORT FROM (select 'S_DICT_LIST' AUTH_ID,'字典' NAME, 'SYS' PARENT_ID, '/sys/Dict/list.do' PARAM, '1' MENU, '' SORT FROM dual) a where NOT EXISTS (select 1 from S_AUTH b where a.auth_id = b.auth_id);

DELETE FROM S_AUTH WHERE AUTH_ID='S_DICT_DOWNLOAD';
INSERT INTO S_AUTH (AUTH_ID,NAME,PARENT_ID,PARAM,MENU,SORT) SELECT AUTH_ID,NAME,PARENT_ID,PARAM,MENU,SORT FROM (select 'S_DICT_DOWNLOAD' AUTH_ID,'字典下载' NAME, 'S_DICT_LIST' PARENT_ID, '' PARAM, '' MENU, '' SORT FROM dual) a where NOT EXISTS (select 1 from S_AUTH b where a.auth_id = b.auth_id);

DELETE FROM S_AUTH WHERE AUTH_ID='S_DICT_ADD';
INSERT INTO S_AUTH (AUTH_ID,NAME,PARENT_ID,PARAM,MENU,SORT) SELECT AUTH_ID,NAME,PARENT_ID,PARAM,MENU,SORT FROM (select 'S_DICT_ADD' AUTH_ID,'字典增加' NAME, 'S_DICT_LIST' PARENT_ID, '' PARAM, '' MENU, '' SORT FROM dual) a where NOT EXISTS (select 1 from S_AUTH b where a.auth_id = b.auth_id);

DELETE FROM S_AUTH WHERE AUTH_ID='S_DICT_EDIT';
INSERT INTO S_AUTH (AUTH_ID,NAME,PARENT_ID,PARAM,MENU,SORT) SELECT AUTH_ID,NAME,PARENT_ID,PARAM,MENU,SORT FROM (select 'S_DICT_EDIT' AUTH_ID,'字典修改' NAME, 'S_DICT_LIST' PARENT_ID, '' PARAM, '' MENU, '' SORT FROM dual) a where NOT EXISTS (select 1 from S_AUTH b where a.auth_id = b.auth_id);

DELETE FROM S_AUTH WHERE AUTH_ID='S_DICT_DEL';
INSERT INTO S_AUTH (AUTH_ID,NAME,PARENT_ID,PARAM,MENU,SORT) SELECT AUTH_ID,NAME,PARENT_ID,PARAM,MENU,SORT FROM (select 'S_DICT_DEL' AUTH_ID,'字典删除' NAME, 'S_DICT_LIST' PARENT_ID, '' PARAM, '' MENU, '' SORT FROM dual) a where NOT EXISTS (select 1 from S_AUTH b where a.auth_id = b.auth_id);

