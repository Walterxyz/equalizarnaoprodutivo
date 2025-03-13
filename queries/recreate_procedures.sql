select 
base, nome, remover, cast(criar as nvarchar(max))
from tabelas_temp.dbo.t_bases_objects
order by base, remover