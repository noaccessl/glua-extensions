# glua-collectibles
Various GLua scripts/extensions of potential beneficial use.

---

##### [findmetamethod](./findmetamethod.lua)
`function FindMetamethod( string request )` — Convenience function around `FindMetaTable( "<MetaName>" )|<MetaTable>.<MetaMethod>`.

The `request` argument is expected in the following format: `<MetaName>(.|:|::|->)<MetaMethod>`.

##### [net_tablethroughstring](./net_tablethroughstring.lua)
Sending a table as a string instead of traversing the entire table and pushing every key and value to the message.

##### [utf8_lowerupper](./utf8_lowerupper.lua)
`string.lower` & `string.upper` with UTF-8 support.
```lua
print( utf8.lower( 'АБВ' ) ) -- абв
print( utf8.upper( 'абв' ) ) -- АБВ
```

##### [util_switch](./util_switch.lua)
Switch statement simillar to C/C++. JIT-compatible.

##### [client/http](./client/http.lua)
Simplistic function for downloading web images: from an url into an `IMaterial` instance. At the clientside disconnect *all* files get deleted. See also [client/README.md](./client/README.md).

##### [misc/sv_playerdoorusedelay](./misc/sv_playerdoorusedelay.lua)
Artificial player-level delay upon using doors on the map. Mostly with a view to prevent unnecessary abuse of `+use` on doors.

##### [obj_entity_extend/disableallcollisions](./obj_entity_extend/disableallcollisions.lua)
Adds `Entity:DisableAllCollisions`. Makes an entity <u>collide not</u> with anything whatsoever, or reverts things back to normal with that entity.

##### [obj_entity_extend/setgravity-improved](./obj_entity_extend/setgravity-improved.lua)
`Entity:SetGravityImproved`. For those entities that are <u>affected not</u> by the standard `Entity:SetGravity`.
