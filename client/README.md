# http.lua

## `http.DownloadImg`
Downloads image from web server into `DATA/webassets` folder

### Some use examples
```lua
http.DownloadImg( 'https://noaccessl.github.io/img/banana.png', function( img )

	hook.Add( 'HUDPaint', '', function()

		surface.SetDrawColor( 255, 255, 255 )
		surface.SetMaterial( img )
		surface.DrawTexturedRect( ScrW() * 0.5 - img:Width() * 0.5, ScrH() * 0.5 - img:Height() * 0.5, img:Width(), img:Height() )

	end )

end )
```

```lua
local mat
http.DownloadImg( 'https://noaccessl.github.io/img/banana.png', function( img ) mat = img end )
-- Other code
```