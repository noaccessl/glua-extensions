-- This script sets a delay on the opening/closing of the door, which helps to get rid of annoying players who do not allow the door to open.

hook.Add( 'PlayerUse', 'DoorFix', function( ply, ent )

	if not ply:Alive() then return false end

	if ent:GetClass() == 'prop_door_rotating' then

		if CurTime() < ( ent.m_AntiDoorSpam or 0 ) then

			return false

		end

		ent.m_AntiDoorSpam = CurTime() + 0.85 -- Change this value if u want. Optimal is 0.85

	end

	return true

end )
