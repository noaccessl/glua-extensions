local function encode_url( url )
    return string.Replace( url, ' ', '%20' )
end

function mymemory_translate( text, source, target, callback )
	if not isfunction( callback ) then return end
	
    HTTP{
        url = encode_url( string.format( 'https://api.mymemory.translated.net/get?q=%s&langpair=%s|%s', text, source, target ) ),
        method = 'GET',
        success = function( num, body, tbl )
            if not body or body == '' then return end

            body = util.JSONToTable( body )
            callback( string.Replace( body.responseData.translatedText, '&#39;', [[']] ):Replace( '&quot;', [["]] ) )
        end,
        failed = function( reason )
            print( reason )
        end
    }
end

mymemory_translate( 'Hello World!', 'en', 'ru', function( translatedText )
    print( translatedText ) -- Привет Мир!
end )
