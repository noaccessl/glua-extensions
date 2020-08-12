BlackListEnabled = true

BlackList = {
	-- Example: [ 'SteamID64 Here' ] = true,
}

local message = '' -- For example, you are in the Blacklist

hook.Add( 'CheckPassword', 'CheckBlackList', function( SteamID64, a, b, c, SteamName )
    if ( BlackListEnabled ) then
	    if ( BlackList[ SteamID64 ] ) then
	    	print( SteamName .. ' ( ' .. SteamID64 .. ' ) is in blacklist, kicking...' )
	    	return false, message
	    end
    end
end )
