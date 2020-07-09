local AdminRanks = { 
    -- Example: [ 'Any User Group, eg superadmin' ] = true, 
} 

local AdminTeams = { 
    -- Example: [ Any Team, eg TEAM_ADMIN ] = true, 
} 

hook.Add( 'PlayerNoClip', 'AntiAdminAbuse', function( player ) 
    if ( not AdminRanks[ player:GetUserGroup() ] and not AdminTeams[ player:Team() ] ) then 
        return false 
    end 
end ) 
