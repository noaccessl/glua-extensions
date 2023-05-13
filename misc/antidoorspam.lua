if SERVER then

	local doors = {

		func_door = true;
		func_door_rotating = true;
		prop_door_rotating = true;
		func_movelinear = true

	}

	hook.Add( 'PlayerUse', 'antidoorspam', function( pl, ent )

		if doors[ent:GetClass()] then

			if ( ent.m_NextUse or 0 ) > CurTime() then
				return false
			end

			ent.m_NextUse = CurTime() + 0.85

		end

		return true

	end )

end