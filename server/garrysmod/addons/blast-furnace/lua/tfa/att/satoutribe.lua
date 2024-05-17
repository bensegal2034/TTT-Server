if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Satou Tribe"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Ice White", "Shiny Blue" }
ATTACHMENT.Icon = "entities/satoutribe.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Shader"

ATTACHMENT.WeaponTable = {
	["Skin"] = 1
}

function ATTACHMENT:Attach(wep)

end

function ATTACHMENT:Detach(wep)

end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end