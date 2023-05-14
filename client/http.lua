file.CreateDir( 'webassets' )

local GetExtension = string.GetExtensionFromFilename
local GetFile = string.GetFileFromFilename
local gsub = string.gsub
local Write = file.Write

do if not coroutine.http then

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

	coroutine.http = {}

	function coroutine.http.Fetch( url, callback )

		wrap( function()

			local state, response = request( url )
			callback( state, response )

		end )()

	end

end end

--[[---------------------------------------------------------------------------
	http.DownloadImg
---------------------------------------------------------------------------]]
local imgExt = { png = true; jpg = true; jpeg = true }

function http.DownloadImg( url, callback, matParams )

	local ext = GetExtension( url )
	if not imgExt[ext] then return end

	coroutine.http.Fetch( url, function( state, response )

		if not response then return end

		local path = 'webassets/' .. GetFile( gsub( url, '.+%/', '' ) )

		Write( path, response )

		if callback then
			callback( Material( '../data/' .. path, matParams ) )
		end

	end )

end