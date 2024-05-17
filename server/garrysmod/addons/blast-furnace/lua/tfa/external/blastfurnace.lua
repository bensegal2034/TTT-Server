local path = "weapons/blastfurnace/"

TFA.AddWeaponSound("TFA_BLASTFURNACE_FIRE.1",  { path .. "BlastFurnaceFire1.wav", path .. "BlastFurnaceFire2.wav", path .. "BlastFurnaceFire3.wav" }, false, ")" )
TFA.AddWeaponSound("TFA_BLASTFURNACE_RELOAD.1",  { path .. "BlastFurnaceReload.wav" }, false, ")" )

local icol = Color( 255, 100, 0, 255 ) 
if CLIENT then
	killicon.Add(  "destiny_blast_furnace",	"vgui/killicons/destiny_blast_furnace", icol  )
end