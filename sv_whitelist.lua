local hook_Add = hook.Add 
local hook_Call = hook.Call 
local util_SteamIDFrom64 = util.SteamIDFrom64 

WhiteList_Enabled = true 

WhiteList = { 
	-- Example: [ 'steamid here' ] = true, 
} 

hook_Add( 'CheckPassword', 'CheckWhiteList', function( SteamID64, a, b, c, SteamName ) 
    if ( not WhiteList_Enabled ) then 
        local Bool, Reason = hook_Call( 'CheckPassword', SteamID64, a, b, c, SteamName ) 
        if ( Bool ~= true ) then 
            return Bool, Reason 
        else 
            return true 
        end 
    else 
	    local SteamID = util_SteamIDFrom64( SteamID64 ) 

	    if ( not WhiteList[ SteamID ] ) then 
	    	print( SteamName .. ' ( ' .. SteamID .. ' ) not in whitelist, kicking...' ) 
	    	return false, 'Ты не в белом списке, или же на сервере технические работы\nYou are not in the white list, or server on the technical works' 
	    end 
    end 
end ) 
