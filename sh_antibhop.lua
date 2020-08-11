local JUMPING

hook.Add( 'SetupMove', 'antibhop', function( player, Move, CMoveData )
	if ( bit.band( Move:GetButtons(), IN_JUMP ) ~= 0 and bit.band( Move:GetOldButtons(), IN_JUMP ) == 0 and player:OnGround() ) then
		JUMPING = true
	end
end )

hook.Add( 'FinishMove', 'antibhop', function( player, Move )
    if ( JUMPING ) then
		local Angle = Move:GetAngles()
		Angle.p = 0
		Angle = Angle:Forward()

		local a = ( ( not player:Crouching() ) and 0.05 ) or 0.01
		local b = math_abs( Move:GetForwardSpeed() * a )
		local c = Move:GetMaxSpeed() * ( 1 + a )
		local d = b + Move:GetVelocity():Length2D()

		if ( d > c ) then
			b = b - ( d - c )
		end

		if ( Move:GetVelocity():Dot( Angle ) < 0 ) then
			b = -b
		end

		Move:SetVelocity( Angle * b + Move:GetVelocity() )
	end

	JUMPING = nil
end )
