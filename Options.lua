-- Creates the options panel.

eufOptions = CreateFrame("Frame", "eufOptionsPanel", UIParent)
eufOptions.healthBars = CreateFrame("Frame", "eufOptionsHealthBars", eufOptions)
eufOptions.scaling = CreateFrame("Frame", "eufOptionsPanelScaling", eufOptions)
eufOptions.name = "EnhancedUnitFrames"
eufOptions.healthBars.name = "Health Bars"
eufOptions.scaling.name = "Frame Scaling"
eufOptions.healthBars.parent = eufOptions.name
eufOptions.scaling.parent = eufOptions.name

InterfaceOptions_AddCategory(eufOptions)
InterfaceOptions_AddCategory(eufOptions.healthBars)
InterfaceOptions_AddCategory(eufOptions.scaling)
eufOptions:Hide()
eufOptions.healthBars:Hide()
eufOptions.scaling:Hide()

-- Static ReloadUI popup.

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

local function createCheckbox(name, parent, label, description)
	local checkbox = CreateFrame("CheckButton", name .. "Checkbox", parent, "InterfaceOptionsCheckButtonTemplate")
	checkbox.label = _G[checkbox:GetName() .. "Text"]

	checkbox.label:SetText(label)
	checkbox.tooltipText = label
	checkbox.tooltipRequirement = description

	return checkbox
end

-- Source: rothUI by zork.
-- Slider creation functions.

local floor = floor

local function round(number, decimals)
	local multiplier = 10^(decimals or 0)

	return math.floor(number * multiplier + 0.5) / multiplier
end

local createSlider = function(name, parent, title, minVal, maxVal, valStep, label, description)
	local slider = CreateFrame("Slider", name .. "Slider", parent, "OptionsSliderTemplate")
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
	slider.textLow:SetText(minVal)
	slider.textHigh:SetText(maxVal)
	editbox:SetSize(29, 30)
	editbox:ClearAllPoints()
	editbox:SetPoint("TOP", slider, "BOTTOM", 0, -5)
	editbox:SetText(slider:GetValue())
	editbox:SetAutoFocus(false)

	slider:HookScript("OnMouseUp", function(self, value)
		StaticPopup_Show("RELOAD_UI")
	end)

	slider:SetScript("OnValueChanged", function(self, value)
		self.editbox:SetText(floor(value))
	end)

	editbox:SetScript("OnEnterPressed", function(self)
		local value = self:GetText()

		if tonumber(value) then
			self:GetParent():SetValue(floor(value))
			self:ClearFocus()
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	slider.editbox = editbox

	return slider
end

local createScaleSlider = function(name, parent, title, minVal, maxVal, valStep, label, description)
	local slider = CreateFrame("Slider", name .. "Slider", parent, "OptionsSliderTemplate")
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
	slider.textLow:SetText(minVal)
	slider.textHigh:SetText(maxVal)
	editbox:SetSize(30, 30)
	editbox:ClearAllPoints()
	editbox:SetPoint("TOP", slider, "BOTTOM", 0, -5)
	editbox:SetText(slider:GetValue())
	editbox:SetAutoFocus(false)

	slider:SetScript("OnValueChanged", function(self, value)
		self.editbox:SetText(round(value, 2))
	end)

	editbox:SetScript("OnEnterPressed", function(self)
		local value = self:GetText()

		if tonumber(value) then
			self:GetParent():SetValue(round(value, 2))
			self:ClearFocus()
		end
	end)

	slider.editbox = editbox

	return slider
end

-- Draws the option panel elements.

eufOptions:SetScript("OnShow", function(self)
	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

	title:SetPoint("TOPLEFT", self, 16, -16)
	title:SetText("EnhancedUnitFrames")

	local description = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallOutline")

	description:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	description:SetText("Modifies the default unit frames for better visuals.")

	-- Creates checkboxes.

	if isClassic() then
		wideTargetFrame = createCheckbox("wideTargetFrame", self, "Wide Target Frame", "Makes the target frame wider.\nSource: Wide Target by Gello.")
	else
		wideTargetFrame = createCheckbox("wideTargetFrame", self, "Wide Target Frame", "Makes the target and focus frames wider.\nSource: Wide Target by Gello.")
	end

	local mirroredPositioning = createCheckbox("mirroredPositioning", self, "Mirrored Positioning", "Allows the easy mirrored positioning of the player and target frames.\n1. Right-click the player frame.\n2. Hover over \"Move Frame\".\n3. Select \"Unlock Frame\" to begin.\nSource: Focused by haggen.")
	local upperCaseAbbreviation = createCheckbox("upperCaseAbbreviation", self, "Uppercase Abbreviation", "Changes whether long status text numbers are abbreviated with a capital letter at the end or not.")
	local classIconPortraits = createCheckbox("classIconPortraits", self, "Class Icon Portraits", "Changes the unit frame portraits to the unit's class icon.")
	local hideHitIndicators = createCheckbox("hideHitIndicators", self, "Hide Hit Indicators", "Hides the damage/healing spam on player and pet frames.")
	local hidePetStatusText = createCheckbox("hidePetStatusText", self, "Hide Pet Status Text", "Hides the pet frame status bar text.")
	local hideRestingIcon = createCheckbox("hideRestingIcon", self, "Hide Resting Icon", "Hides the resting icon on the player frame.")

	if isClassic() then
		shamanClassColorFix = createCheckbox("shamanClassColorFix", self, "Shaman Class Color Fix", "Changes the Shaman class color to reflect live.")
	else
		threatShowNumeric = createCheckbox("threatShowNumeric", self, "Show Numeric Threat", "Shows a numerical target threat indicator on the player frame.\nRequires \"Threat Warning\" to be enabled to display.")
	end

	-- Positions the checkboxes created.

	wideTargetFrame:SetPoint("TOPLEFT", description, "BOTTOMLEFT", -2, -22)
	mirroredPositioning:SetPoint("TOPLEFT", wideTargetFrame, "BOTTOMLEFT", 0, -8)
	upperCaseAbbreviation:SetPoint("TOPLEFT", mirroredPositioning, "BOTTOMLEFT", 0, -8)
	classIconPortraits:SetPoint("TOPLEFT", upperCaseAbbreviation, "BOTTOMLEFT", 0, -8)
	hideHitIndicators:SetPoint("TOPLEFT", classIconPortraits, "BOTTOMLEFT", 0, -8)
	hidePetStatusText:SetPoint("TOPLEFT", hideHitIndicators, "BOTTOMLEFT", 0, -8)
	hideRestingIcon:SetPoint("TOPLEFT", hidePetStatusText, "BOTTOMLEFT", 0, -8)

	if isClassic() then
		shamanClassColorFix:SetPoint("TOPLEFT", hideRestingIcon, "BOTTOMLEFT", 0, -8)
	else
		threatShowNumeric:SetPoint("TOPLEFT", hideRestingIcon, "BOTTOMLEFT", 0, -8)
	end

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

	if isClassic() then
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
	else
		threatShowNumeric:SetScript("OnClick", function(self)
			if self:GetChecked() then
				C_CVar.SetCVar("threatShowNumeric", 1)
				PlaySound(856)
			else
				C_CVar.SetCVar("threatShowNumeric", 0)
				PlaySound(857)
			end
		end)
	end

	-- Player frame texture dropdown menu.

	local playerFrameDropdown = CreateFrame("Frame", "eufPlayerFrameDropdown", self, "UIDropDownMenuTemplate")
	playerFrameDropdown.title = playerFrameDropdown:CreateFontString("PlayerFrameDropdownLabel", "ARTWORK", "GameFontNormal")

	playerFrameDropdown:SetPoint("TOPLEFT", wideTargetFrame, "BOTTOMLEFT", 273, 8)
	playerFrameDropdown.title:SetPoint("BOTTOMLEFT", playerFrameDropdown, "TOPLEFT", 15, 3)
	playerFrameDropdown.title:SetText("Player Frame Texure")

	playerFrameDropdown:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -17, 1)
		GameTooltip:SetText("Player Frame Texture", nil, nil, nil, 1, true)
		GameTooltip:AddLine("Changes the player frame to use the default, elite, rare, or rare-elite texture.", 1, 1, 1, 1)
		GameTooltip:Show()
	end)

	playerFrameDropdown:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	UIDropDownMenu_SetWidth(playerFrameDropdown, 160)

	if cfg.elitePlayerFrame == true then
		isChecked1 = "Elite Player Frame"
		isCheckedElite = true
	elseif cfg.rarePlayerFrame == true then
		isChecked1 = "Rare Player Frame"
		isCheckedRare = true
	elseif cfg.rareElitePlayerFrame == true then
		isChecked1 = "Rare Elite Player Frame"
		isCheckedRareElite = true
	else
		isChecked1 = "Default Player Frame"
		isCheckedDefault = true
	end

	UIDropDownMenu_SetText(playerFrameDropdown, isChecked1)

	local function PlayerFrameTextureDropdown_OnClick(self, arg1)
		if arg1 == 1 then
			isChecked1 = "Elite Player Frame"
			isCheckedElite = true
			isCheckedRare = false
			isCheckedRareElite = false
			isCheckedDefault = false

			cfg.elitePlayerFrame = true
			cfg.rarePlayerFrame = false
			cfg.rareElitePlayerFrame = false

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameDropdown, isChecked1)
		elseif arg1 == 2 then
			isChecked1 = "Rare Player Frame"
			isCheckedElite = false
			isCheckedRare = true
			isCheckedRareElite = false
			isCheckedDefault = false

			cfg.elitePlayerFrame = false
			cfg.rarePlayerFrame = true
			cfg.rareElitePlayerFrame = false

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameDropdown, isChecked1)
		elseif arg1 == 3 then
			isChecked1 = "Rare Elite Player Frame"
			isCheckedElite = false
			isCheckedRare = false
			isCheckedRareElite = true
			isCheckedDefault = false

			cfg.elitePlayerFrame = false
			cfg.rarePlayerFrame = false
			cfg.rareElitePlayerFrame = true

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameDropdown, isChecked1)
		elseif arg1 == 4 then
			isChecked1 = "Default Player Frame"
			isCheckedElite = false
			isCheckedRare = false
			isCheckedRareElite = false
			isCheckedDefault = true

			cfg.elitePlayerFrame = false
			cfg.rarePlayerFrame = false
			cfg.rareElitePlayerFrame = false

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameDropdown, isChecked1)
		end
	end

	local function PlayerFrameTextureDropdown_Menu(frame, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		info.func = PlayerFrameTextureDropdown_OnClick

		info.text, info.arg1, info.checked = "Elite Player Frame", 1, isCheckedElite
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Rare Player Frame", 2, isCheckedRare
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Rare Elite Player Frame", 3, isCheckedRareElite
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Default Player Frame", 4, isCheckedDefault
		UIDropDownMenu_AddButton(info)
	end

	UIDropDownMenu_Initialize(playerFrameDropdown, PlayerFrameTextureDropdown_Menu)

	-- Status text dropdown menu.

	local statusTextDropdown = CreateFrame("Frame", "eufStatusTextDropdown", self, "UIDropDownMenuTemplate")
	statusTextDropdown.title = statusTextDropdown:CreateFontString("StatusTextDropdownLabel", "ARTWORK", "GameFontNormal")

	statusTextDropdown:SetPoint("TOPLEFT", playerFrameDropdown, "BOTTOMLEFT", 0, -37)
	statusTextDropdown.title:SetPoint("BOTTOMLEFT", statusTextDropdown, "TOPLEFT", 15, 3)
	statusTextDropdown.title:SetText("Status Text")

	statusTextDropdown:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -17, 1)
		GameTooltip:SetText("Status Text", nil, nil, nil, 1, true)
		GameTooltip:AddLine("Display status text as numbers, percentage, or both.", 1, 1, 1, 1)
		GameTooltip:Show()
	end)

	statusTextDropdown:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	UIDropDownMenu_SetWidth(statusTextDropdown, 160)

	if C_CVar.GetCVar("statusTextDisplay") == "NUMERIC" then
		isChecked3 = "Numeric Value"
		isCheckedNumericValue = true
	elseif C_CVar.GetCVar("statusTextDisplay") == "PERCENT" then
		isChecked3 = "Percentage"
		isCheckedPercentage = true
	elseif C_CVar.GetCVar("statusTextDisplay") == "BOTH" then
		isChecked3 = "Both"
		isCheckedBoth = true
	elseif C_CVar.GetCVar("statusTextDisplay") == "NONE" then
		isChecked3 = "None"
		isCheckedNone = true
	end

	UIDropDownMenu_SetText(statusTextDropdown, isChecked3)

	local function StatusTextDropdown_OnClick(self, arg1)
		if arg1 == 1 then
			isChecked2 = "Numeric Value"
			isCheckedNumericValue = true
			isCheckedPercentage = false
			isCheckedBoth = false
			isCheckedNone = false

			C_CVar.SetCVar("statusText", 1)
			C_CVar.SetCVar("statusTextDisplay", "NUMERIC")
			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(statusTextDropdown, isChecked2)
		elseif arg1 == 2 then
			isChecked2 = "Percentage"
			isCheckedNumericValue = false
			isCheckedPercentage = true
			isCheckedBoth = false
			isCheckedNone = false

			C_CVar.SetCVar("statusText", 1)
			C_CVar.SetCVar("statusTextDisplay", "PERCENT")
			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(statusTextDropdown, isChecked2)
		elseif arg1 == 3 then
			isChecked2 = "Both"
			isCheckedNumericValue = false
			isCheckedPercentage = false
			isCheckedBoth = true
			isCheckedNone = false

			C_CVar.SetCVar("statusText", 1)
			C_CVar.SetCVar("statusTextDisplay", "BOTH")
			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(statusTextDropdown, isChecked2)
		elseif arg1 == 4 then
			isChecked2 = "None"
			isCheckedNumericValue = false
			isCheckedPercentage = false
			isCheckedBoth = false
			isCheckedNone = true

			C_CVar.SetCVar("statusText", 0)
			C_CVar.SetCVar("statusTextDisplay", "NONE")
			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(statusTextDropdown, isChecked2)
		end
	end

	local function StatusTextDropdown_Menu(frame, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		info.func = StatusTextDropdown_OnClick

		info.text, info.arg1, info.checked = "Numeric Value", 1, isCheckedNumericValue
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Percentage", 2, isCheckedPercentage
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Both", 3, isCheckedBoth
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "None", 4, isCheckedNone
		UIDropDownMenu_AddButton(info)
	end

	UIDropDownMenu_Initialize(statusTextDropdown, StatusTextDropdown_Menu)

	-- Threat warning dropdown menu.

	if not isClassic() then
		threatWarningDropdown = CreateFrame("Frame", "eufThreatWarningDropdown", self, "UIDropDownMenuTemplate")
		threatWarningDropdown.title = threatWarningDropdown:CreateFontString("ThreatWarningDropdownLabel", "ARTWORK", "GameFontNormal")

		threatWarningDropdown:SetPoint("TOPLEFT", statusTextDropdown, "BOTTOMLEFT", 0, -37)
		threatWarningDropdown.title:SetPoint("BOTTOMLEFT", threatWarningDropdown, "TOPLEFT", 15, 3)
		threatWarningDropdown.title:SetText("Threat Warning")

		threatWarningDropdown:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -17, 1)
			GameTooltip:SetText("Threat Warning", nil, nil, nil, 1, true)
			GameTooltip:AddLine("Displays a red glow around the unit frames if you have threat.", 1, 1, 1, 1)
			GameTooltip:Show()
		end)

		threatWarningDropdown:SetScript("OnLeave", function(self)
			GameTooltip:Hide()
		end)

		UIDropDownMenu_SetWidth(threatWarningDropdown, 160)

		if C_CVar.GetCVar("threatWarning") == "0" then
			isChecked2 = "Off"
			isCheckedOff = true
		elseif C_CVar.GetCVar("threatWarning") == "1" then
			isChecked2 = "In Dungeons"
			isCheckedInDungeons = true
		elseif C_CVar.GetCVar("threatWarning") == "2" then
			isChecked2 = "In Party/Raid"
			isCheckedPartyRaid = true
		elseif C_CVar.GetCVar("threatWarning") == "3" then
			isChecked2 = "Always"
			isCheckedAlways = true
		end

		UIDropDownMenu_SetText(threatWarningDropdown, isChecked2)

		local function ThreatWarningDropdown_OnClick(self, arg1)
			if arg1 == 1 then
				C_CVar.SetCVar("threatWarning", 1)
				isChecked2 = "In Dungeons"
				isCheckedOff = false
				isCheckedInDungeons = true
				isCheckedPartyRaid = false
				isCheckedAlways = false

				UIDropDownMenu_SetText(threatWarningDropdown, isChecked2)
			elseif arg1 == 2 then
				C_CVar.SetCVar("threatWarning", 2)
				isChecked2 = "In Party/Raid"
				isCheckedOff = false
				isCheckedInDungeons = false
				isCheckedPartyRaid = true
				isCheckedAlways = false

				UIDropDownMenu_SetText(threatWarningDropdown, isChecked2)
			elseif arg1 == 3 then
				C_CVar.SetCVar("threatWarning", 3)
				isChecked2 = "Always"
				isCheckedOff = false
				isCheckedInDungeons = false
				isCheckedPartyRaid = false
				isCheckedAlways = true

				UIDropDownMenu_SetText(threatWarningDropdown, isChecked2)
			elseif arg1 == 4 then
				C_CVar.SetCVar("threatWarning", 0)
				isChecked2 = "Off"
				isCheckedOff = true
				isCheckedInDungeons = false
				isCheckedPartyRaid = false
				isCheckedAlways = false

				UIDropDownMenu_SetText(threatWarningDropdown, isChecked2)
			end
		end

		local function ThreatWarningDropdown_Menu(frame, level, menuList)
			local info = UIDropDownMenu_CreateInfo()
			info.func = ThreatWarningDropdown_OnClick

			info.text, info.arg1, info.checked = "In Dungeons", 1, isCheckedInDungeons
			UIDropDownMenu_AddButton(info)
			info.text, info.arg1, info.checked = "In Party/Raid", 2, isCheckedPartyRaid
			UIDropDownMenu_AddButton(info)
			info.text, info.arg1, info.checked = "Always", 3, isCheckedAlways
			UIDropDownMenu_AddButton(info)
			info.text, info.arg1, info.checked = "Off", 4, isCheckedOff
			UIDropDownMenu_AddButton(info)
		end

		UIDropDownMenu_Initialize(threatWarningDropdown, ThreatWarningDropdown_Menu)
	end

	-- Initializes the options panel with saved variables.

	if cfg.wideTargetFrame == true then
		wideTargetFrameCheckbox:SetChecked(true)
	end

	if cfg.mirroredPositioning == true then
		mirroredPositioningCheckbox:SetChecked(true)
	end

	if cfg.upperCaseAbbreviation == true then
		upperCaseAbbreviationCheckbox:SetChecked(true)
	end

	if cfg.classIconPortraits == true then
		classIconPortraitsCheckbox:SetChecked(true)
	end

	if cfg.hideHitIndicators == true then
		hideHitIndicatorsCheckbox:SetChecked(true)
	end

	if cfg.hidePetStatusText == true then
		hidePetStatusTextCheckbox:SetChecked(true)
	end

	if cfg.hideRestingIcon == true then
		hideRestingIconCheckbox:SetChecked(true)
	end

	if isClassic() then
		if cfg.shamanClassColorFix == true then
			shamanClassColorFixCheckbox:SetChecked(true)
		end
	else
		if C_CVar.GetCVar("threatShowNumeric") == "1" then
			threatShowNumericCheckbox:SetChecked(true)
		end
	end

	self:SetScript("OnShow", nil)
end)

-- Draws the health bar option panel elements.

eufOptions.healthBars:SetScript("OnShow", function(self)
	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

	title:SetPoint("TOPLEFT", self, 16, -16)
	title:SetText("EnhancedUnitFrames")

	local description = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallOutline")

	description:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	description:SetText("Modifies the default unit frames for better visuals.")

	-- Creates checkboxes.

	local bigPlayerHealthBar = createCheckbox("bigPlayerHealthBar", self, "Big Player Health Bar", "Makes the health bar bigger using unimplemented textures made by Blizzard, hidden in the game files.")
	local bigTargetHealthBar = createCheckbox("bigTargetHealthBar", self, "Big Target Health Bar", "Makes the health bar bigger using unimplemented textures made by Blizzard, hidden in the game files.")
	local classHealthBarColor = createCheckbox("classHealthBarColor", self, "Class Color HP", "Changes the unit frame health bar colors to the unit's class color.")
	local reactionHealthBarColor = createCheckbox("reactionHealthBarColor", self, "Reaction Color HP", "Changes the unit frame health bar colors to the unit's reaction color.")
	local hidePowerAnimation = createCheckbox("hidePowerAnimation", self, "Hide Power Animations", "Hides the animation when the resource bar is full.")
	
	if not isClassic() then
		predictedHealth = createCheckbox("predictedHealth", self, "Show Predicted Health", "Shows an animation when you lose health.")
		showBuilderFeedback = createCheckbox("showBuilderFeedback", self, "Show Builder Feedback", "Shows an animation when you build your class resource.")
		showSpenderFeedback = createCheckbox("showSpenderFeedback", self, "Show Spender Feedback", "Shows an animation when you spend your class resource.")
	end

	-- Positions the checkboxes created.

	bigPlayerHealthBar:SetPoint("TOPLEFT", description, "BOTTOMLEFT", -2, -22)
	bigTargetHealthBar:SetPoint("TOPLEFT", bigPlayerHealthBar, "BOTTOMLEFT", 0, -8)
	classHealthBarColor:SetPoint("TOPLEFT", bigTargetHealthBar, "BOTTOMLEFT", 0, -8)
	reactionHealthBarColor:SetPoint("TOPLEFT", classHealthBarColor, "BOTTOMLEFT", 0, -8)
	hidePowerAnimation:SetPoint("TOPLEFT", reactionHealthBarColor, "BOTTOMLEFT", 0, -8)

	if not isClassic() then
		predictedHealth:SetPoint("TOPLEFT", hidePowerAnimation, "BOTTOMLEFT", 0, -8)
		showBuilderFeedback:SetPoint("TOPLEFT", predictedHealth, "BOTTOMLEFT", 0, -8)
		showSpenderFeedback:SetPoint("TOPLEFT", showBuilderFeedback, "BOTTOMLEFT", 0, -8)
	end

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

	hidePowerAnimation:SetScript("OnClick", function(self)
		if self:GetChecked() then
			cfg.hidePowerAnimation = true
			PlaySound(856)
		else
			cfg.hidePowerAnimation = false
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	if not isClassic() then
		predictedHealth:SetScript("OnClick", function(self)
			if self:GetChecked() then
				C_CVar.SetCVar("predictedHealth", 1)
				PlaySound(856)
			else
				C_CVar.SetCVar("predictedHealth", 0)
				PlaySound(857)
			end
		end)

		showBuilderFeedback:SetScript("OnClick", function(self)
			if self:GetChecked() then
				C_CVar.SetCVar("showBuilderFeedback", 1)
				PlaySound(856)
			else
				C_CVar.SetCVar("showBuilderFeedback", 0)
				PlaySound(857)
			end
		end)

		showSpenderFeedback:SetScript("OnClick", function(self)
			if self:GetChecked() then
				C_CVar.SetCVar("showSpenderFeedback", 1)
				PlaySound(856)
			else
				C_CVar.SetCVar("showSpenderFeedback", 0)
				PlaySound(857)
			end
		end)
	end

	-- Initializes the options panel with saved variables.

	if cfg.bigPlayerHealthBar == true then
		bigPlayerHealthBarCheckbox:SetChecked(true)
	end

	if cfg.bigTargetHealthBar == true then
		bigTargetHealthBarCheckbox:SetChecked(true)
	end

	if cfg.classHealthBarColor == true then
		classHealthBarColorCheckbox:SetChecked(true)
	end

	if cfg.reactionHealthBarColor == true then
		reactionHealthBarColorCheckbox:SetChecked(true)
	end

	if cfg.hidePowerAnimation == true then
		hidePowerAnimationCheckbox:SetChecked(true)
	end

	if not isClassic() then
		if C_CVar.GetCVar("predictedHealth") == "1" then
			predictedHealthCheckbox:SetChecked(true)
		end

		if C_CVar.GetCVar("showBuilderFeedback") == "1" then
			showBuilderFeedbackCheckbox:SetChecked(true)
		end

		if C_CVar.GetCVar("showSpenderFeedback") == "1" then
			showSpenderFeedbackCheckbox:SetChecked(true)
		end
	end

	self:SetScript("OnShow", nil)
end)

-- Draws the scaling option panel elements.

eufOptions.scaling:SetScript("OnShow", function(self)
	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

	title:SetPoint("TOPLEFT", self, 16, -16)
	title:SetText("EnhancedUnitFrames")

	local description = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallOutline")

	description:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	description:SetText("Modifies the default unit frames for better visuals.")

	-- Creates the target frame width slider.

	if isClassic() then
		wideTargetFrame = createSlider("wideTargetFrame", self, "Target Width", 231, 400, 1, "Wide Target Frame Width", "Changes the target frame width.\nRequires \"Wide Target Frame\" to be checked for changes to take effect.")
		wideTargetFrame:SetPoint("TOPLEFT", description, "BOTTOMLEFT", 1, -36)
	else
		wideTargetFrame = createSlider("wideTargetFrame", self, "Target Width", 231, 400, 1, "Wide Target Frame Width", "Changes the target and focus frame width.\nRequires \"Wide Target Frame\" to be checked for changes to take effect.")
		wideTargetFrame:SetPoint("TOPLEFT", description, "BOTTOMLEFT", 1, -36)
	end

	wideTargetFrameSlider:SetValue(cfg.wideTargetFrameWidth)
	wideTargetFrameSliderEditbox:SetText(cfg.wideTargetFrameWidth)

	wideTargetFrame:HookScript("OnValueChanged", function(self, value)
		value = floor(value)
		cfg.wideTargetFrameWidth = value
	end)

	if isClassic() then
		-- Creates the aura icon size slider.

		auraIconSize = createSlider("auraIconSize", self, "Aura Size", 17, 30, 1, "Aura Icon Size", "Changes the aura icon size on the target frame.")

		auraIconSize:SetPoint("TOPLEFT", wideTargetFrame, "BOTTOMLEFT", 0, -70)
		auraIconSizeSlider:SetValue(cfg.largeAuraIconSize)
		auraIconSizeSliderEditbox:SetText(cfg.largeAuraIconSize)

		auraIconSize:HookScript("OnValueChanged", function(self, value)
			value = floor(value)
			cfg.largeAuraIconSize = value
		end)
	else
		-- Creates the large aura icon size slider.

		largeAuraIconSize = createSlider("largeAuraIconSize", self, "Large Aura", 17, 30, 1, "Large Aura Icon Size", "Changes the large aura icon size on the target and focus frames.")

		largeAuraIconSize:SetPoint("TOPLEFT", wideTargetFrame, "BOTTOMLEFT", 0, -70)
		largeAuraIconSizeSlider:SetValue(cfg.largeAuraIconSize)
		largeAuraIconSizeSliderEditbox:SetText(cfg.largeAuraIconSize)

		largeAuraIconSize:HookScript("OnValueChanged", function(self, value)
			value = floor(value)
			cfg.largeAuraIconSize = value
		end)

		-- Creates the small aura icon size slider.

		smallAuraIconSize = createSlider("smallAuraIconSize", self, "Small Aura", 17, 30, 1, "Small Aura Icon Size", "Changes the small aura icon size on the target and focus frames.")

		smallAuraIconSize:SetPoint("TOPLEFT", largeAuraIconSize, "BOTTOMLEFT", 0, -70)
		smallAuraIconSizeSlider:SetValue(cfg.smallAuraIconSize)
		smallAuraIconSizeSliderEditbox:SetText(cfg.smallAuraIconSize)

		smallAuraIconSize:HookScript("OnValueChanged", function(self, value)
			value = floor(value)
			cfg.smallAuraIconSize = value
		end)
	end

	-- Creates the player frame scale slider.

	playerFrameScale = createScaleSlider("playerFrameScale", self, "Player Scale", 1, 1.5, 0.01, "Player Frame Scale", "Changes the scale of the player frame.")

	if isClassic() then
		playerFrameScale:SetPoint("TOPLEFT", auraIconSize, "BOTTOMLEFT", 0, -70)
	else
		playerFrameScale:SetPoint("TOPLEFT", smallAuraIconSize, "BOTTOMLEFT", 0, -70)
	end

	playerFrameScale:HookScript("OnValueChanged", function(self, value)
		PlayerFrame:SetScale(round(value, 2))
	end)

	self:SetScript("OnShow", nil)

	-- Creates the target frame scale slider.

	local targetFrameScale = createScaleSlider("targetFrameScale", self, "Target Scale", 1, 1.5, 0.01, "Target Frame Scale", "Changes the scale of the target frame.")

	targetFrameScale:SetPoint("TOPLEFT", playerFrameScale, "BOTTOMLEFT", 0, -70)

	targetFrameScale:HookScript("OnValueChanged", function(self, value)
		TargetFrame:SetScale(round(value, 2))
	end)

	self:SetScript("OnShow", nil)
end)