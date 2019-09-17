-- Creates the options panel.

eufOptions = CreateFrame("Frame", "eufOptionsPanel", UIParent)
eufOptions.general = CreateFrame("Frame", "eufOptionsGeneral", eufOptions)
eufOptions.healthBars = CreateFrame("Frame", "eufOptionsHealthBars", eufOptions)
eufOptions.scaling = CreateFrame("Frame", "eufOptionsPanelScaling", eufOptions)
eufOptions.name = "EnhancedUnitFrames"
eufOptions.general.name = "General"
eufOptions.healthBars.name = "Health Bars"
eufOptions.scaling.name = "Frame Scaling"
eufOptions.general.parent = eufOptions.name
eufOptions.healthBars.parent = eufOptions.name
eufOptions.scaling.parent = eufOptions.name

InterfaceOptions_AddCategory(eufOptions)
InterfaceOptions_AddCategory(eufOptions.general)
InterfaceOptions_AddCategory(eufOptions.healthBars)
InterfaceOptions_AddCategory(eufOptions.scaling)
eufOptions:Hide()
eufOptions.general:Hide()
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
	InterfaceOptionsFrame_OpenToCategory(eufOptions.general)
end)

-- Draws the option panel elements.

eufOptions.general:SetScript("OnShow", function(self)
	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

	title:SetPoint("TOPLEFT", self, 16, -16)
	title:SetText("EnhancedUnitFrames")

	local description = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallOutline")

	description:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	description:SetText("Modifies the default unit frames for better visuals.")

	-- Creates checkboxes.

	characterConfiguration = createCheckbox("characterConfiguration", self, "Per-Character Configuration", "If enabled, this character's configuration will not affect the global configuration.")

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

	characterConfiguration:SetPoint("RIGHT", title, 50, 0)
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

	characterConfiguration:SetScript("OnClick", function(self)
		if self:GetChecked() then
			eufCfgCharacter.enabled = true

			PlaySound(856)
		else
			eufCfgCharacter.enabled = false

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	wideTargetFrame:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCfgCharacter.enabled then
				eufCfgCharacter.wideTargetFrame = true
			else
				eufCfg.wideTargetFrame = false
			end

			PlaySound(856)
		else
			if eufCfgCharacter.enabled then
				eufCfgCharacter.wideTargetFrame = false
			else
				eufCfg.wideTargetFrame = false
			end
			
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	mirroredPositioning:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCfgCharacter.enabled then
				eufCfgCharacter.mirroredPositioning = true
			else
				eufCfg.mirroredPositioning = true
			end

			PlaySound(856)
		else
			if eufCfgCharacter.enabled then
				eufCfgCharacter.mirroredPositioning = false
			else
				eufCfg.mirroredPositioning = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	upperCaseAbbreviation:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCfgCharacter.enabled then
				eufCfgCharacter.upperCaseAbbreviation = true
			else
				eufCfg.upperCaseAbbreviation = true
			end

			PlaySound(856)
		else
			if eufCfgCharacter.enabled then
				eufCfgCharacter.upperCaseAbbreviation = false
			else
				eufCfg.upperCaseAbbreviation = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	classIconPortraits:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCfgCharacter.enabled then
				eufCfgCharacter.classIconPortraits = true
			else
				eufCfg.classIconPortraits = true
			end

			PlaySound(856)
		else
			if eufCfgCharacter.enabled then
				eufCfgCharacter.classIconPortraits = false
			else
				eufCfg.classIconPortraits = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	hideHitIndicators:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCfgCharacter.enabled then
				eufCfgCharacter.hideHitIndicators = true
			else
				eufCfg.hideHitIndicators = true
			end

			PlaySound(856)
		else
			if eufCfgCharacter.enabled then
				eufCfgCharacter.hideHitIndicators = false
			else
				eufCfg.hideHitIndicators = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	hidePetStatusText:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCfgCharacter.enabled then
				eufCfgCharacter.hidePetStatusText = true
			else
				eufCfg.hidePetStatusText = true
			end

			PlaySound(856)
		else
			if eufCfgCharacter.enabled then
				eufCfgCharacter.hidePetStatusText = false
			else
				eufCfg.hidePetStatusText = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	hideRestingIcon:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCfgCharacter.enabled then
				eufCfgCharacter.hideRestingIcon = true
			else
				eufCfg.hideRestingIcon = true
			end

			PlaySound(856)
		else
			if eufCfgCharacter.enabled then
				eufCfgCharacter.hideRestingIcon = false
			else
				eufCfg.hideRestingIcon = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	if isClassic() then
		shamanClassColorFix:SetScript("OnClick", function(self)
			if self:GetChecked() then
				if eufCfgCharacter.enabled then
					eufCfgCharacter.shamanClassColorFix = true
				else
					eufCfg.shamanClassColorFix = true
				end

				PlaySound(856)
			else
				if eufCfgCharacter.enabled then
					eufCfgCharacter.shamanClassColorFix = false
				else
					eufCfg.shamanClassColorFix = false
				end

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

	if eufCfgCharacter.enabled then
		if eufCfgCharacter.elitePlayerFrame == true then
			isChecked1 = "Elite Player Frame"
			isCheckedElite = true
		elseif eufCfgCharacter.rarePlayerFrame == true then
			isChecked1 = "Rare Player Frame"
			isCheckedRare = true
		elseif eufCfgCharacter.rareElitePlayerFrame == true then
			isChecked1 = "Rare Elite Player Frame"
			isCheckedRareElite = true
		else
			isChecked1 = "Default Player Frame"
			isCheckedDefault = true
		end
	else
		if eufCfg.elitePlayerFrame == true then
			isChecked1 = "Elite Player Frame"
			isCheckedElite = true
		elseif eufCfg.rarePlayerFrame == true then
			isChecked1 = "Rare Player Frame"
			isCheckedRare = true
		elseif eufCfg.rareElitePlayerFrame == true then
			isChecked1 = "Rare Elite Player Frame"
			isCheckedRareElite = true
		else
			isChecked1 = "Default Player Frame"
			isCheckedDefault = true
		end
	end

	UIDropDownMenu_SetText(playerFrameDropdown, isChecked1)

	local function PlayerFrameTextureDropdown_OnClick(self, arg1)
		if arg1 == 1 then
			isChecked1 = "Elite Player Frame"
			isCheckedElite = true
			isCheckedRare = false
			isCheckedRareElite = false
			isCheckedDefault = false

			if eufCfgCharacter.enabled then
				eufCfgCharacter.elitePlayerFrame = true
				eufCfgCharacter.rarePlayerFrame = false
				eufCfgCharacter.rareElitePlayerFrame = false
			else
				eufCfg.elitePlayerFrame = true
				eufCfg.rarePlayerFrame = false
				eufCfg.rareElitePlayerFrame = false
			end

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameDropdown, isChecked1)
		elseif arg1 == 2 then
			isChecked1 = "Rare Player Frame"
			isCheckedElite = false
			isCheckedRare = true
			isCheckedRareElite = false
			isCheckedDefault = false

			if eufCfgCharacter.enabled then
				eufCfgCharacter.elitePlayerFrame = false
				eufCfgCharacter.rarePlayerFrame = true
				eufCfgCharacter.rareElitePlayerFrame = false
			else
				eufCfg.elitePlayerFrame = false
				eufCfg.rarePlayerFrame = true
				eufCfg.rareElitePlayerFrame = false
			end

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameDropdown, isChecked1)
		elseif arg1 == 3 then
			isChecked1 = "Rare Elite Player Frame"
			isCheckedElite = false
			isCheckedRare = false
			isCheckedRareElite = true
			isCheckedDefault = false

			if eufCfgCharacter.enabled then
				eufCfgCharacter.elitePlayerFrame = false
				eufCfgCharacter.rarePlayerFrame = false
				eufCfgCharacter.rareElitePlayerFrame = true
			else
				eufCfg.elitePlayerFrame = false
				eufCfg.rarePlayerFrame = false
				eufCfg.rareElitePlayerFrame = true
			end

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameDropdown, isChecked1)
		elseif arg1 == 4 then
			isChecked1 = "Default Player Frame"
			isCheckedElite = false
			isCheckedRare = false
			isCheckedRareElite = false
			isCheckedDefault = true

			if eufCfgCharacter.enabled then
				eufCfgCharacter.elitePlayerFrame = false
				eufCfgCharacter.rarePlayerFrame = false
				eufCfgCharacter.rareElitePlayerFrame = false
			else
				eufCfg.elitePlayerFrame = false
				eufCfg.rarePlayerFrame = false
				eufCfg.rareElitePlayerFrame = false
			end

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

	if GetCVar("statusTextDisplay") == "NUMERIC" then
		isChecked3 = "Numeric Value"
		isCheckedNumericValue = true
	elseif GetCVar("statusTextDisplay") == "PERCENT" then
		isChecked3 = "Percentage"
		isCheckedPercentage = true
	elseif GetCVar("statusTextDisplay") == "BOTH" then
		isChecked3 = "Both"
		isCheckedBoth = true
	elseif GetCVar("statusTextDisplay") == "NONE" then
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

			SetCVar("statusText", 1)
			SetCVar("statusTextDisplay", "NUMERIC")
			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(statusTextDropdown, isChecked2)
		elseif arg1 == 2 then
			isChecked2 = "Percentage"
			isCheckedNumericValue = false
			isCheckedPercentage = true
			isCheckedBoth = false
			isCheckedNone = false

			SetCVar("statusText", 1)
			SetCVar("statusTextDisplay", "PERCENT")
			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(statusTextDropdown, isChecked2)
		elseif arg1 == 3 then
			isChecked2 = "Both"
			isCheckedNumericValue = false
			isCheckedPercentage = false
			isCheckedBoth = true
			isCheckedNone = false

			SetCVar("statusText", 1)
			SetCVar("statusTextDisplay", "BOTH")
			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(statusTextDropdown, isChecked2)
		elseif arg1 == 4 then
			isChecked2 = "None"
			isCheckedNumericValue = false
			isCheckedPercentage = false
			isCheckedBoth = false
			isCheckedNone = true

			SetCVar("statusText", 0)
			SetCVar("statusTextDisplay", "NONE")
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

	if eufCfgCharacter.enabled then
		characterConfigurationCheckbox:SetChecked(true)

		if eufCfgCharacter.wideTargetFrame == true then
			wideTargetFrameCheckbox:SetChecked(true)
		end

		if eufCfgCharacter.mirroredPositioning == true then
			mirroredPositioningCheckbox:SetChecked(true)
		end

		if eufCfgCharacter.upperCaseAbbreviation == true then
			upperCaseAbbreviationCheckbox:SetChecked(true)
		end

		if eufCfgCharacter.classIconPortraits == true then
			classIconPortraitsCheckbox:SetChecked(true)
		end

		if eufCfgCharacter.hideHitIndicators == true then
			hideHitIndicatorsCheckbox:SetChecked(true)
		end

		if eufCfgCharacter.hidePetStatusText == true then
			hidePetStatusTextCheckbox:SetChecked(true)
		end

		if eufCfgCharacter.hideRestingIcon == true then
			hideRestingIconCheckbox:SetChecked(true)
		end

		if isClassic() then
			if eufCfgCharacter.shamanClassColorFix == true then
				shamanClassColorFixCheckbox:SetChecked(true)
			end
		else
			if C_CVar.GetCVar("threatShowNumeric") == "1" then
				threatShowNumericCheckbox:SetChecked(true)
			end
		end
	else
		if eufCfg.wideTargetFrame == true then
			wideTargetFrameCheckbox:SetChecked(true)
		end

		if eufCfg.mirroredPositioning == true then
			mirroredPositioningCheckbox:SetChecked(true)
		end

		if eufCfg.upperCaseAbbreviation == true then
			upperCaseAbbreviationCheckbox:SetChecked(true)
		end

		if eufCfg.classIconPortraits == true then
			classIconPortraitsCheckbox:SetChecked(true)
		end

		if eufCfg.hideHitIndicators == true then
			hideHitIndicatorsCheckbox:SetChecked(true)
		end

		if eufCfg.hidePetStatusText == true then
			hidePetStatusTextCheckbox:SetChecked(true)
		end

		if eufCfg.hideRestingIcon == true then
			hideRestingIconCheckbox:SetChecked(true)
		end

		if isClassic() then
			if eufCfg.shamanClassColorFix == true then
				shamanClassColorFixCheckbox:SetChecked(true)
			end
		else
			if C_CVar.GetCVar("threatShowNumeric") == "1" then
				threatShowNumericCheckbox:SetChecked(true)
			end
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
			if eufCfgCharacter.enabled then
				eufCfgCharacter.bigPlayerHealthBar = true
			else
				eufCfg.bigPlayerHealthBar = true
			end

			PlaySound(856)
		else
			if eufCfgCharacter.enabled then
				eufCfgCharacter.bigPlayerHealthBar = false
			else
				eufCfg.bigPlayerHealthBar = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	bigTargetHealthBar:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCfgCharacter.enabled then
				eufCfgCharacter.bigTargetHealthBar = true
			else
				eufCfg.bigTargetHealthBar = true
			end

			PlaySound(856)
		else
			if eufCfgCharacter.enabled then
				eufCfgCharacter.bigTargetHealthBar = false
			else
				eufCfg.bigTargetHealthBar = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	classHealthBarColor:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCfgCharacter.enabled then
				eufCfgCharacter.classHealthBarColor = true
			else
				eufCfg.classHealthBarColor = true
			end

			PlaySound(856)
		else
			if eufCfgCharacter.enabled then
				eufCfgCharacter.classHealthBarColor = false
			else
				eufCfg.classHealthBarColor = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	reactionHealthBarColor:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCfgCharacter.enabled then
				eufCfgCharacter.reactionHealthBarColor = true
			else
				eufCfg.reactionHealthBarColor = true
			end

			PlaySound(856)
		else
			if eufCfgCharacter.enabled then
				eufCfgCharacter.reactionHealthBarColor = false
			else
				eufCfg.reactionHealthBarColor = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	hidePowerAnimation:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCfgCharacter.enabled then
				eufCfgCharacter.hidePowerAnimation = true
			else
				eufCfg.hidePowerAnimation = true
			end

			PlaySound(856)
		else
			if eufCfgCharacter.enabled then
				eufCfgCharacter.hidePowerAnimation = false
			else
				eufCfg.hidePowerAnimation = false
			end

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

	if eufCfgCharacter.enabled then
		if eufCfgCharacter.bigPlayerHealthBar == true then
			bigPlayerHealthBarCheckbox:SetChecked(true)
		end

		if eufCfgCharacter.bigTargetHealthBar == true then
			bigTargetHealthBarCheckbox:SetChecked(true)
		end

		if eufCfgCharacter.classHealthBarColor == true then
			classHealthBarColorCheckbox:SetChecked(true)
		end

		if eufCfgCharacter.reactionHealthBarColor == true then
			reactionHealthBarColorCheckbox:SetChecked(true)
		end

		if eufCfgCharacter.hidePowerAnimation == true then
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
	else
		if eufCfg.bigPlayerHealthBar == true then
			bigPlayerHealthBarCheckbox:SetChecked(true)
		end

		if eufCfg.bigTargetHealthBar == true then
			bigTargetHealthBarCheckbox:SetChecked(true)
		end

		if eufCfg.classHealthBarColor == true then
			classHealthBarColorCheckbox:SetChecked(true)
		end

		if eufCfg.reactionHealthBarColor == true then
			reactionHealthBarColorCheckbox:SetChecked(true)
		end

		if eufCfg.hidePowerAnimation == true then
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

	if eufCfgCharacter.enabled then
		wideTargetFrameSlider:SetValue(eufCfgCharacter.wideTargetFrameWidth)
		wideTargetFrameSliderEditbox:SetText(eufCfgCharacter.wideTargetFrameWidth)
	else
		wideTargetFrameSlider:SetValue(eufCfg.wideTargetFrameWidth)
		wideTargetFrameSliderEditbox:SetText(eufCfg.wideTargetFrameWidth)
	end

	wideTargetFrame:HookScript("OnValueChanged", function(self, value)
		value = floor(value)

		if eufCfgCharacter.enabled then
			eufCfgCharacter.wideTargetFrameWidth = value
		else
			eufCfg.wideTargetFrameWidth = value
		end
	end)

	if isClassic() then
		-- Creates the aura icon size slider.

		auraIconSize = createSlider("auraIconSize", self, "Aura Size", 17, 30, 1, "Aura Icon Size", "Changes the aura icon size on the target frame.")

		auraIconSize:SetPoint("TOPLEFT", wideTargetFrame, "BOTTOMLEFT", 0, -70)

		if eufCfgCharacter.enabled then
			auraIconSizeSlider:SetValue(eufCfgCharacter.largeAuraIconSize)
			auraIconSizeSliderEditbox:SetText(eufCfgCharacter.largeAuraIconSize)
		else
			auraIconSizeSlider:SetValue(eufCfg.largeAuraIconSize)
			auraIconSizeSliderEditbox:SetText(eufCfg.largeAuraIconSize)
		end

		auraIconSize:HookScript("OnValueChanged", function(self, value)
			value = floor(value)

			if eufCfgCharacter.enabled then
				eufCfgCharacter.largeAuraIconSize = value
			else
				eufCfg.largeAuraIconSize = value
			end
		end)
	else
		-- Creates the large aura icon size slider.

		largeAuraIconSize = createSlider("largeAuraIconSize", self, "Large Aura", 17, 30, 1, "Large Aura Icon Size", "Changes the large aura icon size on the target and focus frames.")

		largeAuraIconSize:SetPoint("TOPLEFT", wideTargetFrame, "BOTTOMLEFT", 0, -70)

		if eufCfgCharacter.enabled then
			largeAuraIconSizeSlider:SetValue(eufCfgCharacter.largeAuraIconSize)
			largeAuraIconSizeSliderEditbox:SetText(eufCfgCharacter.largeAuraIconSize)
		else
			largeAuraIconSizeSlider:SetValue(eufCfg.largeAuraIconSize)
			largeAuraIconSizeSliderEditbox:SetText(eufCfg.largeAuraIconSize)
		end

		largeAuraIconSize:HookScript("OnValueChanged", function(self, value)
			value = floor(value)

			if eufCfgCharacter.enabled then
				eufCfgCharacter.largeAuraIconSize = value
			else
				eufCfg.largeAuraIconSize = value
			end
		end)

		-- Creates the small aura icon size slider.

		smallAuraIconSize = createSlider("smallAuraIconSize", self, "Small Aura", 17, 30, 1, "Small Aura Icon Size", "Changes the small aura icon size on the target and focus frames.")

		smallAuraIconSize:SetPoint("TOPLEFT", largeAuraIconSize, "BOTTOMLEFT", 0, -70)

		if eufCfgCharacter.enabled then
			smallAuraIconSizeSlider:SetValue(eufCfgCharacter.smallAuraIconSize)
			smallAuraIconSizeSliderEditbox:SetText(eufCfgCharacter.smallAuraIconSize)
		else
			smallAuraIconSizeSlider:SetValue(eufCfg.smallAuraIconSize)
			smallAuraIconSizeSliderEditbox:SetText(eufCfg.smallAuraIconSize)
		end

		smallAuraIconSize:HookScript("OnValueChanged", function(self, value)
			value = floor(value)

			if eufCfgCharacter.enabled then
				eufCfgCharacter.smallAuraIconSize = value
			else
				eufCfg.smallAuraIconSize = value
			end
		end)
	end

	-- Creates the player and target frame scale slider.

	playerTargetFrameScale = createScaleSlider("playerTargetFrameScale", self, "Main Scale", 1, 1.5, 0.01, "Player and Target Frame Scale", "Changes the scale of the player and target frame.")

	if isClassic() then
		playerTargetFrameScale:SetPoint("TOPLEFT", auraIconSize, "BOTTOMLEFT", 0, -70)
	else
		playerTargetFrameScale:SetPoint("TOPLEFT", smallAuraIconSize, "BOTTOMLEFT", 0, -70)
	end

	playerTargetFrameScale:HookScript("OnValueChanged", function(self, value)
		PlayerFrame:SetScale(round(value, 2))
		TargetFrame:SetScale(round(value, 2))
	end)

	self:SetScript("OnShow", nil)
end)
