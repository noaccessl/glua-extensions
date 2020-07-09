BlackList_Enabled = true 

BlackList = { 
	-- Example: [ 'steamid here' ] = true, 
} 

hook.Add( 'CheckPassword', 'CheckBlackList', function( SteamID64, a, b, c, SteamName ) 
    if ( BlackList_Enabled ) then 
	    local SteamID = util.SteamIDFrom64( SteamID64 ) 

	    if ( not BlackList[ SteamID ] ) then 
	    	print( SteamName .. ' ( ' .. SteamID .. ' ) is in blacklist, kicking...' ) 
	    	return false, 'Ты в чёрном списке\nYou are in the black list' 
	    end 
    end 
end ) 
