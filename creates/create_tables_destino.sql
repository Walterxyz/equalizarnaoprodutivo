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
create index idx_tab_estrutura on tabelas_temp.dbo.t_bases_estrutura (base, esquema, tabela, coluna);
create index idx_tab_estrutura_base_tabela on tabelas_temp.dbo.t_bases_estrutura (base, tabela);

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
create index idx_tab_indexes on tabelas_temp.dbo.t_bases_indexes (base, tabela, coluna);

drop table if exists tabelas_temp.dbo.t_bases_foreign_keys
create table tabelas_temp.dbo.t_bases_foreign_keys (
base varchar(1700), 
ReferencedObject varchar(1700), 
ReferencingObject varchar(1700), 
ReferencingColumnName varchar(1700), 
ReferencedColumnName varchar(1700), 
ConstraintName varchar(1700)
)
create index idx_tab_foreign_keys on tabelas_temp.dbo.t_bases_foreign_keys (base, ReferencedObject, ReferencingObject, ReferencingColumnName, ReferencedColumnName);

drop table if exists tabelas_temp.dbo.t_bases_objects
create table tabelas_temp.dbo.t_bases_objects
(
    base varchar(255),
    nome varchar(1700),
    remover varchar(1700),
    criar nvarchar(max)
)


drop table if exists tabelas_temp.dbo.t_bases_cdc
create table tabelas_temp.dbo.t_bases_cdc (txt text) ;
