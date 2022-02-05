local GetExtension = string.GetExtensionFromFilename

local AllowedExtensions = {

	png = true,
	jpg = true,
	jpeg = true

}

if file.Exists( 'web-assets', 'DATA' ) == false then
	file.CreateDir( 'web-assets' )
end

function http.DownloadWebAsset( url, callback )

	local extension = GetExtension( url )

	if not AllowedExtensions[ extension ] then
		return print( '[HTTP] Downloading web asset from ' .. url .. '...\n\t[FAIL] Invalid extension' )
	end

	local parameters = {

		url = url,
		method = 'GET',

		success = function( num, body, tbl )

			if body == '' then return end

			local path = 'web-assets/' .. string.StripExtension( string.GetFileFromFilename( string.gsub( url, '.+%/', '' ) ) ) .. '.' .. extension

			file.Write( path, body )

			mat = Material( '../data/' .. path )

			if callback then
				callback( mat )
			end

		end,

		failed = function( reason )
			print( '[HTTP] Downloading web asset from ' .. url .. '...\n\t[FAIL] ' .. reason )
		end

	}
	HTTP( parameters )

end

--[[---------------------------------------------------------------------------
Example #1
---------------------------------------------------------------------------]]
http.DownloadWebAsset( 'https://noaccessl.github.io/img/banana.png', function( asset )

	if SERVER then return end

	hook.Add( 'HUDPaint', 'Example', function()

		surface.SetDrawColor( 255, 255, 255 )
		surface.SetMaterial( asset )
		surface.DrawTexturedRect( ScrW() * 0.5 - asset:Width() * 0.5, ScrH() * 0.5 - asset:Height() * 0.5, asset:Width(), asset:Height() )

	end )

end )

--[[---------------------------------------------------------------------------
Example #2
---------------------------------------------------------------------------]]
local mat
http.DownloadWebAsset( 'https://noaccessl.github.io/img/banana.png', function( asset ) mat = asset end )

hook.Add( 'HUDPaint', 'Example', function()

	surface.SetDrawColor( 255, 255, 255 )
	surface.SetMaterial( mat )
	surface.DrawTexturedRect( ScrW() * 0.5 - mat:Width() * 0.5, ScrH() * 0.5 - mat:Height() * 0.5, mat:Width(), mat:Height() )

end )
