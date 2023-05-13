local allow = {

	png = true;
	jpg = true;
	jpeg = true

}

file.CreateDir( 'web-assets' )

local mat

function http.DownloadImage( url, callback )

	local extension = string.GetExtensionFromFilename( url )

	if not allow[extension] then
		return
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

		end

	}
	HTTP( parameters )

	return mat

end

--[[---------------------------------------------------------------------------

	http.DownloadImage( 'https://noaccessl.github.io/img/banana.png', function( img )

		hook.Add( 'HUDPaint', 'example', function()

			surface.SetDrawColor( 255, 255, 255 )
			surface.SetMaterial( img )
			surface.DrawTexturedRect( ScrW() * 0.5 - img:Width() * 0.5, ScrH() * 0.5 - img:Height() * 0.5, img:Width(), img:Height() )

		end )

	end )

	---------------------------------------------------------------------------

	local img
	http.DownloadImage( 'https://noaccessl.github.io/img/banana.png', function( _img ) img = _img end )

	hook.Add( 'HUDPaint', 'example', function()

		surface.SetDrawColor( 255, 255, 255 )
		surface.SetMaterial( img )
		surface.DrawTexturedRect( ScrW() * 0.5 - img:Width() * 0.5, ScrH() * 0.5 - img:Height() * 0.5, img:Width(), img:Height() )

	end )

---------------------------------------------------------------------------]]