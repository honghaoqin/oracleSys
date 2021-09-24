/*插入用户*/
insert into S_USER (USER_ID, NAME, PSW, ZW, DEPT_ID) SELECT USER_ID, NAME, PSW, ZW, DEPT_ID FROM (SELECT 'admin' USER_ID, '管理员' NAME, 'fEqNCco3Yq9h5ZUglD3CZJT4' PSW, '管理员' ZW, 'admindept' DEPT_ID FROM dual) a where NOT EXISTS (select 1 from S_USER b where a.user_id = b.user_id);
insert into S_DEPT (DEPT_ID,NAME,PARENT_ID,SPELL,DES) SELECT DEPT_ID,NAME,PARENT_ID,SPELL,DES FROM (SELECT 'admindept' DEPT_ID, '管理部门' NAME, '' PARENT_ID, 'GLBM' SPELL, '管理部门' DES FROM dual) a where NOT EXISTS (select 1 from S_USER b where a.dept_id = b.dept_id);
