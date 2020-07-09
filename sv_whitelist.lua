WhiteList_Enabled = true 

WhiteList = { 
	-- Example: [ 'SteamID64 Here' ] = true, 
} 

hook.Add( 'CheckPassword', 'CheckWhiteList', function( SteamID64, a, b, c, SteamName ) 
    if ( WhiteList_Enabled ) then 
	    if ( not WhiteList[ SteamID64 ] ) then 
	    	print( SteamName .. ' ( ' .. SteamID64 .. ' ) not in whitelist, kicking...' ) 
	    	return false, 'Ты не в белом списке, или же на сервере технические работы\nYou are not in the white list, or server on the technical works' 
	    end 
    end 
end ) 
