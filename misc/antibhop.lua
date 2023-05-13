local band = bit.band
local abs = math.abs

local registry = debug.getregistry()

/* incredible perf */
local CMOVEDATA = registry.CMoveData
local GetButtons = CMOVEDATA.GetButtons
local GetOldButtons = CMOVEDATA.GetOldButtons
local GetAngles = CMOVEDATA.GetAngles
local GetForwardSpeed = CMOVEDATA.GetForwardSpeed
local GetMaxSpeed = CMOVEDATA.GetMaxSpeed
local GetVelocity = CMOVEDATA.GetVelocity
local SetVelocity = CMOVEDATA.SetVelocity

local PLAYER = registry.Player
local OnGround = PLAYER.OnGround
local Crouching = PLAYER.Crouching

local Forward = registry.Angle.Forward
local Length2D = regisrty.Vector.Length2D
local Dot = regisrty.Vector.Dot

local JUMPING = false

hook.Add( 'SetupMove', 'antibhop', function( pl, cmd )

	if band( GetButtons( cmd ), IN_JUMP ) ~= 0 and band( GetOldButtons( cmd ), IN_JUMP ) == 0 and OnGround( pl ) then
		JUMPING = true
	end

end )

hook.Add( 'FinishMove', 'antibhop', function( pl, cmd )

	if JUMPING then

		local ang = GetAngles( cmd )
		ang.p = 0
		ang = Forward( ang )

		local mul = not Crouching( pl ) and 0.05 or 0.01
		local speed = abs( GetForwardSpeed( cmd ) * mul )
		local maxspeed = GetMaxSpeed( cmd ) * ( 1 + mul )
		local vel = speed + Length2D( GetVelocity( cmd ) )

		if vel > maxspeed then
			speed = speed - ( vel - maxspeed )
		end

		if Dot( GetVelocity( cmd ), ang ) < 0 then
			speed = -speed
		end

		SetVelocity( cmd, ang * speed + GetVelocity( cmd ) )

	end

	JUMPING = false

end )