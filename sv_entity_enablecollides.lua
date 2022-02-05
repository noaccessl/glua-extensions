local Meta = debug.getregistry().Entity

function Meta:EnableCollides( bEnable )

	local Phys = self:GetPhysicsObject()
	local PhysCount = self:GetPhysicsObjectCount()

	if IsValid( Phys ) == false then return end

	if PhysCount == 1 then
		Phys:EnableCollisions( bEnable )
	elseif PhysCount > 1 then

		for i = 0, PhysCount - 1 do

			CurPhys = self:GetPhysicsObjectNum( i )

			if IsValid( CurPhys ) then

				if bEnable then
					CurPhys:ClearGameFlag( FVPHYSICS_NO_SELF_COLLISIONS )
				else
					CurPhys:AddGameFlag( FVPHYSICS_NO_SELF_COLLISIONS )
				end

				CurPhys:EnableCollisions( bool )

			end

		end

	end

	self:SetCollisionGroup( bEnable and COLLISION_GROUP_NONE or COLLISION_GROUP_WORLD )
	self:DrawShadow( true )

end
