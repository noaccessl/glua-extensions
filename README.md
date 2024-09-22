# Simple extensions for GLua

---

### [UTF-8](utf8.lua)
* `string.lower` & `string.upper` with UTF-8  support
```lua
print( utf8.lower( 'АБВ' ) ) -- абв
print( utf8.upper( 'абв' ) ) -- АБВ
```
