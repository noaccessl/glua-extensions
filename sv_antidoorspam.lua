hook.Add( 'PlayerUse', 'PreventDoorSpam', function( pl, ent )

	if pl:Alive() == nil then return false end

	if ent:GetClass() == 'prop_door_rotating' then

		if ( ent.m_AntiDoorSpam or 0 ) > CurTime() then
			return false
		end

		ent.m_AntiDoorSpam = CurTime() + 0.85

	end

	return true

end )
