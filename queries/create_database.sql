select 'CREATE DATABASE '+a.base from 
(select distinct a.base, a.esquema from tabelas_temp.dbo.t_bases_estrutura a) as a
left join 
(select distinct b.base, b.esquema from tabelas_temp.dbo.t_bases_estrutura_compara b) as b
on a.base= b.base and a.esquema = b.esquema
where b.base is null