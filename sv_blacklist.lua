BlackList_Enabled = true 

BlackList = { 
	-- Example: [ 'SteamID64 Here' ] = true, 
} 

hook.Add( 'CheckPassword', 'CheckBlackList', function( SteamID64, a, b, c, SteamName ) 
    if ( BlackList_Enabled ) then 
	    if ( BlackList[ SteamID64 ] ) then 
	    	print( SteamName .. ' ( ' .. SteamID64 .. ' ) is in blacklist, kicking...' ) 
	    	return false, 'Ты в чёрном списке\nYou are in the blacklist' 
	    end 
    end 
end ) 
