function EFFECT:Init( data )

	self.Position = data:GetOrigin();
	self.Normal = data:GetNormal();

	local emitter = ParticleEmitter( self.Position );
	if( emitter ) then
		
		for i = 1, 1 do

			local particle = emitter:Add( "effects/halo3/flash_large", self.Position + self.Normal * 2 );
			particle:SetVelocity( ( self.Normal + Vector(math.Rand(2, 7),math.Rand(2, 7),1) * 0.75 ):GetNormal() * math.Rand( 75, 125 ) );
			particle:SetDieTime( math.Rand( 0.05, 0.15 ) );
			particle:SetStartAlpha( 255 );
			particle:SetEndAlpha( 0 );
			particle:SetStartSize( math.Rand( 3, 5 ) );
			particle:SetEndSize( 30 );
			particle:SetRoll( math.Rand(-55, 85) );
			particle:SetGravity( Vector( 0, 0, 0 ) );
			particle:SetColor(255, 211, 235);
			particle:SetCollide( true );
			particle:SetBounce( 0 );
			particle:SetAirResistance( 500 );

		end
		
		for i = 1, 1 do

			local particle = emitter:Add( "effects/halo3/muzzle_flash_round_gaseous", self.Position + self.Normal * 2 );
			particle:SetVelocity( ( self.Normal + Vector(math.Rand(3, 5),math.Rand(3, 5),1) * 0.75 ):GetNormal() * math.Rand( 75, 125 ) );
			particle:SetDieTime( math.Rand( 0.2, 0.3 ) );
			particle:SetStartAlpha( 155 );
			particle:SetEndAlpha( 0 );
			particle:SetStartSize( math.Rand( 3, 5 ) );
			particle:SetEndSize( 25 );
			particle:SetRoll( math.Rand(-55, 85) );
			particle:SetGravity( Vector( 0, 0, 0 ) );
			particle:SetColor(255, 179, 222);
			particle:SetCollide( true );
			particle:SetBounce( 0 );
			particle:SetAirResistance( 500 );

		end

		for i = 1, 1 do

			local particle = emitter:Add( "effects/halo3/electric_arcs", self.Position + self.Normal * 2 );
			particle:SetVelocity( ( self.Normal + Vector(math.Rand(3, 5),math.Rand(3, 5),1) * 0.75 ):GetNormal() * math.Rand( 75, 125 ) );
			particle:SetDieTime( math.Rand( 0.05, 0.1 ) );
			particle:SetStartAlpha( 255 );
			particle:SetEndAlpha( 0 );
			particle:SetStartSize( math.Rand( 3, 5 ) );
			particle:SetEndSize( 20 );
			particle:SetRoll( math.Rand(-55, 85) );
			particle:SetGravity( Vector( 0, 0, 0 ) );
			particle:SetColor(255, 179, 222);
			particle:SetCollide( true );
			particle:SetBounce( 0 );
			particle:SetAirResistance( 500 );

		end
		
	for i = 1, 1 do

			local particle = emitter:Add( "effects/halo3/explosive_burst", self.Position + self.Normal * 2 );
			particle:SetVelocity( ( self.Normal + Vector(math.Rand(2, 7),math.Rand(2, 7),1) * 0.75 ):GetNormal() * math.Rand( 75, 125 ) );
			particle:SetDieTime( math.Rand( 0.1, 0.2 ) );
			particle:SetStartAlpha( 255 );
			particle:SetEndAlpha( 0 );
			particle:SetStartSize( math.Rand( 3, 5 ) );
			particle:SetEndSize( 25 );
			particle:SetRoll( math.Rand(-55, 85) );
			particle:SetGravity( Vector( 0, 0, 0 ) );
			particle:SetColor(255, 211, 235);
			particle:SetCollide( true );
			particle:SetBounce( 0 );
			particle:SetAirResistance( 500 );

		end
		emitter:Finish();
	end
	end


function EFFECT:Think()
	return false	
end


function EFFECT:Render()
end
