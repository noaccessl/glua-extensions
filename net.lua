--[[–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
	Purpose: Custom table encoder & decoder

	Built-in JSON is not really good for networking because of large strings and performance cost
	So, replace with your one e.g. pon (a good one, it's compressed and relatively fast)
–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––]]
local pFuncEncoder = pon.encode -- util.TableToJSON
local pFuncDecoder = pon.decode -- util.JSONToTable

--[[–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
	Purpose: Instead of going through all the table and writing each key and value, let's send it as a string?
–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––]]
local WriteString = net.WriteString

function net.WriteTable( tbl )

	WriteString( pFuncEncoder( tbl ) )

end

local ReadString = net.ReadString

function net.ReadTable()

	return pFuncDecoder( ReadString() )

end
