local JUMPING = false

hook.Add( 'SetupMove', 'antibhop', function( pl, cmd )

	if bit.band( cmd:GetButtons(), IN_JUMP ) ~= 0 and bit.band( cmd:GetOldButtons(), IN_JUMP ) == 0 and pl:OnGround() then
		JUMPING = true
	end

end )

hook.Add( 'FinishMove', 'antibhop', function( pl, cmd )

	if JUMPING then

		local ang = cmd:GetAngles()
		ang.p = 0
		ang = ang:Forward()

		local mul = not pl:Crouching() and 0.05 or 0.01
		local speed = math.abs( cmd:GetForwardSpeed() * mul )
		local maxspeed = cmd:GetMaxSpeed() * ( 1 + mul )
		local vel = speed + cmd:GetVelocity():Length2D()

		if vel > maxspeed then
			speed = speed - ( vel - maxspeed )
		end

		if cmd:GetVelocity():Dot( ang ) < 0 then
			speed = -speed
		end

		cmd:SetVelocity( ang * speed + cmd:GetVelocity() )

	end

	JUMPING = false

end )
