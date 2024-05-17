SWEP.Base							= "weapon_tttbase"
SWEP.Category						= "Destiny Weapons"
SWEP.Manufacturer 					= "Pulse Rifle"
SWEP.Author							= "Delta"
SWEP.Contact						= "https://steamcommunity.com/id/DeltaDesigns/"
SWEP.Spawnable						= true
SWEP.AdminSpawnable					= true
SWEP.DrawCrosshair					= true
SWEP.DrawCrosshairIS 				= false
SWEP.PrintName						= "Blast Furnace"
SWEP.Type							= "Forged in the hottest fires."
SWEP.DrawAmmo						= true
SWEP.data 							= {}
SWEP.data.ironsights				= 1
SWEP.Secondary.IronFOV				= 70
SWEP.Slot							= 2
SWEP.SlotPos						= 100

SWEP.FiresUnderwater 				= true

SWEP.IronInSound 					= nil
SWEP.IronOutSound 					= nil
SWEP.CanBeSilenced					= false
SWEP.Silenced 						= false
SWEP.SelectiveFire					= false


SWEP.Primary.ClipSize				= 40
SWEP.Primary.DefaultClip			= 40*9
SWEP.Primary.Ammo					= "ar2"
SWEP.Primary.AmmoConsumption 		= 1
SWEP.Primary.Range 					= 10000
SWEP.Primary.RangeFalloff 			= 0.5
SWEP.Primary.Sound 					= Sound ("TFA_BLASTFURNACE_FIRE.1");
SWEP.Primary.ReloadSound 			= Sound ("TFA_BLASTFURNACE_RELOAD.1");
SWEP.Primary.PenetrationMultiplier 	= .75
SWEP.MaxPenetrationCounter = 1 --The maximum number of ricochets.  To prevent stack overflows.
SWEP.Primary.Damage = 21 -- Damage, in standard damage points.
SWEP.Primary.DamageTypeHandled = true -- true will handle damagetype in base
SWEP.Primary.DamageType = DMG_BULLET -- See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.Force = 1 -- Force value, leave nil to autocalc
SWEP.Primary.Knockback = 0 -- Autodetected if nil; this is the velocity kickback
SWEP.Primary.HullSize = 1 -- Big bullets, increase this value.  They increase the hull size of the hitscan bullet.
SWEP.Primary.NumShots = 1 -- The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.Automatic = true -- Automatic/Semi Auto
SWEP.OnlyBurstFire = true -- No auto, only burst/single?
//SWEP.Primary.RPM = 600 -- This is in Rounds Per Minute / RPM
//SWEP.Primary.RPM_Semi = 150 -- RPM for semi-automatic or burst fire.  This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Burst = 900 -- RPM for burst fire, overrides semi.  This is in Rounds Per Minute / RPM
SWEP.Primary.DryFireDelay = nil -- How long you have to wait after firing your last shot before a dryfire animation can play.  Leave nil for full empty attack length.  Can also use SWEP.StatusLength[ ACT_VM_BLABLA ]
SWEP.Primary.BurstDelay = nil -- Delay between bursts, leave nil to autocalculate
SWEP.BurstFireCount = 4 -- Burst fire count override (autocalculated by the clip size if nil)
//SWEP.MuzzleAttachment           = "muzzle"       -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.DoMuzzleFlash 					= true
SWEP.MuzzleFlashEffect 				= "tfa_muzzleflash_rifle"
SWEP.IronRecoilMultiplier			= 0.75
SWEP.CrouchRecoilMultiplier			= 0.85
SWEP.JumpRecoilMultiplier			= 2
SWEP.WallRecoilMultiplier			= 1.1
SWEP.ChangeStateRecoilMultiplier	= 1.2
SWEP.CrouchAccuracyMultiplier		= 0.8
SWEP.ChangeStateAccuracyMultiplier	= 1
SWEP.JumpAccuracyMultiplier			= 10
SWEP.WalkAccuracyMultiplier			= 1.8
SWEP.NearWallTime 					= 0.5
SWEP.ToCrouchTime 					= 0.25
SWEP.SprintFOVOffset 				= 2
SWEP.ProjectileVelocity 			= 9

SWEP.ProjectileEntity 				= nil
SWEP.ProjectileModel 				= nil

SWEP.ViewModel						= "models/weapons/c_blast_furnace.mdl"
SWEP.WorldModel						= nil
SWEP.ViewModelFOV					= 58
SWEP.ViewModelFlip					= false
SWEP.MaterialTable 					= nil
SWEP.UseHands 						= true
SWEP.HoldType 						= "ar2"
SWEP.ReloadHoldTypeOverride 		= "ar2"

SWEP.ShowWorldModel = false

SWEP.Tracer							= 0
SWEP.TracerName 					= nil
SWEP.TracerCount 					= 1
SWEP.TracerLua 						= true
SWEP.TracerDelay					= 0
SWEP.ImpactEffect 					= "impact"

SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)

SWEP.IronSightTime 					= 0.4
SWEP.Primary.KickUp					= 0.15
SWEP.Primary.KickDown				= 0.15
SWEP.Primary.KickHorizontal			= 0.1
SWEP.Primary.StaticRecoilFactor 	= 0.5
SWEP.Primary.Spread					= 0.02
SWEP.Primary.IronAccuracy 			= 0.001
SWEP.Primary.SpreadMultiplierMax 	= 1.5
SWEP.Primary.SpreadIncrement 		= 0.35
SWEP.Primary.SpreadRecovery 		= 0.98
SWEP.DisableChambering 				= true
SWEP.MoveSpeed 						= 1
SWEP.IronSightsMoveSpeed 			= 0.75

SWEP.IronSightsPos = Vector(-4.289, -4, -.70) 
SWEP.IronSightsAng = Vector(-.5, 0, 0)
SWEP.RunSightsPos = Vector(5.226, -2, 0)
SWEP.RunSightsAng = Vector(-18, 36, -13.5)
SWEP.InspectPos = Vector(7, -4, -4)
SWEP.InspectAng = Vector(20, 38, 5)	

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_Spine4"] = { scale = Vector(1, 1, 1), pos = Vector(-2.5, 1.6, 0.65), angle = Angle(0, -1, 0) },
	["ValveBiped.Bip01_L_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-10, 14, 2) },
	["ValveBiped.Bip01_L_Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -2, 0) },
}

SWEP.VElements = {
	["reticle"] = { type = "Model", model = "models/hunter/plates/plate1x1.mdl", bone = "WeaponBone", rel = "", pos = Vector(0.022, -20, -2.336), angle = Angle(0, 0, -90), size = Vector(.01, .01, 0), color = Color(255, 255, 255, 255), surpresslightning = false, material = "reticle/destiny2_reddot", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["world"] = { type = "Model", model = "models/weapons/c_blast_furnace.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-11.948, 6.752, -6.753), angle = Angle(-8.183, 1.169, 180), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

DEFINE_BASECLASS(SWEP.Base)

local l_CT = CurTime

function SWEP:Think()
	if CLIENT then
		if self:GetIronsights() then
			self.VElements["reticle"].color = Color(255, 255, 255, 255)
		else
			self.VElements["reticle"].color = Color(255, 255, 255, 0)
		end
	end
end