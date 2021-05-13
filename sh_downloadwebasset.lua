local GetExtension = string.GetExtensionFromFilename

local allowedExtensions = {
    [ 'png' ] = true,
    [ 'jpg' ] = true,
    [ 'jpeg' ] = true
}

if not file.Exists( 'servers-assets', 'DATA' ) then file.CreateDir 'servers-assets' end

function DownloadWebAsset( url, callback )

	local urlExtension = GetExtension( url )
    if not allowedExtensions[ urlExtension ] then return print( 'Downloading web asset from ' .. url .. '...\n\t[FAIL] URL does not point to the allowed file extension' ) end
	
	local mat

	local parameters = {
        url = url,
        method = 'GET',
        success = function( num, body, tbl )

            if body == '' then return end
			
			local assetName = string.StripExtension( string.GetFileFromFilename( string.gsub( url, '.+%/', '' ) ) )
			local fileFormat = 'servers-assets/' .. assetName .. '.' .. urlExtension

            file.Write( fileFormat, body )

            mat = Material( '../data/' .. fileFormat )

            if callback then

                callback( mat )

            end

        end,
        failed = function( reason )

            print( 'Downloading web asset from ' .. url .. '...\n\t[FAIL] ' .. reason )

        end
    }
    HTTP( parameters )

    return mat

end

--[[---------------------------------------------------------------------------
Example #1
---------------------------------------------------------------------------]]
local callback = function( asset )

	if not CLIENT then return end

	local DrawWebAssetExample = function()

		surface.SetDrawColor( 255, 255, 255 )
		surface.SetMaterial( asset )
		surface.DrawTexturedRect( ScrW() * 0.45, ScrH() * 0.45, asset:Width(), asset:Height() )

	end
	hook.Add( 'HUDPaint', 'DrawWebAssetExample', DrawWebAssetExample )

end
DownloadWebAsset( 'https://noaccessl.github.io/img/banana.png', callback )

--[[---------------------------------------------------------------------------
Example #2
---------------------------------------------------------------------------]]
local asset = DownloadWebAsset 'https://noaccessl.github.io/img/banana.png'

local DrawWebAssetExample = function()

	surface.SetDrawColor( 255, 255, 255 )
	surface.SetMaterial( asset )
	surface.DrawTexturedRect( ScrW() * 0.45, ScrH() * 0.45, asset:Width(), asset:Height() )

end
hook.Add( 'HUDPaint', 'DrawWebAssetExample', DrawWebAssetExample )