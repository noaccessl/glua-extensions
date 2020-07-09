WhiteList_Enabled = true 

WhiteList = { 
	-- Example: [ 'steamid here' ] = true, 
} 

hook.Add( 'CheckPassword', 'CheckWhiteList', function( SteamID64, a, b, c, SteamName ) 
    if ( WhiteList_Enabled ) then 
	    local SteamID = util.SteamIDFrom64( SteamID64 ) 

	    if ( not WhiteList[ SteamID ] ) then 
	    	print( SteamName .. ' ( ' .. SteamID .. ' ) not in whitelist, kicking...' ) 
	    	return false, 'Ты не в белом списке, или же на сервере технические работы\nYou are not in the white list, or server on the technical works' 
	    end 
    end 
end ) 
