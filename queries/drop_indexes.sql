select 
IIF(b.pk = 1, 
'ALTER TABLE ['+b.base+'].dbo.['+b.tabela+'] DROP CONSTRAINT ['+b.indice+']',
'DROP INDEX ['+b.indice+'] ON ['+b.base+'].dbo.['+b.tabela+']'
)
from  tabelas_temp.dbo.t_bases_indexes a
right join tabelas_temp.dbo.t_bases_indexes_compara b on a.base = b.base
and a.coluna = b.coluna and a.tabela = b.tabela and coalesce(a.included,'') = coalesce(b.included, '') 
where a.base is null 
and b.tabela not like '%[_OLD]'
and b.tabela not like '[MS]%'
and b.tabela not like '%tmp%'
and b.tabela not like '%temp%'
order by b.tabela, b.tipo