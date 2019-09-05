-- Sets defaults if this is first-run.

cfg = {}

local function SetDefaults()
	if cfg.bigPlayerHealthBar == nil then
		cfg.bigPlayerHealthBar = false
	end

	if cfg.bigTargetHealthBar == nil then
		cfg.bigTargetHealthBar = false
	end

	if cfg.classHealthBarColor == nil then
		cfg.classHealthBarColor = true
	end

	if cfg.classIconPortraits == nil then
		cfg.classIconPortraits = false
	end

	if cfg.elitePlayerFrame == nil then
		cfg.elitePlayerFrame = false
	end

	if cfg.hideHitIndicators == nil then
		cfg.hideHitIndicators = false
	end

	if cfg.hidePetStatusText == nil then
		cfg.hidePetStatusText = true
	end

	if cfg.hideRestingIcon == nil then
		cfg.hideRestingIcon = true
	end

	if cfg.largeAuraIconSize == nil then
		cfg.largeAuraIconSize = 25
	end

	if cfg.rarePlayerFrame == nil then
		cfg.rarePlayerFrame = false
	end

	if cfg.rareElitePlayerFrame == nil then
		cfg.rareElitePlayerFrame = false
	end

	if cfg.reactionHealthBarColor == nil then
		cfg.reactionHealthBarColor = true
	end

	if cfg.shamanClassColorFix == nil then
		cfg.shamanClassColorFix = true
	end

	if cfg.smallAuraIconSize == nil then
		cfg.smallAuraIconSize = 20
	end

	if cfg.upperCaseAbbreviation == nil then
		cfg.upperCaseAbbreviation = true
	end

	if cfg.wideTargetFrame == nil then
		cfg.wideTargetFrame = true
	end

	if cfg.wideTargetFrameWidth == nil then
		cfg.wideTargetFrameWidth = 280
	end
end

SetDefaults()

-- Creates the options panel.

local function CreateOptionsPanel(frame)
	eufUI = {}
	eufUI.panel = CreateFrame("Frame", "eufUI", UIParent)
	eufUI.panel.name = "EnhancedUnitFrames"

	InterfaceOptions_AddCategory(eufUI.panel)

	local title = eufUI.panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText("EnhancedUnitFrames")

	StaticPopupDialogs["RELOAD_UI"] = {
		text = "One or more of the changes you have made require a ReloadUI.",
		button1 = ACCEPT,
		button2 = CANCEL,
		OnAccept = function()
			ReloadUI()
		end,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = true,
		preferredIndex = 3,
	}

	-- Checkbox creation function.

	local i = 1

	local function createCheckbox(label, description)
		i = i + 1
		local checkbox = CreateFrame("CheckButton", "eufCheckbox" .. i, eufUI.panel, "InterfaceOptionsCheckButtonTemplate")
		checkbox.label = _G[checkbox:GetName() .. "Text"]

		checkbox.label:SetText(label)
		checkbox.tooltipText = label
		checkbox.tooltipRequirement = description

		return checkbox
	end

	-- Creates checkboxes.

	local bigPlayerHealthBar = createCheckbox("Big Player Health Bar", "Placeholder")
	local bigTargetHealthBar = createCheckbox("Big Target Health Bar", "Placeholder")
	local wideTargetFrame = createCheckbox("Wide Target Frame", "Placeholder")
	local classHealthBarColor = createCheckbox("Class Color HP", "Placeholder")
	local reactionHealthBarColor = createCheckbox("Reaction Color HP", "Placeholder")
	local elitePlayerFrame = createCheckbox("Elite Player Frame", "Placeholder")
	local rarePlayerFrame = createCheckbox("Rare Player Frame", "Placeholder")
	local rareElitePlayerFrame = createCheckbox("Rare Elite Player Frame", "Placeholder")
	local classIconPortraits = createCheckbox("Class Icon Portraits", "Placeholder")
	local hideHitIndicators = createCheckbox("Hide Hit Indicators", "Placeholder")
	local hidePetStatusText = createCheckbox("Hide Pet Status Text", "Placeholder")
	local hideRestingIcon = createCheckbox("Hide Resting Icon", "Placeholder")
	local shamanClassColorFix = createCheckbox("Shaman Class Color Fix", "Placeholder")
	local upperCaseAbbreviation = createCheckbox("Uppercase Abbreviation", "Placeholder")

	-- Positions the checkboxes created.

	bigPlayerHealthBar:SetPoint("TOPLEFT", title, "BOTTOMLEFT", -2, -16)
	bigTargetHealthBar:SetPoint("TOPLEFT", bigPlayerHealthBar, "BOTTOMLEFT", 0, -8)
	wideTargetFrame:SetPoint("TOPLEFT", bigTargetHealthBar, "BOTTOMLEFT", 0, -8)
	classHealthBarColor:SetPoint("TOPLEFT", wideTargetFrame, "BOTTOMLEFT", 0, -8)
	reactionHealthBarColor:SetPoint("TOPLEFT", classHealthBarColor, "BOTTOMLEFT", 0, -8)
	elitePlayerFrame:SetPoint("TOPLEFT", reactionHealthBarColor, "BOTTOMLEFT", 0, -8)
	rarePlayerFrame:SetPoint("TOPLEFT", elitePlayerFrame, "BOTTOMLEFT", 0, -8)
	rareElitePlayerFrame:SetPoint("TOPLEFT", rarePlayerFrame, "BOTTOMLEFT", 0, -8)
	classIconPortraits:SetPoint("TOPLEFT", rareElitePlayerFrame, "BOTTOMLEFT", 0, -8)
	hideHitIndicators:SetPoint("TOPLEFT", classIconPortraits, "BOTTOMLEFT", 0, -8)
	hidePetStatusText:SetPoint("TOPLEFT", hideHitIndicators, "BOTTOMLEFT", 0, -8)
	hideRestingIcon:SetPoint("TOPLEFT", hidePetStatusText, "BOTTOMLEFT", 0, -8)
	shamanClassColorFix:SetPoint("TOPLEFT", hideRestingIcon, "BOTTOMLEFT", 0, -8)
	upperCaseAbbreviation:SetPoint("TOPLEFT", shamanClassColorFix, "BOTTOMLEFT", 0, -8)

	-- Applies scripts when the checkboxes are clicked.

	bigPlayerHealthBar:SetScript("OnClick", function(self)
		if bigPlayerHealthBar:GetChecked() then
			cfg.bigPlayerHealthBar = true
			PlaySound(856)
		else
			cfg.bigPlayerHealthBar = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	bigTargetHealthBar:SetScript("OnClick", function(self)
		if bigTargetHealthBar:GetChecked() then
			cfg.bigTargetHealthBar = true
			PlaySound(856)
		else
			cfg.bigTargetHealthBar = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	wideTargetFrame:SetScript("OnClick", function(self)
		if wideTargetFrame:GetChecked() then
			cfg.wideTargetFrame = true
			PlaySound(856)
		else
			cfg.wideTargetFrame = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	classHealthBarColor:SetScript("OnClick", function(self)
		if classHealthBarColor:GetChecked() then
			cfg.classHealthBarColor = true
			PlaySound(856)
		else
			cfg.classHealthBarColor = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	reactionHealthBarColor:SetScript("OnClick", function(self)
		if reactionHealthBarColor:GetChecked() then
			cfg.reactionHealthBarColor = true
			PlaySound(856)
		else
			cfg.reactionHealthBarColor = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	elitePlayerFrame:SetScript("OnClick", function(self)
		if elitePlayerFrame:GetChecked() then
			cfg.elitePlayerFrame = true
			PlaySound(856)
		else
			cfg.elitePlayerFrame = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	rarePlayerFrame:SetScript("OnClick", function(self)
		if rarePlayerFrame:GetChecked() then
			cfg.rarePlayerFrame = true
			PlaySound(856)
		else
			cfg.rarePlayerFrame = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	rareElitePlayerFrame:SetScript("OnClick", function(self)
		if rareElitePlayerFrame:GetChecked() then
			cfg.rareElitePlayerFrame = true
			PlaySound(856)
		else
			cfg.rareElitePlayerFrame = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	classIconPortraits:SetScript("OnClick", function(self)
		if classIconPortraits:GetChecked() then
			cfg.classIconPortraits = true
			PlaySound(856)
		else
			cfg.classIconPortraits = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	hideHitIndicators:SetScript("OnClick", function(self)
		if hideHitIndicators:GetChecked() then
			cfg.hideHitIndicators = true
			PlaySound(856)
		else
			cfg.hideHitIndicators = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	hidePetStatusText:SetScript("OnClick", function(self)
		if hidePetStatusText:GetChecked() then
			cfg.hidePetStatusText = true
			PlaySound(856)
		else
			cfg.hidePetStatusText = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	hideRestingIcon:SetScript("OnClick", function(self)
		if hideRestingIcon:GetChecked() then
			cfg.hideRestingIcon = true
			PlaySound(856)
		else
			cfg.hideRestingIcon = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	shamanClassColorFix:SetScript("OnClick", function(self)
		if shamanClassColorFix:GetChecked() then
			cfg.shamanClassColorFix = true
			PlaySound(856)
		else
			cfg.shamanClassColorFix = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	upperCaseAbbreviation:SetScript("OnClick", function(self)
		if upperCaseAbbreviation:GetChecked() then
			cfg.upperCaseAbbreviation = true
			PlaySound(856)
		else
			cfg.upperCaseAbbreviation = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)
end

CreateOptionsPanel()

-- Initializes the options panel with saved variables.

local function InitializeOptionsPanel(event, addon, ...)
	if cfg.bigPlayerHealthBar == true then
		eufCheckbox2:SetChecked(true)
	end

	if cfg.bigTargetHealthBar == true then
		eufCheckbox3:SetChecked(true)
	end

	if cfg.wideTargetFrame == true then
		eufCheckbox4:SetChecked(true)
	end

	if cfg.classHealthBarColor == true then
		eufCheckbox5:SetChecked(true)
	end

	if cfg.reactionHealthBarColor == true then
		eufCheckbox6:SetChecked(true)
	end

	if cfg.elitePlayerFrame == true then
		eufCheckbox7:SetChecked(true)
	end

	if cfg.rarePlayerFrame == true then
		eufCheckbox8:SetChecked(true)
	end

	if cfg.rareElitePlayerFrame == true then
		eufCheckbox9:SetChecked(true)
	end

	if cfg.classIconPortraits == true then
		eufCheckbox10:SetChecked(true)
	end

	if cfg.hideHitIndicators == true then
		eufCheckbox11:SetChecked(true)
	end

	if cfg.hidePetStatusText == true then
		eufCheckbox12:SetChecked(true)
	end

	if cfg.hideRestingIcon == true then
		eufCheckbox13:SetChecked(true)
	end

	if cfg.shamanClassColorFix == true then
		eufCheckbox14:SetChecked(true)
	end

	if cfg.upperCaseAbbreviation == true then
		eufCheckbox15:SetChecked(true)
	end
end

-- Loads the addon's components and initializes the option panel.

local euf = CreateFrame("Frame")

euf:RegisterEvent("ADDON_LOADED")

local function IsAddOnLoaded(self, event, addon)
	if event == "ADDON_LOADED" then
		AuraStyling()
		BossFrameStyling()
		ClassIconPortraits()
		InitializeOptionsPanel()
		PlayerFrameStyling()
		ShamanClassColorFix()
		StatusBarStyling()
		StatusTextStyling()
		TargetFrameStyling()

		euf:UnregisterEvent("ADDON_LOADED")
	end
end

euf:SetScript("OnEvent", IsAddOnLoaded)

-- Creates the addon's slash command.

SlashCmdList.euf = function()
	InterfaceOptionsFrame_OpenToCategory(eufUI.panel)
	InterfaceOptionsFrame_OpenToCategory(eufUI.panel)
	PlaySound(852)
end

SLASH_euf1 = "/euf"
