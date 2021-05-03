wlEnabled = true

wl = {
	[ 'SteamID or 64-formatted here' ] = true,
}

local message = 'Sorry, but you aren\'t in the whitelist'
local SteamIDFrom64 = util.SteamIDFrom64

hook.Add( 'CheckPassword', 'CheckWhiteList', function( steamID64, ip, svPassword, clPassword, name )
    if wlEnabled then
        local steamID = SteamIDFrom64( steamID64 )

	    if not ( wl[ steamID64 ] or wl[ steamID ] ) then
	    	print( name .. ' ( ' .. steamID64 .. ' ) aren\'t in then whitelist, kicking.' )
	    	return false, message
	    end
    end
end )
