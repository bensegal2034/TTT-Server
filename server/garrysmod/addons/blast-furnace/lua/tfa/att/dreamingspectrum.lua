if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Dreaming Spectrum"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Ahamkara Bone", "Shiny Creme" }
ATTACHMENT.Icon = "entities/dreamingspectrum.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Shader"

ATTACHMENT.WeaponTable = {
	["Skin"] = 3
}

function ATTACHMENT:Attach(wep)
	
end

function ATTACHMENT:Detach(wep)

end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end