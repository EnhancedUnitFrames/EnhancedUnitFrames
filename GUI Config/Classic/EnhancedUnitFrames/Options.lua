-- Creates the options panel.

eufOptions = CreateFrame("Frame", "eufOptionsPanel", UIParent)
eufOptions.name = "EnhancedUnitFrames"

InterfaceOptions_AddCategory(eufOptions)
eufOptions:Hide()

eufOptions:SetScript("OnShow", function(self)
	-- Draws the option panel elements.

	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

	title:SetPoint("TOPLEFT", self, 16, -16)
	title:SetText("EnhancedUnitFrames")

	local description = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallOutline")

	description:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	description:SetText("Placeholder")

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

	local i = 0

	local function createCheckbox(label, description)
		i = i + 1
		local checkbox = CreateFrame("CheckButton", "eufCheckbox" .. i, self, "InterfaceOptionsCheckButtonTemplate")
		checkbox.label = _G[checkbox:GetName() .. "Text"]

		checkbox.label:SetText(label)
		checkbox.tooltipText = label
		checkbox.tooltipRequirement = description

		return checkbox
	end

	-- Source: rothUI by zork.
	-- Slider creation function.

	local floor = floor
	local i = 0

	local createSlider = function(parent, title, minVal, maxVal, valStep, label, description)
		i = i + 1
		local slider = CreateFrame("Slider", "eufSlider" .. i, parent, "OptionsSliderTemplate")
		local editbox = CreateFrame("Editbox", "$parentEditbox", slider, "InputBoxTemplate")
		slider.text = _G[slider:GetName() .. "Text"]
		slider.textLow = _G[slider:GetName() .. "Low"]
		slider.textHigh = _G[slider:GetName() .. "High"]
		slider.tooltipText = label
		slider.tooltipRequirement = description

		slider:SetMinMaxValues(minVal, maxVal)
		slider:SetValue(minVal)
		slider:SetValueStep(valStep)
		slider:SetWidth(175)
		slider.text:SetText(title)
		slider.text:SetFontObject(GameFontNormal)
		slider.textLow:SetText(floor(minVal))
		slider.textHigh:SetText(floor(maxVal))
		editbox:SetSize(29,30)
		editbox:ClearAllPoints()
		editbox:SetPoint("TOP", slider, "BOTTOM", 0, -5)
		editbox:SetText(slider:GetValue())
		editbox:SetAutoFocus(false)

		slider:SetScript("OnValueChanged", function(self, value)
			self.editbox:SetText(floor(value))
		end)

		editbox:SetScript("OnTextChanged", function(self)
			local value = self:GetText()

			if tonumber(value) then
				if floor(self:GetParent():GetValue()) ~= floor(value) then
					self:GetParent():SetValue(floor(value))
				end
			end
		end)

		editbox:SetScript("OnEnterPressed", function(self)
			local value = self:GetText()

			if tonumber(value) then
				self:GetParent():SetValue(floor(value))
				self:ClearFocus()
			end
		end)

		slider.editbox = editbox

		return slider
	end

	-- Creates checkboxes.

	local bigPlayerHealthBar = createCheckbox("Big Player Health Bar", "Placeholder")
	local bigTargetHealthBar = createCheckbox("Big Target Health Bar", "Placeholder")
	local wideTargetFrame = createCheckbox("Wide Target Frame", "Placeholder")
	local mirroredPositioning = createCheckbox("Mirrored Positioning", "Placeholder")
	local classHealthBarColor = createCheckbox("Class Color HP", "Placeholder")
	local reactionHealthBarColor = createCheckbox("Reaction Color HP", "Placeholder")
	local classIconPortraits = createCheckbox("Class Icon Portraits", "Placeholder")
	local hideHitIndicators = createCheckbox("Hide Hit Indicators", "Placeholder")
	local hidePetStatusText = createCheckbox("Hide Pet Status Text", "Placeholder")
	local hideRestingIcon = createCheckbox("Hide Resting Icon", "Placeholder")
	local shamanClassColorFix = createCheckbox("Shaman Class Color Fix", "Placeholder")
	local upperCaseAbbreviation = createCheckbox("Uppercase Abbreviation", "Placeholder")

	-- Positions the checkboxes created.

	bigPlayerHealthBar:SetPoint("TOPLEFT", description, "BOTTOMLEFT", -2, -22)
	bigTargetHealthBar:SetPoint("TOPLEFT", bigPlayerHealthBar, "BOTTOMLEFT", 0, -8)
	wideTargetFrame:SetPoint("TOPLEFT", bigTargetHealthBar, "BOTTOMLEFT", 0, -8)
	mirroredPositioning:SetPoint("TOPLEFT", wideTargetFrame, "BOTTOMLEFT", 0, -8)
	classHealthBarColor:SetPoint("TOPLEFT", mirroredPositioning, "BOTTOMLEFT", 0, -8)
	reactionHealthBarColor:SetPoint("TOPLEFT", classHealthBarColor, "BOTTOMLEFT", 0, -8)
	classIconPortraits:SetPoint("TOPLEFT", reactionHealthBarColor, "BOTTOMLEFT", 0, -8)
	hideHitIndicators:SetPoint("TOPLEFT", classIconPortraits, "BOTTOMLEFT", 0, -8)
	hidePetStatusText:SetPoint("TOPLEFT", hideHitIndicators, "BOTTOMLEFT", 0, -8)
	hideRestingIcon:SetPoint("TOPLEFT", hidePetStatusText, "BOTTOMLEFT", 0, -8)
	shamanClassColorFix:SetPoint("TOPLEFT", hideRestingIcon, "BOTTOMLEFT", 0, -8)
	upperCaseAbbreviation:SetPoint("TOPLEFT", shamanClassColorFix, "BOTTOMLEFT", 0, -8)

	-- Applies scripts when the checkboxes are clicked.

	bigPlayerHealthBar:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.bigPlayerHealthBar = true
			PlaySound(856)
		else
			cfg.bigPlayerHealthBar = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	bigTargetHealthBar:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.bigTargetHealthBar = true
			PlaySound(856)
		else
			cfg.bigTargetHealthBar = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	wideTargetFrame:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.wideTargetFrame = true
			PlaySound(856)
		else
			cfg.wideTargetFrame = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	mirroredPositioning:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.mirroredPositioning = true
			PlaySound(856)
		else
			cfg.mirroredPositioning = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	classHealthBarColor:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.classHealthBarColor = true
			PlaySound(856)
		else
			cfg.classHealthBarColor = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	reactionHealthBarColor:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.reactionHealthBarColor = true
			PlaySound(856)
		else
			cfg.reactionHealthBarColor = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	classIconPortraits:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.classIconPortraits = true
			PlaySound(856)
		else
			cfg.classIconPortraits = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	hideHitIndicators:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.hideHitIndicators = true
			PlaySound(856)
		else
			cfg.hideHitIndicators = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	hidePetStatusText:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.hidePetStatusText = true
			PlaySound(856)
		else
			cfg.hidePetStatusText = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	hideRestingIcon:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.hideRestingIcon = true
			PlaySound(856)
		else
			cfg.hideRestingIcon = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	shamanClassColorFix:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.shamanClassColorFix = true
			PlaySound(856)
		else
			cfg.shamanClassColorFix = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	upperCaseAbbreviation:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.upperCaseAbbreviation = true
			PlaySound(856)
		else
			cfg.upperCaseAbbreviation = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	-- Player frame texture dropdown menu.

	local playerFrameDropdown = CreateFrame("Frame", "eufPlayerFrameDropdown", self, "UIDropDownMenuTemplate")
	playerFrameDropdown.title = playerFrameDropdown:CreateFontString("PlayerFrameDropdownLabel", "ARTWORK", "GameFontNormal")

	playerFrameDropdown:SetPoint("TOPLEFT", bigPlayerHealthBar, "BOTTOMLEFT", 273, 8)
	playerFrameDropdown.title:SetPoint("BOTTOMLEFT", playerFrameDropdown, "TOPLEFT", 15, 3)
	playerFrameDropdown.title:SetText("Player Frame Texure")

	playerFrameDropdown:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "anchor", 359, 1)
		GameTooltip:SetText("Player Frame Texture", nil, nil, nil, 1, 1)
		GameTooltip:AddLine("Placeholder", 1, 1, 1)
		GameTooltip:Show()
	end)

	playerFrameDropdown:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	UIDropDownMenu_SetWidth(playerFrameDropdown, 160)

	if cfg.elitePlayerFrame == true then
		isChecked = "Elite Player Frame"
		isCheckedElite = true
	elseif cfg.rarePlayerFrame == true then
		isChecked = "Rare Player Frame"
		isCheckedRare = true
	elseif cfg.rareElitePlayerFrame == true then
		isChecked = "Rare Elite Player Frame"
		isCheckedRareElite = true
	else
		isChecked = "Default Player Frame"
		isCheckedDefault = true
	end

	UIDropDownMenu_SetText(playerFrameDropdown, isChecked)

	local function PlayerFrameTextureDropdown_OnClick(self, arg1)
		if arg1 == 1 then
			cfg.elitePlayerFrame = false
			cfg.rarePlayerFrame = false
			cfg.rareElitePlayerFrame = false
			isChecked = "Default Player Frame"
			isCheckedDefault = true
			isCheckedElite = false
			isCheckedRare = false
			isCheckedRareElite = false

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameDropdown, isChecked)
		elseif arg1 == 2 then
			cfg.elitePlayerFrame = true
			cfg.rarePlayerFrame = false
			cfg.rareElitePlayerFrame = false
			isChecked = "Elite Player Frame"
			isCheckedDefault = false
			isCheckedElite = true
			isCheckedRare = false
			isCheckedRareElite = false

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameDropdown, isChecked)
		elseif arg1 == 3 then
			cfg.elitePlayerFrame = false
			cfg.rarePlayerFrame = true
			cfg.rareElitePlayerFrame = false
			isChecked = "Rare Player Frame"
			isCheckedDefault = false
			isCheckedElite = false
			isCheckedRare = true
			isCheckedRareElite = false

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameDropdown, isChecked)
		elseif arg1 == 4 then
			cfg.elitePlayerFrame = false
			cfg.rarePlayerFrame = false
			cfg.rareElitePlayerFrame = true
			isChecked = "Rare Elite Player Frame"
			isCheckedDefault = false
			isCheckedElite = false
			isCheckedRare = false
			isCheckedRareElite = true

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameDropdown, isChecked)
		end
	end

	local function PlayerFrameTextureDropdown_Menu(frame, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		info.func = PlayerFrameTextureDropdown_OnClick

		info.text, info.arg1, info.checked = "Default Player Frame", 1, isCheckedDefault
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Elite Player Frame", 2, isCheckedElite
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Rare Player Frame", 3, isCheckedRare
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Rare Elite Player Frame", 4, isCheckedRareElite
		UIDropDownMenu_AddButton(info)
	end

	UIDropDownMenu_Initialize(playerFrameDropdown, PlayerFrameTextureDropdown_Menu)

	-- Creates the target frame width slider.

	local wideTargetFrame = createSlider(self, "Target Width", 231, 400, 1, "Wide Target Frame Width", "Placeholder")

	wideTargetFrame:SetPoint("TOPLEFT", playerFrameDropdown, "BOTTOMLEFT", 18, -34)
	eufSlider1:SetValue(cfg.wideTargetFrameWidth)
	eufSlider1Editbox:SetText(cfg.wideTargetFrameWidth)

	wideTargetFrame:HookScript("OnValueChanged", function(self, value)
		value = floor(value)
		cfg.wideTargetFrameWidth = value

		StaticPopup_Show("RELOAD_UI")
	end)

	-- Creates the large aura icon size slider.

	local largeAuraIconSize = createSlider(self, "Large Aura", 17, 30, 1, "Large Aura Icon Size", "Placeholder")

	largeAuraIconSize:SetPoint("TOPLEFT", wideTargetFrame, "BOTTOMLEFT", 0, -70)
	eufSlider2:SetValue(cfg.largeAuraIconSize)
	eufSlider2Editbox:SetText(cfg.largeAuraIconSize)

	largeAuraIconSize:HookScript("OnValueChanged", function(self, value)
		value = floor(value)
		cfg.largeAuraIconSize = value

		StaticPopup_Show("RELOAD_UI")
	end)

	-- Creates the small aura icon size slider.

	local smallAuraIconSize = createSlider(self, "Small Aura", 17, 30, 1, "Small Aura Icon Size", "Placeholder")

	smallAuraIconSize:SetPoint("TOPLEFT", largeAuraIconSize, "BOTTOMLEFT", 0, -70)
	eufSlider3:SetValue(cfg.smallAuraIconSize)
	eufSlider3Editbox:SetText(cfg.smallAuraIconSize)

	smallAuraIconSize:HookScript("OnValueChanged", function(self, value)
		value = floor(value)
		cfg.smallAuraIconSize = value

		StaticPopup_Show("RELOAD_UI")
	end)

	-- Initializes the options panel with saved variables.

	if cfg.bigPlayerHealthBar == true then
		eufCheckbox1:SetChecked(true)
	end

	if cfg.bigTargetHealthBar == true then
		eufCheckbox2:SetChecked(true)
	end

	if cfg.wideTargetFrame == true then
		eufCheckbox3:SetChecked(true)
	end

	if cfg.mirroredPositioning == true then
		eufCheckbox4:SetChecked(true)
	end

	if cfg.classHealthBarColor == true then
		eufCheckbox5:SetChecked(true)
	end

	if cfg.reactionHealthBarColor == true then
		eufCheckbox6:SetChecked(true)
	end

	if cfg.classIconPortraits == true then
		eufCheckbox7:SetChecked(true)
	end

	if cfg.hideHitIndicators == true then
		eufCheckbox8:SetChecked(true)
	end

	if cfg.hidePetStatusText == true then
		eufCheckbox9:SetChecked(true)
	end

	if cfg.hideRestingIcon == true then
		eufCheckbox10:SetChecked(true)
	end

	if cfg.shamanClassColorFix == true then
		eufCheckbox11:SetChecked(true)
	end

	if cfg.upperCaseAbbreviation == true then
		eufCheckbox12:SetChecked(true)
	end

	self:SetScript("OnShow", nil)
end)
