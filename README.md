# string.lua

### UTF-8 support for `string.upper` and `string.lower`

```lua
print( string.lower( 'АБВ' ) ) -- абв
print( string.upper( 'абв' ) ) -- АБВ
```

### Translate

```lua
string.Translate( 'Hello World!', 'en', 'ru', function( translated )
	print( translated ) -- Привет Мир!
end )
```