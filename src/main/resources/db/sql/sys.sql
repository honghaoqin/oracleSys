
--创建临时表空间
create temporary tablespace tbs_zf_temp  
tempfile 'E:\oracle\tablespace\zf\zf_temp.dbf' 
size 50m  
autoextend on  
next 50m maxsize 20480m  
extent management local;  

--创建数据表空间
create tablespace tbs_zf_data  
datafile 'E:\oracle\tablespace\zf\zf_data.dbf' 
size 50m  
autoextend on  
next 50m maxsize 20480m  
extent management local;  

--创建索引表空间
create tablespace tbs_zf_index  
datafile 'E:\oracle\tablespace\zf\zf_index.dbf' 
size 50m  
autoextend on  
next 50m maxsize 20480m  
extent management local; 


--创建用户,指定表空间
create user  cszf identified  by cszf2015
default tablespace tbs_zf_data  
temporary tablespace tbs_zf_temp;  

--赋与用户普通DBA权限
grant dba to cszf;





