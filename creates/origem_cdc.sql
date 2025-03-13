
drop table if exists tabelas_temp.dbo.t_bases_cdc
create table tabelas_temp.dbo.t_bases_cdc (txt text)
insert into tabelas_temp.dbo.t_bases_cdc
exec sp_MSforeachdb 'use ? SELECT ''
use ?
if(''+(select max(cast(is_cdc_enabled as char(1))) from ?.sys.databases WHERE name =''?'')+'' = 1 and (select max(cast(is_cdc_enabled as char(1))) from ?.sys.databases WHERE name =''''?'''') != 1)
	exec sys.sp_cdc_enable_db

if((select max(cast(is_tracked_by_cdc as char(1))) from ?.sys.tables WHERE name =''''''+name+'''''') != 1)
	exec sys.sp_cdc_enable_table @source_schema = ''''dbo''''
						, @source_name = ''''''+name+''''''
						, @role_name = NULL;

'' FROM sys.tables where is_tracked_by_cdc = 1 and name not like ''%ABC%'''