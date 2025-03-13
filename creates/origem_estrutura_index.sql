drop table if exists tabelas_temp.dbo.t_bases_estrutura
create table  tabelas_temp.dbo.t_bases_estrutura
(
base varchar(1700),
esquema varchar(1700),
tabela varchar(1700),
coluna varchar(1700),
tipo varchar(1700),
precisao varchar(1700),
scale varchar(200)
)

insert into tabelas_temp.dbo.t_bases_estrutura 
exec sp_MSforeachdb 'use ?
select ''?'' as ''database'', sch.name as esquema,  tab.name as ''table'', col.[name] as ''column'', stp.name as ''type'', col.precision, col.scale
from sys.tables tab
join sys.schemas sch on sch.schema_id = tab.schema_id
join sys.columns col on tab.object_id = col.object_id 
join sys.systypes stp on stp.xusertype = col.user_type_id
where sch.name in ( ''dbo'' , ''stg'' ) and 
tab.name not like ''%tmp%''
and ''?'' not in (''msdb'', ''tabelas_temp'', ''tempdb'', ''amr'', ''log'', ''master'', ''arquivo_morto'', ''monitorsql'', ''ReportServer_Ori'', ''ReportServer_OriTempDB'', ''distribution'', ''Catalogo_DR'')
'

drop table if exists tabelas_temp.dbo.t_bases_indexes
create table  tabelas_temp.dbo.t_bases_indexes
(
base varchar(1700),
tabela varchar(1700),
coluna varchar(1700),
indice varchar(1700),
tipo varchar(1700),
pk int,
included varchar(1700)
)
insert into tabelas_temp.dbo.t_bases_indexes
exec sp_MSforeachdb 'use ? 
select ''?'' base, t.name tabela, string_agg(c.name,'', '') coluna, x.name indice, x.type_desc,
x.is_primary_key, (select string_agg(COL_NAME(ix.object_id, ix.column_id), '', '') from sys.index_columns ix where 
ix.object_id = x.object_id and x.index_id = ix.index_id and ix.is_included_column = 1 
group by ix.object_id, ix.index_id) included 
from sys.indexes x
join sys.index_columns y on x.object_id = y.object_id and x.index_id = y.index_id and y.is_included_column = 0
join sys.columns c on c.object_id = x.object_id and y.column_id = c.column_id 
join sys.tables t on t.object_id = c.object_id and t.schema_id = 1
where ''?'' not in (''msdb'', ''tabelas_temp'', ''tempdb'', ''amr'', ''log'', ''master'', ''arquivo_morto'', ''monitorsql'', ''ReportServer_Ori'', ''ReportServer_OriTempDB'', ''distribution'', ''Catalogo_DR'')
group by t.name, x.name, x.type_desc, x.object_id, x.index_id, x.is_primary_key
order by t.name, x.type_desc
'

drop table if exists tabelas_temp.dbo.t_bases_foreign_keys
create table tabelas_temp.dbo.t_bases_foreign_keys (
base varchar(1700), 
ReferencedObject varchar(1700), 
ReferencingObject varchar(1700), 
ReferencingColumnName varchar(1700), 
ReferencedColumnName varchar(1700), 
ConstraintName varchar(1700)
)
insert into tabelas_temp.dbo.t_bases_foreign_keys
exec sp_MSforeachdb 'USE ? 
SELECT
	DB_NAME(),
    OBJECT_NAME(referenced_object_id) as ''ReferencedObject'',
    OBJECT_NAME(parent_object_id) as ''ReferencingObject'',
    string_agg(COL_NAME(parent_object_id, parent_column_id), '', '') as ''ReferencingColumnName'',
    string_agg(COL_NAME(referenced_object_id, referenced_column_id), '', '') as ''ReferencedColumnName'',
    OBJECT_NAME(constraint_object_id) ''ConstraintName''
FROM sys.foreign_key_columns
where ''?'' not in (''msdb'', ''tabelas_temp'', ''tempdb'', ''amr'', ''log'', ''master'', ''arquivo_morto'', ''monitorsql'', ''ReportServer_Ori'', ''ReportServer_OriTempDB'', ''distribution'', ''Catalogo_DR'')
group by referenced_object_id, parent_object_id, constraint_object_id
'