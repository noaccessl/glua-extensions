function HexToColor( hex, alpha )
    return Color(
        tonumber( '0x' .. hex:sub( 1, 2 ) ),
        tonumber( '0x' .. hex:sub( 3, 4 ) ),
        tonumber( '0x' .. hex:sub( 5, 6 ) ),
        alpha or 255 or tonumber( '0x' .. hex:sub( 7, 8 )
    )
end

function ColorToHex( color )
    color = color:ToTable()
	local result = ''

	for i = 1, #color do
	    local value = color[ i ]
		local hex = ''

		while value > 0 do
			local index = math.fmod( value, 16 ) + 1
			value = math.floor( value / 16 )
			hex = string.sub( '0123456789ABCDEF', index, index ) .. hex
		end

		if string.len( hex ) == 0 then
			hex = '00'
		elseif string.len( hex ) == 1 then
			hex = '0' .. hex
		end

		result = result .. hex
	end

	return result
end

--[[---------------------------------------------------------------------------
Example ( You can delete him )
---------------------------------------------------------------------------]]
local hex = ColorToHex( Color( 200, 0, 0 ) )

print( hex ) -- Output: C80000 or C80000FF (last 2 characters are transparency(alpha) )

for k, v in pairs( HexToColor( hex ) ) do
    print( k, v )
end -- or PrintTable( HexToColor( hex ) )
