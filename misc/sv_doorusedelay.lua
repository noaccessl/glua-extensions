
--[[–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
	Purpose: Use Delay for Doors.
–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––]]
do

	local CEntity = FindMetaTable( 'Entity' )

	local GetClass = CEntity.GetClass
	local GetTable = CEntity.GetTable

	local CurTime = CurTime

	-- Lookup Table for recognizing doors
	local CLASS_DOOR = {

		func_door = true;
		func_door_rotating = true;
		prop_door_rotating = true

	}

	local sv_doorusedelay = CreateConVar(
		'sv_doorusedelay', '0.18',
		FCVAR_ARCHIVE + FCVAR_UNLOGGED,
		'Keep relatively low. 0 — delay disabled.',
		0, 0.5
	)

	hook.Add( 'PlayerUse', 'Game_DoorUseDelay', function( pPlayer, pEntity )

		local flDelay = sv_doorusedelay:GetFloat()

		if ( flDelay == 0 ) then return end

		if ( CLASS_DOOR[GetClass( pEntity )] ) then

			local player_t = GetTable( pPlayer )

			if ( ( player_t.m_flNextDoorUse or 0 ) > CurTime() ) then
				return false
			end

			player_t.m_flNextDoorUse = ( CurTime() + flDelay )

		end

	end )

end
