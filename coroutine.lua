local running = coroutine.running
local resume = coroutine.resume
local Fetch = http.Fetch
local yield = coroutine.yield
local wrap = coroutine.wrap

local function request( url )

	local co = running()

	local function onSuccess( body )
		resume( co, true, body )
	end

	local function onFailure( err )
		resume( co, false, err )
	end

	Fetch( url, onSuccess, onFailure )

	return yield()

end

coroutine.http = coroutine.http or {}

function coroutine.http.Fetch( url, callback )

	wrap( function()

		local state, response = request( url )
		callback( state, response )

	end )()

end