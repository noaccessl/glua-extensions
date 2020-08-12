WhiteListEnabled = true

WhiteList = {
	-- Example: [ 'SteamID64 Here' ] = true,
}

local message = '' -- For example, you are not in the whitelist

hook.Add( 'CheckPassword', 'CheckWhiteList', function( SteamID64, a, b, c, SteamName )
    if ( WhiteListEnabled ) then
	    if ( not WhiteList[ SteamID64 ] ) then
	    	print( SteamName .. ' ( ' .. SteamID64 .. ' ) not in whitelist, kicking...' )
	    	return false, message
	    end
    end
end )
