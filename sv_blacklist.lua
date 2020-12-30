BlackListEnabled = true

BlackList = {
	-- Example: [ 'SteamID or 64 Here' ] = true,
}

local message = 'You are in the Blacklist'

hook.Add( 'CheckPassword', 'CheckBlackList', function( sid64, a, b, c, name )
    if BlackListEnabled then
        local sid = util.SteamIDFrom64( sid64 )

	    if BlackList[ sid64 ] or BlackList[ sid ] then
	    	print( name .. ' ( ' .. sid64 .. ' ) is in blacklist, kicking...' )
	    	return false, message
	    end
    end
end )
