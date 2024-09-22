if ( string.upper == utf8.upper and string.lower == utf8.lower ) then
	return
end

--[[–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
	Prepare
–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––]]
--
-- Globals
--
local strlower	= string.lower
local strupper	= string.upper
local strgsub	= string.gsub


--[[–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
	Purpose: string.lower & string.upper with UTF-8 support
–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––]]
local UPPER_LOWER = {}
local LOWER_UPPER = {}

do

	UPPER_LOWER = {

		--
		-- Cyrillic
		--
		['А'] = 'а'; ['Б'] = 'б'; ['В'] = 'в'; ['Г'] = 'г'; ['Д'] = 'д'; ['Е'] = 'е'; ['Ё'] = 'ё'; ['Ж'] = 'ж'; ['З'] = 'з'; ['И'] = 'и'; ['Й'] = 'й';
		['К'] = 'к'; ['Л'] = 'л'; ['М'] = 'м'; ['Н'] = 'н'; ['О'] = 'о'; ['П'] = 'п'; ['Р'] = 'р'; ['С'] = 'с'; ['Т'] = 'т'; ['У'] = 'у'; ['Ф'] = 'ф';
		['Х'] = 'х'; ['Ц'] = 'ц'; ['Ч'] = 'ч'; ['Ш'] = 'ш'; ['Щ'] = 'щ'; ['Ъ'] = 'ъ'; ['Ы'] = 'ы'; ['Ь'] = 'ь'; ['Э'] = 'э'; ['Ю'] = 'ю'; ['Я'] = 'я';

		--
		-- Latin
		--
		A = 'a'; B = 'b'; C = 'c'; D = 'd'; E = 'e'; F = 'f'; G = 'g'; H = 'h'; I = 'i'; J = 'j'; K = 'k'; L = 'l'; M = 'm';
		N = 'n'; O = 'o'; P = 'p'; Q = 'q'; R = 'r'; S = 's'; T = 't'; U = 'u'; V = 'v'; W = 'w'; X = 'x'; Y = 'y'; Z = 'z';

		--
		-- Specific
		--
		[ '\t' ] = '\t'; [ '\n' ] = '\n'

	}

	--
	-- Translate to LOWER_UPPER
	--
	for upper, lower in pairs( UPPER_LOWER ) do
		LOWER_UPPER[ lower ] = upper
	end

	--
	-- Constant characters
	--
	local CHARS_CONST = [[ `1234567890-=~!@#$%^&*()_+/*[]\;',./{}|:"<>?]]

	for i = 1, #CHARS_CONST do

		local char = CHARS_CONST[ i ]

		UPPER_LOWER[ char ] = char
		LOWER_UPPER[ char ] = char

	end

end

local Upper2Lower = setmetatable( UPPER_LOWER, {

	--
	-- First it will look into the table for the existing characters translations.
	-- Unregistered character => use function
	--
	__index = function( self, char )

		return strlower( char )

	end

} )

local Lower2Upper = setmetatable( LOWER_UPPER, {

	--
	-- First it will look into the table for the existing characters translations.
	-- Unregistered character => use function
	--
	__index = function( self, char )

		return strupper( char )

	end

} )

function utf8.lower( str )

	local result = strgsub( str, '[%z\1-\127\194-\244][\128-\191]*', Upper2Lower )
	return result

end

function utf8.upper( str )

	local result = strgsub( str, '[%z\1-\127\194-\244][\128-\191]*', Lower2Upper )
	return result

end

-- Set to false if you don't want to override the default ones
if ( true ) then

	string.lower = utf8.lower
	string.upper = utf8.upper

end
