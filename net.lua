assert( pon ~= nil, 'can\'t find pON' )

function net.WriteTable( tbl )
	net.WriteString( pon.encode( tbl ) )
end
pon.WriteTable = net.WriteTable

function net.ReadTable()
	return pon.decode( net.ReadString() )
end
pon.ReadTable = net.ReadTable