WITH tb_est as (
select a.base, a.esquema, a.tabela from 
(select distinct a.base, a.esquema, a.tabela from tabelas_temp.dbo.t_bases_estrutura a) as a
left join 
(select distinct b.base, b.esquema, b.tabela from tabelas_temp.dbo.t_bases_estrutura_compara b) as b
on a.base= b.base and a.esquema = b.esquema and a.tabela = b.tabela
where b.base is null 
)
select 
'ALTER TABLE ' + a.base + '.'+a.esquema+'.'+a.tabela +' ALTER COLUMN '+a.coluna+' '+a.tipo+
IIF(a.tipo like '%varchar%', '('+ IIF(a.precisao = 0, 'max', a.precisao) +') ', 
IIF(a.tipo like '%numeric%', '('+ a.precisao +','+ a.scale +') ', ''))
from tabelas_temp.dbo.t_bases_estrutura  a
left join tabelas_temp.dbo.t_bases_estrutura_compara b
on a.base= b.base and a.esquema = b.esquema and a.tabela = b.tabela
and a.coluna = b.coluna
left join tb_est c on c.base = a.base and c.esquema = a.esquema and c.tabela = a.tabela
where c.base is null and (a.tipo != b.tipo OR a.precisao != b.precisao)
