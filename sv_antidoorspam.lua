hook.Add( 'PlayerUse', 'antidoorspam', function( pl, ent )

	if not pl:Alive() then return false end

	if ent:GetClass() == 'prop_door_rotating' then

		if ( ent.m_NextUse or 0 ) > CurTime() then
			return false
		end

		ent.m_NextUse = CurTime() + 0.85

	end

	return true

end )
