local Meta = debug.getregistry().Entity

local encode = util.TableToJSON -- Can be spon.encode, pon2.encode or some other encoding method ( table to string )
local decode = util.JSONToTable -- Can be spon.decode, pon2.decode or some other decoding method ( string to table )

function Meta:SetNWTable( key, tbl )
	self:SetNWString( key, encode( tbl ) )
end

function Meta:GetNWTable( key )
	return decode( self:GetNWString( key ) ) or {}
end


function Meta:SetNW2Table( key, tbl )
	self:SetNW2String( key, encode( tbl ) )
end

function Meta:GetNW2Table( key )
	return decode( self:GetNW2String( key ) ) or {}
end


function SetGlobalTable( index, tbl )
	SetGlobalString( index, encode( tbl ) )
end

function GetGlobalTable( index )
	return decode( GetGlobalString( index ) ) or {}
end
