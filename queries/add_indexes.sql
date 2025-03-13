select 
IIF(a.pk = 1, 
'ALTER TABLE ['+a.base+'].dbo.['+a.tabela+'] ADD CONSTRAINT ['+a.indice+'] PRIMARY KEY ('+a.coluna+')',
'CREATE '+a.tipo+' INDEX ['+a.indice+'] ON ['+a.base+'].dbo.['+a.tabela+'] ('+a.coluna+') '+IIF(a.included is not null, 
'INCLUDE ('+a.included+')', '')
)
from  tabelas_temp.dbo.t_bases_indexes a
left join tabelas_temp.dbo.t_bases_indexes_compara b on a.base = b.base
and a.coluna = b.coluna and a.tabela = b.tabela and coalesce(a.included,'') = coalesce(b.included, '') 
where b.base is null
and a.tabela not like '[MS]%'
and a.tabela not like '%[_]bkp%'
and a.tabela not like '%tmp%'
and a.tabela not like '%temp%'
order by a.tabela, a.tipo

