local Entity = FindMetaTable 'Entity'

-- Enables/Disables collisions of a certain object forcibly.
function Entity:EnableCollides( bool )
    local Phys = self:GetPhysicsObject()
    local PhysCount = self:GetPhysicsObjectCount()

    if ( not IsValid( Phys ) ) then return end

    if ( PhysCount == 1 ) then
        Phys:EnableCollisions( bool )
    end

    if PhysCount > 1 then
        for Num = 0, PhysCount - 1 do
            CurPhys = self:GetPhysicsObjectNum( Num )
            if ( IsValid( CurPhys ) ) then
                if ( bool ) then
                    CurPhys:ClearGameFlag( FVPHYSICS_NO_SELF_COLLISIONS )
                else
                    CurPhys:AddGameFlag( FVPHYSICS_NO_SELF_COLLISIONS )
                end

                CurPhys:EnableCollisions( bool )
            end
        end
    end

    self:SetCollisionGroup( Either( bool, COLLISION_GROUP_NONE, COLLISION_GROUP_WORLD ) )
    self:DrawShadow( true )
end
