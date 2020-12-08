hook.Add( 'PlayerUse', 'DoorFix', function( ply, ent )
	if not ply:Alive() then return false end

	local class = ent:GetClass()
	if class == 'prop_door_rotating' then
		if CurTime() < ( ent.m_AntiDoorSpam or 0 ) then -- Prop doors can be glitched shut by mashing the use button. This script - prevents this
			return false
		end

		ent.m_AntiDoorSpam = CurTime() + 0.85 -- You can change this value. Default is 0.85
	end

	return true
end )
