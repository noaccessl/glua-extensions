local gmatch = string.gmatch
local gsub = string.gsub
local format = string.format
local JSONToTable = util.JSONToTable

--[[---------------------------------------------------------------------------
	UTF-8
---------------------------------------------------------------------------]]
string.upperEx = string.upperEx or string.upper
string.lowerEx = string.lowerEx or string.lower

local lowers = {['А'] = 'а';['Б'] = 'б';['В'] = 'в';['Г'] = 'г';['Д'] = 'д';['Е'] = 'е';['Ё'] = 'ё';['Ж'] = 'ж';['З'] = 'з';['И'] = 'и';['Й'] = 'й';['К'] = 'к';['Л'] = 'л';['М'] = 'м';['Н'] = 'н';['О'] = 'о';['П'] = 'п';['Р'] = 'р';['С'] = 'с';['Т'] = 'т';['У'] = 'у';['Ф'] = 'ф';['Х'] = 'х';['Ц'] = 'ц';['Ч'] = 'ч';['Ш'] = 'ш';['Щ'] = 'щ';['Ъ'] = 'ъ';['Ы'] = 'ы';['Ь'] = 'ь';['Э'] = 'э';['Ю'] = 'ю';['Я'] = 'я'}
local uppers = {['а'] = 'А';['б'] = 'Б';['в'] = 'В';['г'] = 'Г';['д'] = 'Д';['е'] = 'Е';['ё'] = 'Ё';['ж'] = 'Ж';['з'] = 'З';['и'] = 'И';['й'] = 'Й';['к'] = 'К';['л'] = 'Л';['м'] = 'М';['н'] = 'Н';['о'] = 'О';['п'] = 'П';['р'] = 'Р';['с'] = 'С';['т'] = 'Т';['у'] = 'У';['ф'] = 'Ф';['х'] = 'Х';['ц'] = 'Ц';['ч'] = 'Ч';['ш'] = 'Ш';['щ'] = 'Щ';['ъ'] = 'Ъ';['ы'] = 'Ы';['ь'] = 'Ь';['э'] = 'Э';['ю'] = 'Ю';['я'] = 'Я'}

function string:upper()

	local ret = ''

	for char in gmatch( self, '[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*' ) do
		ret = ret .. ( uppers[char] or string.upperEx( char ) )
	end

	return ret

end

function string:lower()

	local ret = ''

	for char in gmatch( self, '[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*' ) do
		ret = ret .. ( lowers[char] or string.lowerEx( char ) )
	end

	return ret

end

--[[---------------------------------------------------------------------------
	Translate
---------------------------------------------------------------------------]]
do if not coroutine.http then

	local running = coroutine.running
	local resume = coroutine.resume
	local Fetch = http.Fetch
	local yield = coroutine.yield
	local wrap = coroutine.wrap

	local function request( url )

		local co = running()

		local function onSuccess( body )
			resume( co, true, body )
		end

		local function onFailure( err )
			resume( co, false, err )
		end

		Fetch( url, onSuccess, onFailure )

		return yield()

	end

	coroutine.http = {}

	function coroutine.http.Fetch( url, callback )

		wrap( function()

			local state, response = request( url )
			callback( state, response )

		end )()

	end

end end

function string.Translate( text, source, target, callback )

	local url = format( 'https://api.mymemory.translated.net/get?q=%s&langpair=%s|%s', text, source, target ):Replace( ' ', '%20' )

	coroutine.http.Fetch( url, function( state, response )

		if not response then return end

		response = JSONToTable( response )
		callback( gsub( gsub( response.responseData.translatedText, '&#39;', '\'' ), '&quot;', '\"' ) )

	end )

end