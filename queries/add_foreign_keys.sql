
select 
' use '+a.base+' '+
'ALTER TABLE ' + a.ReferencingObject + ' WITH CHECK ADD CONSTRAINT ' +
a.ConstraintName + ' FOREIGN KEY (' + a.ReferencingColumnName +')' +
' REFERENCES ' + a.ReferencedObject + ' ( ' + a.ReferencedColumnName + ' )'
from tabelas_temp.dbo.t_bases_foreign_keys a
left join tabelas_temp.dbo.t_bases_foreign_keys_compara b 
on a.base = b.base and a.ReferencedColumnName = b.ReferencedColumnName and 
a.ReferencedObject = b.ReferencedObject and a.ReferencingColumnName = a.ReferencingColumnName 
and a.ReferencingObject = b.ReferencingObject 
where b.base is null