drop table if exists tabelas_temp.dbo.t_bases_procedures;
create table  tabelas_temp.dbo.t_bases_procedures
(
base varchar(1700),
nome varchar(1700),
remover nvarchar(1700),
criar text
);
insert into tabelas_temp.dbo.t_bases_procedures
exec sp_MSforeachdb 'USE ?
select ''?'' as base, name, ''DROP PROCEDURE IF EXISTS [''+name+'']'' AS remover, definition from sys.objects o
join sys.sql_modules m on o.object_id = m.object_id
WHERE SCHEMA_NAME(o.schema_id) = ''dbo'' and name not like ''sp[_]%'' and type = ''P'' and ''?'' not in (''msdb'', ''tempdb'', ''log'', ''master'')';


drop table if exists tabelas_temp.dbo.t_bases_functions;
create table  tabelas_temp.dbo.t_bases_functions
(
base varchar(1700),
nome varchar(1700),
remover nvarchar(1700),
criar text
);
insert into tabelas_temp.dbo.t_bases_functions
exec sp_MSforeachdb 'USE ?
select ''?'' as base, name, ''DROP FUNCTION IF EXISTS [''+name+'']'' AS remover, definition
from sys.objects o
join sys.sql_modules m on o.object_id = m.object_id
WHERE SCHEMA_NAME(o.schema_id) = ''dbo'' and name not like ''sp[_]%'' and type = ''FN'' and ''?'' not in (''msdb'', ''tempdb'', ''log'', ''master'')';


drop table if exists tabelas_temp.dbo.t_bases_views;
create table  tabelas_temp.dbo.t_bases_views
(
base varchar(1700),
nome varchar(1700),
remover nvarchar(1700),
criar text
);
insert into tabelas_temp.dbo.t_bases_views
exec sp_MSforeachdb 'USE ?
select ''?'' as base, name, ''DROP VIEW IF EXISTS [''+name+'']'' AS remover, definition
from sys.objects o
join sys.sql_modules m on o.object_id = m.object_id
WHERE SCHEMA_NAME(o.schema_id) = ''dbo'' and name not like ''sp[_]%'' and type = ''V'' and ''?'' not in (''msdb'', ''tempdb'', ''log'', ''master'')';



drop table if exists tabelas_temp.dbo.t_bases_objects;
select x.* into tabelas_temp.dbo.t_bases_objects from (
SELECT * FROM tabelas_temp.dbo.t_bases_procedures union all
SELECT * FROM tabelas_temp.dbo.t_bases_functions union all
SELECT * FROM tabelas_temp.dbo.t_bases_views
) x;