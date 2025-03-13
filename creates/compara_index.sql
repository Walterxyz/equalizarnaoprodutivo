drop table if exists tabelas_temp.dbo.t_bases_indexes_compara
create table  tabelas_temp.dbo.t_bases_indexes_compara
(
base varchar(1700),
tabela varchar(1700),
coluna varchar(1700),
indice varchar(1700),
tipo varchar(1700),
pk int,
included varchar(1700)
);

create index idx_tab_indexes_compara on tabelas_temp.dbo.t_bases_indexes_compara (base, tabela, coluna);

insert into tabelas_temp.dbo.t_bases_indexes_compara 
exec sp_MSforeachdb 'use ? 
select ''?'' base, t.name tabela, string_agg(c.name,'', '') coluna, x.name indice, x.type_desc,
x.is_primary_key, (select string_agg(COL_NAME(ix.object_id, ix.column_id), '', '') from sys.index_columns ix where 
ix.object_id = x.object_id and x.index_id = ix.index_id and ix.is_included_column = 1 
group by ix.object_id, ix.index_id) included 
from sys.indexes x
join sys.index_columns y on x.object_id = y.object_id and x.index_id = y.index_id and y.is_included_column = 0
join sys.columns c on c.object_id = x.object_id and y.column_id = c.column_id 
join sys.tables t on t.object_id = c.object_id and t.schema_id = 1
where ''?'' not in (''msdb'', ''tempdb'', ''log'', ''master'')
group by t.name, x.name, x.type_desc, x.object_id, x.index_id, x.is_primary_key
order by t.name, x.type_desc
'
