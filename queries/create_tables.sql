select
'CREATE TABLE ['+a.base+'].['+a.esquema+'].['+a.tabela+'] ('+
string_agg('['+a.coluna + '] ' + a.tipo + 
IIF(a.tipo like '%varchar%', '('+ IIF(a.precisao = 0, 'max', a.precisao) +') ', 
IIF(a.tipo like '%numeric%', '('+ a.precisao +','+ a.scale +') ', '')) , ', ') + ')'
from tabelas_temp.dbo.t_bases_estrutura as a
left join tabelas_temp.dbo.t_bases_estrutura_compara as b
on a.base = b.base and a.esquema = b.esquema and a.tabela = b.tabela and a.coluna = b.coluna
where b.base is null 
and not exists (select 1 from tabelas_temp.dbo.t_bases_estrutura_compara x where x.base = a.base and x.tabela = a.tabela)
and a.tabela not like '[MS]%'
and a.tabela not like '%[_]bkp%'
and a.tabela not like '%tmp%'
and a.tabela not like '%temp%'
GROUP BY a.base, a.esquema, a.tabela