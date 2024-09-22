--[[–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
	Prepare
–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––]]
--
-- Metatables
--
local ENTITY = FindMetaTable( 'Entity' )
local PHYSOBJ = FindMetaTable( 'PhysObj' )

--
-- Metamethods: Entity
--
local GetPhysicsObject		= ENTITY.GetPhysicsObject
local GetPhysicsObjectCount	= ENTITY.GetPhysicsObjectCount
local GetPhysicsObjectNum	= ENTITY.GetPhysicsObjectNum

local SetCollisionGroup		= ENTITY.SetCollisionGroup

--
-- Metamethods: PhysObj
--
local IsValidPhysicsObject	= PHYSOBJ.IsValid

local EnableCollisions		= PHYSOBJ.EnableCollisions

local ClearGameFlag			= PHYSOBJ.ClearGameFlag
local AddGameFlag			= PHYSOBJ.AddGameFlag

--
-- Enums
--
local FVPHYSICS_NO_SELF_COLLISIONS = FVPHYSICS_NO_SELF_COLLISIONS

local COLLISION_GROUP_NONE = COLLISION_GROUP_NONE
local COLLISION_GROUP_WORLD = COLLISION_GROUP_WORLD


--[[–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
	Purpose: Sets whether the entity should collide with anything or not
–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––]]
function ENTITY:EnableCollisions( enable )

	local pPhysObj = GetPhysicsObject( self )

	if ( not IsValidPhysicsObject( pPhysObj ) ) then
		return
	end

	local numObjects = GetPhysicsObjectCount( self )

	if ( numObjects == 1 ) then
		EnableCollisions( pPhysObj, enable )
	else

		for i = 0, numObjects - 1 do

			local pPhysPart = GetPhysicsObjectNum( self, i )

			if ( IsValidPhysicsObject( pPhysPart ) ) then

				if ( enable ) then
					ClearGameFlag( pPhysPart, FVPHYSICS_NO_SELF_COLLISIONS )
				else
					AddGameFlag( pPhysPart, FVPHYSICS_NO_SELF_COLLISIONS )
				end

				EnableCollisions( pPhysPart, enable )

			end

		end

	end

	SetCollisionGroup( self, enable and COLLISION_GROUP_NONE or COLLISION_GROUP_WORLD )

end
