drop table if exists tabelas_temp.dbo.t_bases_estrutura_compara
create table  tabelas_temp.dbo.t_bases_estrutura_compara
(
base varchar(1700),
esquema varchar(1700),
tabela varchar(1700),
coluna varchar(1700),
tipo varchar(1700),
precisao varchar(1700),
scale varchar(200)
)
create index idx_tab_estrutura_compara on tabelas_temp.dbo.t_bases_estrutura_compara (base, esquema, tabela, coluna);
create index idx_tab_estrutura_base_tabela_compara on tabelas_temp.dbo.t_bases_estrutura_compara (base, tabela);
insert into tabelas_temp.dbo.t_bases_estrutura_compara
exec sp_MSforeachdb 'use ?
select ''?'' as ''database'', sch.name as esquema,  tab.name as ''table'', col.[name] as ''column'', stp.name as ''type'', col.precision, col.scale
from sys.tables tab
join sys.schemas sch on sch.schema_id = tab.schema_id
join sys.columns col on tab.object_id = col.object_id 
join sys.systypes stp on stp.xusertype = col.user_type_id
where sch.name in ( ''dbo'' , ''stg'' ) and ''?'' not in (''msdb'', ''tabelas_temp'', ''tempdb'', ''amr'', ''log'', ''master'', ''arquivo_morto'', ''monitorsql'', ''ReportServer_Ori'', ''ReportServer_OriTempDB'', ''distribution'', ''Catalogo_DR'')
'
