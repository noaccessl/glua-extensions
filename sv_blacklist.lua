blEnabled = true

bl = {
	[ 'SteamID or 64-formatted here' ] = true,
}

local message = 'You are in the blacklist'
local SteamIDFrom64 = util.SteamIDFrom64

hook.Add( 'CheckPassword', 'CheckBlackList', function( steamID64, ip, svPassword, clPassword, name )
    if blEnabled then
        local steamID = SteamIDFrom64( steamID64 )

	    if bl[ steamID64 ] or bl[ steamID ] then
	    	print( name .. ' ( ' .. steamID64 .. ' ) are in the blacklist, kicking.' )
	    	return false, message
	    end
    end
end )
