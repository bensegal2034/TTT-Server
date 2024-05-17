TFA.Attachments = TFA.Attachments or {}
TFA.Attachments.Atts = {}

TFA.Attachments.Colors = {
	["active"] = Color(252, 151, 50, 255),
	["error"] = Color(225, 0, 0, 255),
	["error_attached"] = Color(140, 80, 30, 255),
	["background"] = Color(15, 15, 15, 64),
	["primary"] = Color(245, 245, 245, 255),
	["secondary"] = Color(153, 253, 220, 255),
	["+"] = Color(128, 255, 128, 255),
	["-"] = Color(255, 128, 128, 255),
	["="] = Color(192, 192, 192, 255)
}

TFA.Attachments.UIPadding = 2
TFA.Attachments.IconSize = 64
TFA.Attachments.CategorySpacing = 128

if SERVER then
	util.AddNetworkString("TFA_Attachment_Set")
	util.AddNetworkString("TFA_Attachment_SetStatus")
	util.AddNetworkString("TFA_Attachment_Reload")
	util.AddNetworkString("TFA_Attachment_Request")

	local UpdateWeaponQueue = {}

	local function UpdateWeapon(wep, ply)
		if not wep.HasInitAttachments or wep.AttachmentCount < 1 then return end

		UpdateWeaponQueue[ply] = UpdateWeaponQueue[ply] or {}

		if UpdateWeaponQueue[ply][wep] then return end
		UpdateWeaponQueue[ply][wep] = true

		for category, data in pairs(wep.Attachments or {}) do
			if type(category) ~= "string" then
				net.Start("TFA_Attachment_Set")
				net.WriteEntity(wep)

				net.WriteUInt(category, 8)
				if data.atts and data.atts[data.sel] then
					net.WriteString(data.atts[data.sel])
				else
					net.WriteString("")
				end

				net.Send(ply)
			end
		end

		UpdateWeaponQueue[ply][wep] = nil
	end

	net.Receive("TFA_Attachment_Request", function(len, ply)
		if not IsValid(ply) then return end
		local wep = net.ReadEntity()
		if not IsValid(wep) or not wep.IsTFAWeapon then return end
		UpdateWeapon(wep, ply)
	end)

	net.Receive("TFA_Attachment_Set", function(len, ply)
		local wep = ply:GetWeapon(net.ReadString())
		if not IsValid(wep) or not wep.IsTFAWeapon then return end

		local cat = net.ReadUInt(8)
		local ind = net.ReadString()
		local status = wep:SetTFAAttachment(cat, ind, ply)

		net.Start("TFA_Attachment_SetStatus")
		net.WriteEntity(wep)
		net.WriteBool(status)

		if not status then
			if wep.Attachments and wep.Attachments[cat] then
				local data = wep.Attachments[cat]
				net.WriteUInt(cat, 8)

				if data.atts and data.atts[data.sel] then
					net.WriteString(data.atts[data.sel])
				else
					net.WriteString("")
				end
			end
		end

		net.Send(ply)
	end)
else
	sql.Query([[
		CREATE TABLE IF NOT EXISTS tfa_savedattachments (
			class VARCHAR(80) NOT NULL,
			atts TEXT NOT NULL,
			PRIMARY KEY (class)
		)
	]])

	net.Receive("TFA_Attachment_Set", function(len)
		local wep = net.ReadEntity()

		local cat = net.ReadUInt(8)
		local ind = net.ReadString()

		if IsValid(wep) and wep.SetTFAAttachment then
			wep:SetTFAAttachment(cat, ind, false)
		end
	end)

	net.Receive("TFA_Attachment_Reload", function(len)
		TFAUpdateAttachments()
	end)

	net.Receive("TFA_Attachment_SetStatus", function(len)
		local weapon = net.ReadEntity()
		if not IsValid(weapon) then return end
		local status = net.ReadBool()

		if status then
			weapon:SaveAttachments()
			return
		end
		surface.PlaySound("buttons/button2.wav")

		local cat = net.ReadUInt(8)
		local ind = net.ReadString()
		weapon:SetTFAAttachment(cat, ind, false)
	end)

	local function request(self)
		if self._TFA_Attachment_Request then return end
		if not self.HasInitAttachments or self.AttachmentCount < 1 then return end
		net.Start("TFA_Attachment_Request")
		net.WriteEntity(self)
		net.SendToServer()
		self._TFA_Attachment_Request = true
	end

	hook.Add("NotifyShouldTransmit", "TFA_AttachmentsRequest", function(self, notDormant)
		if not self.IsTFAWeapon or not notDormant then return end
		request(self)
	end)

	hook.Add("NetworkEntityCreated", "TFA_AttachmentsRequest", function(self)
		timer.Simple(0, function()
			if not IsValid(self) or not self.IsTFAWeapon then return end
			request(self)
		end)
	end)

	hook.Add("OnEntityCreated", "TFA_AttachmentsRequest", function(self)
		timer.Simple(0, function()
			if not IsValid(self) or not self.IsTFAWeapon then return end
			request(self)
		end)
	end)

	local LoadQuery = [[SELECT atts FROM tfa_savedattachments WHERE class = '%s']]
	function TFA.GetSavedAttachments(Weapon)
		if not IsValid(Weapon) or not Weapon.IsTFAWeapon then return end

		local data = sql.QueryRow(string.format(LoadQuery, sql.SQLStr(Weapon:GetClass(), true)))

		if data and data.atts then
			return util.JSONToTable(data.atts)
		end
	end

	local SaveQuery = [[REPLACE INTO tfa_savedattachments (class, atts) VALUES ('%s', '%s');]]
	function TFA.SetSavedAttachments(Weapon)
		if not IsValid(Weapon) or not Weapon.IsTFAWeapon or not next(Weapon.Attachments or {}) then return end

		local seltbl = {}
		for cat, catTbl in pairs(Weapon.Attachments or {}) do
			if cat ~= "BaseClass" and catTbl.atts then
				seltbl[cat] = catTbl.atts[catTbl.sel or -1] or ""
			end
		end

		return sql.Query(string.format(SaveQuery, sql.SQLStr(Weapon:GetClass(), true), sql.SQLStr(util.TableToJSON(seltbl), true)))
	end
end

function TFA.Attachments.Register(id, ATTACHMENT)
	if istable(id) then
		ATTACHMENT = id
		id = ATTACHMENT.ID
	end

	assert(istable(ATTACHMENT), "Invalid attachment argument provided")
	assert(isstring(id), "Invalid attachment ID provided")
	local size = table.Count(ATTACHMENT)

	if size == 0 or size == 1 and ATTACHMENT.ID ~= nil then
		local id2 = id or ATTACHMENT.ID

		if id2 then
			ErrorNoHalt("[TFA Base] Attempt to register an empty attachment " .. id2 .. "\n")
		else
			ErrorNoHalt("[TFA Base] Attempt to register an empty attachment\n")
		end

		ErrorNoHalt(debug.traceback() .. "\n")
		MsgC("\n")
		return
	end

	ATTACHMENT.ID = ATTACHMENT.ID or id

	if ATTACHMENT.ID and ATTACHMENT.ID ~= "base" then
		ATTACHMENT.Base = ATTACHMENT.Base or "base"
	end

	--[[if not TFA_ATTACHMENT_ISUPDATING and istable(ATTACHMENT.WeaponTable) then
		TFA.MigrateStructure(ATTACHMENT, ATTACHMENT.WeaponTable, id or "<attachment>", false)
	end]]

	ProtectedCall(function()
		hook.Run("TFABase_RegisterAttachment", id, ATTACHMENT)
	end)

	TFA.Attachments.Atts[ATTACHMENT.ID or ATTACHMENT.Name] = ATTACHMENT
end

TFARegisterAttachment = TFA.Attachments.Register
TFA.Attachments.Path = "tfa/att/"
TFA_ATTACHMENT_ISUPDATING = false

local function basefunc(t, k)
	if k == "Base" then return end

	if t.Base then
		local bt = TFA.Attachments.Atts[t.Base]
		if bt then return bt[k] end
	end
end

local inheritanceCached = {}
local missingBaseWarningShown = {}

local function patchInheritance(t, basetbl)
	if t.Base and t.Base ~= "base" and not TFA.Attachments.Atts[t.Base] then
		if t.ID and not missingBaseWarningShown[t.ID] then
			missingBaseWarningShown[t.ID] = true

			print("[TFA Base] [!] Attachment '" .. t.ID .. "' depends on unknown attachment '" .. t.Base .. "'!")
		end

		t.Base = "base"
	end

	if not basetbl and t.Base then
		basetbl = TFA.Attachments.Atts[t.Base]

		if basetbl and istable(basetbl) and basetbl.ID and not inheritanceCached[basetbl.ID] then
			inheritanceCached[basetbl.ID] = true
			patchInheritance(basetbl)
		end
	end

	if not (basetbl and istable(basetbl)) then return end

	for k, v in pairs(t) do
		local baseT = basetbl[k]

		if istable(v) and baseT then
			patchInheritance(v, baseT)
		end
	end

	for k, v in pairs(basetbl) do
		if rawget(t, k) == nil then
			t[k] = v
		end
	end
end

function TFAUpdateAttachments(network)
	if SERVER and network ~= false then
		net.Start("TFA_Attachment_Reload")
		net.Broadcast()
	end

	TFA.AttachmentColors = TFA.Attachments.Colors --for compatibility
	TFA.Attachments.Atts = {}
	TFA_ATTACHMENT_ISUPDATING = true
	local tbl = file.Find(TFA.Attachments.Path .. "*base*", "LUA")
	local addtbl = file.Find(TFA.Attachments.Path .. "*", "LUA")

	for _, v in ipairs(addtbl) do
		if not string.find(v, "base") then
			table.insert(tbl, #tbl + 1, v)
		end
	end

	table.sort(tbl)

	for _, fname in ipairs(tbl) do
		local path = TFA.Attachments.Path .. fname
		local id = fname:lower():Replace(".lua", "")

		local status

		ProtectedCall(function()
			status = hook.Run("TFABase_ShouldLoadAttachment", id, path)
		end)

		if status ~= false then
			ATTACHMENT = {}

			setmetatable(ATTACHMENT, {
				__index = basefunc
			})

			ATTACHMENT.ID = id

			ProtectedCall(function()
				hook.Run("TFABase_PreBuildAttachment", id, path, ATTACHMENT)
			end)

			if SERVER then
				AddCSLuaFile(path)
				include(path)
			else
				include(path)
			end

			ProtectedCall(function()
				hook.Run("TFABase_BuildAttachment", id, path, ATTACHMENT)
			end)

			TFA.Attachments.Register(ATTACHMENT)
			ATTACHMENT = nil
		end
	end

	ProtectedCall(function()
		hook.Run("TFAAttachmentsLoaded")
	end)

	for _, v in pairs(TFA.Attachments.Atts) do
		patchInheritance(v)

		--[[if istable(v.WeaponTable) then
			TFA.MigrateStructure(v, v.WeaponTable, v.ID or "<attachment>", false)
		end]]
	end

	ProtectedCall(function()
		hook.Run("TFAAttachmentsInitialized")
	end)

	TFA_ATTACHMENT_ISUPDATING = false
end

hook.Add("Initialize", "TFAUpdateAttachmentsIPE", TFAUpdateAttachments)
hook.Add("InitPostEntity", "TFAUpdateAttachmentsIPE", TFAUpdateAttachments)

if not VLL2_FILEDEF then
	TFAUpdateAttachments()
end

concommand.Add("sv_tfa_attachments_reload", function(ply, cmd, args, argStr)
	if SERVER and (not IsValid(ply) or ply:IsAdmin()) then
		TFAUpdateAttachments()
	end
end, function() end, "Reloads all TFA Attachments", {FCVAR_SERVER_CAN_EXECUTE})
