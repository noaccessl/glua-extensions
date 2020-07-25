local function EncodeURL( URL )
    return string.Replace( URL, ' ', '%20' )
end

local API = 'trnsl.1.1.20190822T114859Z.8b4909373dc0b830.cf06aab555bbefc0acd710f07f8d6903105fe7ff'

function YandexTranslate( From, To, Text, Callback )
    local URL = string.format(
    	'https://translate.yandex.net/api/v1.5/tr.json/translate?key=%s&text=%s&lang=%s-%s',
    	API, Text, From, To
    )

    http.Fetch( EncodeURL( URL ), function( body )
        local Reception = util.JSONToTable( body )

        if ( Callback ) then
            Callback( table.concat( Reception.text, ' ' ), Reception )
        end
    end )
end

--[[
YandexTranslate( 'en', 'ru', 'Hello!', function( TranslatedText, Reception )
	print( TranslatedText ) -- Что-то типо "Привет!"
end )
]]
