
drop table if exists tabelas_temp.dbo.t_bases_foreign_keys_compara
create table tabelas_temp.dbo.t_bases_foreign_keys_compara (
base varchar(1700), 
ReferencedObject varchar(1700), 
ReferencingObject varchar(1700), 
ReferencingColumnName varchar(1700), 
ReferencedColumnName varchar(1700), 
ConstraintName varchar(1700)
)
create index idx_tab_foreign_keys_compara on tabelas_temp.dbo.t_bases_foreign_keys_compara (base, ReferencedObject, ReferencingObject, ReferencingColumnName, ReferencedColumnName);
insert into tabelas_temp.dbo.t_bases_foreign_keys_compara
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
