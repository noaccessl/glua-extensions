WhiteListEnabled = true

WhiteList = {
	-- Example: [ 'SteamID or 64 Here' ] = true,
}

local message = '' -- For example, "You aren't in the whitelist"

hook.Add( 'CheckPassword', 'CheckWhiteList', function( sid64, a, b, c, name )
    if WhiteListEnabled then
        local sid = util.SteamIDFrom64( sid64 )

	    if not WhiteList[ sid64 ] or not WhiteList[ sid ] then
	    	print( name .. ' ( ' .. sid64 .. ' ) not in whitelist, kicking...' )
	    	return false, message
	    end
    end
end )
