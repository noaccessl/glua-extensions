--[[–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

	Instead of going through the entire table and writing each key and value...
	What if we send it as a string?

–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––]]



--[[–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
	Purpose: Custom table encoder & decoder

	Note:
		Built-in JSON isn't the best for networking a table
		due to potentially large strings and probable performance cost.
		So, replace with your one (pon, sfs (a good one), etc.).
–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––]]
local pfnTableToString = util.TableToJSON
local pfnStringToTable = util.JSONToTable

--[[–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
	net.WriteTable
–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––]]
local WriteString = net.WriteString

function net.WriteTable( tbl )

	WriteString( pfnTableToString( tbl ) )

end

--[[–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
	net.ReadTable
–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––]]
local ReadString = net.ReadString

function net.ReadTable()

	return pfnStringToTable( ReadString() )

end
