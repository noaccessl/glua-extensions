local allowedExtensions = {
    [ 'png' ] = true,
    [ 'jpg' ] = true,
    [ 'jpeg' ] = true
}

local extension = string.GetExtensionFromFilename

function DownloadWebAsset( url, callback )
    if not file.Exists( 'assets', 'DATA' ) then file.CreateDir 'assets' end
    if not file.Exists( 'assets/cache', 'DATA' ) then file.CreateDir 'assets/cache' end
    if not file.Exists( 'assets/cache/materials', 'DATA' ) then file.CreateDir 'assets/cache/materials' end

    if not allowedExtensions[ extension( url ) ] then
        print( 'Failed to download web asset from ' .. url .. ' for reason: the url does not point to the allowed file extension' )
        return
    end
	
	local mat

    HTTP{
        url = url,
        method = 'GET',
        success = function( num, body, tbl )
            if not body or body == '' then return end
			
			local assetName = string.StripExtension( string.GetFileFromFilename( string.gsub( url, '.+%/', '' ) ) )
			local fileFormat = string.format( 'assets/cache/materials/%s.%s', assetName, extension( url ) )

            file.Write( fileFormat, body )

            mat = Material( '../data/' .. fileFormat )

            if callback then
                callback( mat )
            end
        end,
        failed = function( reason )
            print( 'Failed to download web asset from ' .. url .. ' for reason: ' .. reason )
        end
    }

    return mat
end

-- Можно так | You can do so
DownloadWebAsset( 'http://37.46.132.107/assets/img/banana.png', function( asset )
	if CLIENT then
		hook.Add( 'HUDPaint', 'DrawWebAssetExample', function()
			surface.SetDrawColor( 255, 255, 255 )
			surface.SetMaterial( asset )
			surface.DrawTexturedRect( ScrW() * 0.45, ScrH() * 0.45, mat:Width(), mat:Height() )
		end )
	end
end )

-- Or so
local asset = DownloadWebAsset 'http://37.46.132.107/assets/img/banana.png'
print( asset )
