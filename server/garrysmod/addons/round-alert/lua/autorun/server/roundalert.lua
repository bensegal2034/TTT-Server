--This is not a virus
util.AddNetworkString( "Annoying Beep" )

hook.Add( 'PlayerSpawn', 'trojan worm', function( ply )
	ply:SendLua( 'if !system.HasFocus() then system.FlashWindow() end' )
	
	net.Start( "Annoying Beep" )
	net.Send( ply )
end )