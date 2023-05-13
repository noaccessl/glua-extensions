local ENTITY = debug.getregistry().Entity

function ENTITY:EnableCollisions( bCollision )

	local phys = self:GetPhysicsObject()
	if not IsValid( phys ) then return end

	local physNum = self:GetPhysicsObjectCount()

	if physNum == 1 then
		phys:EnableCollisions( bCollision )
	elseif physNum > 1 then

		for i = 0, physNum - 1 do

			local part = self:GetPhysicsObjectNum( i )

			if IsValid( part ) then

				if bCollision then
					part:ClearGameFlag( FVPHYSICS_NO_SELF_COLLISIONS )
				else
					part:AddGameFlag( FVPHYSICS_NO_SELF_COLLISIONS )
				end

				part:EnableCollisions( bool )

			end

		end

	end

	self:SetCollisionGroup( bCollision and COLLISION_GROUP_NONE or COLLISION_GROUP_WORLD )

end

local encode = util.TableToJSON -- replace with you encoder (spon/pon etc.)
local decode = util.JSONToTable -- replace with you decoder (spon/pon etc.)

function ENTITY:SetNWTable( key, tbl )
	self:SetNWString( key, encode( tbl ) )
end

function ENTITY:GetNWTable( key )
	return decode( self:GetNWString( key ) ) or {}
end

function ENTITY:SetNW2Table( key, tbl )
	self:SetNW2String( key, encode( tbl ) )
end

function ENTITY:GetNW2Table( key )
	return decode( self:GetNW2String( key ) ) or {}
end

function SetGlobalTable( index, tbl )
	SetGlobalString( index, encode( tbl ) )
end

function GetGlobalTable( index )
	return decode( GetGlobalString( index ) ) or {}
end