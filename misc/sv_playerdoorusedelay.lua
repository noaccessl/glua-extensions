
--[[–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
	Purpose: Door Use Delay for players.
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

	-- ConVar for adding special or extra classes of doors, be there any.
	local sv_extradoorclasses = CreateConVar(
		'sv_extradoorclasses', '',
		FCVAR_ARCHIVE + FCVAR_UNLOGGED,
		'Special/extra door classes to be recognized. (Used by GM:PlayerUse—Game:PlayerDoorUseDelay)'
	)

	local sv_playerdoorusedelay = CreateConVar(
		'sv_playerdoorusedelay', '0.18',
		FCVAR_ARCHIVE + FCVAR_UNLOGGED,
		'Artificial delay for a player to using all doors, in seconds. Keep relatively low. 0 — delay disabled.',
		0, 0.5
	)

	hook.Add( 'PlayerUse', 'Game:PlayerDoorUseDelay', function( pPlayer, pEntity )

		local flDelay = sv_playerdoorusedelay:GetFloat()

		if ( flDelay == 0 ) then return end

		local classname = GetClass( pEntity )

		if ( CLASS_DOOR[classname] or string.find( sv_extradoorclasses:GetString(), classname, 1, true ) ) then

			local player_t = GetTable( pPlayer )

			if ( ( player_t.m_flNextDoorUse or 0 ) > CurTime() ) then
				return false
			end

			player_t.m_flNextDoorUse = ( CurTime() + flDelay )

		end

	end )

end
