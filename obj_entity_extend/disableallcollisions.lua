
--[[–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
	Entity:DisableAllCollisions

	Purpose: Make an entity not collide with **anything**.
–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––]]
do

	local CEntity = FindMetaTable( 'Entity' )

	local GetPhysicsObjectCount = CEntity.GetPhysicsObjectCount
	local GetPhysicsObjectNum = CEntity.GetPhysicsObjectNum
	local SetCollisionGroup = CEntity.SetCollisionGroup

	local FVPHYSICS_NO_SELF_COLLISIONS = FVPHYSICS_NO_SELF_COLLISIONS

	local COLLISION_GROUP_NONE = COLLISION_GROUP_NONE
	local COLLISION_GROUP_WORLD = COLLISION_GROUP_WORLD

	function Entity:DisableAllCollisions( state )

		local numObjects = GetPhysicsObjectCount( self )

		if ( numObjects == 0 ) then
			return
		end

		for i = 0, numObjects - 1 do

			local pPhysObj = GetPhysicsObjectNum( self, i )

			if ( pPhysObj:IsValid() ) then

				if ( state ) then
					pPhysObj:AddGameFlag( FVPHYSICS_NO_SELF_COLLISIONS )
				else
					pPhysObj:ClearGameFlag( FVPHYSICS_NO_SELF_COLLISIONS )
				end

				pPhysObj:EnableCollisions( not state )

			end

		end

		SetCollisionGroup( self, state and COLLISION_GROUP_WORLD or COLLISION_GROUP_NONE )

	end

end
