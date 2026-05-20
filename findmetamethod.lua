
--[[–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
	function FindMetamethod( string request )

	Purpose: Syntax-sugar &/or alternative for
		FindMetaTable( "<MetaName>" ).<MetaMethod> / <MetaTable>.<MetaMethod>.

	Arguments:
		string request
			String containing metaname and metamethod separated by
			one of these characters/sequences: '.', ':', '::', '->'.
–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––]]
do
	if ( not FindMetamethod ) then

	local strfind, assert, strsub = string.find, assert, string.sub
	local FindMetaTable = FindMetaTable

	local Separators = { '::'; ':', '.'; '->' } ; local NUM_SEPARATORS = #Separators

	local shared_MetaTablesCache = {}

	function FindMetamethod( request )

		local sepr_start, sepr_end

		-- Finding the separator...
		do
			local i = 0 ; ::find:: ; i = i + 1

				local ret1, ret2 = strfind( request, Separators[i], 1, true )

				if ( ret1 ) then
					sepr_start, sepr_end = ret1, ret2
					goto exit
				end

			if ( i ~= NUM_SEPARATORS ) then goto find end ; ::exit::
		end

		if ( not sepr_start ) then

			assert(
				false,
				"malformed metamethod request: '" .. request .. "'" ..
				"; expected format is <MetaName>(.|:|::|->)<MetaMethod>"
			)

		end

		local metaname = strsub( request, 1, sepr_start - 1 )
		local metamethod = strsub( request, sepr_end + 1 )

		local pMetaTable = shared_MetaTablesCache[metaname]
		if ( not pMetaTable ) then

			pMetaTable = FindMetaTable( metaname )
			shared_MetaTablesCache[metaname] = pMetaTable

		end

		return pMetaTable[metamethod]

	end

	--
	-- Let's also not fill Lua Memory for nothing and
	-- clear the table somewhen after all the right metamethods
	-- were gotten.
	--
	local function Timer_ClearCache()

		table.Empty( shared_MetaTablesCache )

	end

	timer.Create( 'FindMetamethod::ClearMetaTablesCache', 60, 1, Timer_ClearCache )

	end
end
