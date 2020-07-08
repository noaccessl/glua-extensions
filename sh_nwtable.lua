local Entity = FindMetaTable( 'Entity' ) 

function Entity:SetNWTable( Key, Table ) 
	self:SetNWString( Key, util.TableToJSON( Table ) ) 
end 

function Entity:GetNWTable( Key ) 
	return util.JSONToTable( self:GetNWString( Key ) ) or {} 
end 
