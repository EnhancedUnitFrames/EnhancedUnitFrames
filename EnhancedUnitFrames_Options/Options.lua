-- Creates the options panel.

eufOptions = CreateFrame("Frame", "eufOptionsPanel", UIParent)
eufOptions.general = CreateFrame("Frame", "eufOptionsGeneral", eufOptions)
eufOptions.healthBars = CreateFrame("Frame", "eufOptionsHealthBars", eufOptions)
eufOptions.scaling = CreateFrame("Frame", "eufOptionsPanelScaling", eufOptions)
eufOptions.statusText = CreateFrame("Frame", "eufOptionsPanelStatusText", eufOptions)
eufOptions.name = "EnhancedUnitFrames"
eufOptions.general.name = "General"
eufOptions.healthBars.name = "Health Bars"
eufOptions.scaling.name = "Frame Scaling"
eufOptions.statusText.name = "Status Text"
eufOptions.general.parent = eufOptions.name
eufOptions.healthBars.parent = eufOptions.name
eufOptions.scaling.parent = eufOptions.name
eufOptions.statusText.parent = eufOptions.name

InterfaceOptions_AddCategory(eufOptions)
InterfaceOptions_AddCategory(eufOptions.general)
InterfaceOptions_AddCategory(eufOptions.healthBars)
InterfaceOptions_AddCategory(eufOptions.scaling)
InterfaceOptions_AddCategory(eufOptions.statusText)
eufOptions:Hide()
eufOptions.general:Hide()
eufOptions.healthBars:Hide()
eufOptions.scaling:Hide()
eufOptions.statusText:Hide()

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

eufOptions.general:SetScript("OnShow", function(self)
	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

	title:SetPoint("TOPLEFT", self, 16, -16)
	title:SetText("EnhancedUnitFrames")

	local description = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallOutline")

	description:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	description:SetText("Modifies the default unit frames for better visuals.")

	-- Creates checkboxes.

	characterDatabase = createCheckbox("characterDatabase", self, "Per-Character Configuration", "If enabled, this character's configuration will not affect the global configuration.")

	if isClassic() then
		wideTargetFrame = createCheckbox("wideTargetFrame", self, "Wide Target Frame", "Makes the target frame wider.\nSource: Wide Target by Gello.")
	else
		wideTargetFrame = createCheckbox("wideTargetFrame", self, "Wide Target Frame", "Makes the target and focus frames wider.\nSource: Wide Target by Gello.")
	end

	local mirroredPositioning = createCheckbox("mirroredPositioning", self, "Mirrored Positioning", "Allows the easy mirrored positioning of the player and target frames.\n1. Right-click the player frame.\n2. Hover over \"Move Frame\".\n3. Select \"Unlock Frame\" to begin.\nSource: Focused by haggen.")
	local upperCaseAbbreviation = createCheckbox("upperCaseAbbreviation", self, "Uppercase Abbreviation", "Changes whether long status text numbers are abbreviated with a capital letter at the end or not.")
	local classIconPortraits = createCheckbox("classIconPortraits", self, "Class Icon Portraits", "Changes the unit frame portraits to the unit's class icon.")
	local hideHitIndicators = createCheckbox("hideHitIndicators", self, "Hide Hit Indicators", "Hides the damage/healing spam on player and pet frames.")
	local hideRestingIcon = createCheckbox("hideRestingIcon", self, "Hide Resting Icon", "Hides the resting icon on the player frame.")

	if isClassic() then
		shamanClassColorFix = createCheckbox("shamanClassColorFix", self, "Shaman Class Color Fix", "Changes the Shaman class color to reflect live.")
	else
		threatShowNumeric = createCheckbox("threatShowNumeric", self, "Show Numeric Threat", "Shows a numerical target threat indicator on the player frame.\nRequires \"Threat Warning\" to be enabled to display.")
	end

	-- Positions the checkboxes created.

	characterDatabase:SetPoint("RIGHT", title, 50, 0)
	wideTargetFrame:SetPoint("TOPLEFT", description, "BOTTOMLEFT", -2, -22)
	mirroredPositioning:SetPoint("TOPLEFT", wideTargetFrame, "BOTTOMLEFT", 0, -8)
	upperCaseAbbreviation:SetPoint("TOPLEFT", mirroredPositioning, "BOTTOMLEFT", 0, -8)
	classIconPortraits:SetPoint("TOPLEFT", upperCaseAbbreviation, "BOTTOMLEFT", 0, -8)
	hideHitIndicators:SetPoint("TOPLEFT", classIconPortraits, "BOTTOMLEFT", 0, -8)
	hideRestingIcon:SetPoint("TOPLEFT", hideHitIndicators, "BOTTOMLEFT", 0, -8)

	if isClassic() then
		shamanClassColorFix:SetPoint("TOPLEFT", hideRestingIcon, "BOTTOMLEFT", 0, -8)
	else
		threatShowNumeric:SetPoint("TOPLEFT", hideRestingIcon, "BOTTOMLEFT", 0, -8)
	end

	-- Applies scripts to the checkboxes.

	characterDatabase:SetScript("OnClick", function(self)
		local function updateCVars()
			if eufCharacterDB.enabled then
				if eufCharacterDB.statusTextNumeric then
					SetCVar("statusText", 1)
					SetCVar("statusTextDisplay", "NUMERIC")
				elseif eufCharacterDB.statusTextPercent then
					SetCVar("statusText", 1)
					SetCVar("statusTextDisplay", "PERCENT")
				elseif eufCharacterDB.statusTextBoth or eufCharacterDB.statusTextBothCondensed then
					SetCVar("statusText", 1)
					SetCVar("statusTextDisplay", "BOTH")
				elseif eufCharacterDB.statusTextNone then
					SetCVar("statusText", 0)
					SetCVar("statusTextDisplay", "NONE")
				end
			else
				if eufDB.statusTextNumeric then
					SetCVar("statusText", 1)
					SetCVar("statusTextDisplay", "NUMERIC")
				elseif eufDB.statusTextPercent then
					SetCVar("statusText", 1)
					SetCVar("statusTextDisplay", "PERCENT")
				elseif eufDB.statusTextBoth or eufDB.statusTextBothCondensed then
					SetCVar("statusText", 1)
					SetCVar("statusTextDisplay", "BOTH")
				elseif eufDB.statusTextNone then
					SetCVar("statusText", 0)
					SetCVar("statusTextDisplay", "NONE")
				end
			end
		end

		if self:GetChecked() then
			eufCharacterDB.enabled = true
			updateCVars()

			PlaySound(856)
		else
			eufCharacterDB.enabled = false
			updateCVars()

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	wideTargetFrame:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.wideTargetFrame = true
			else
				eufDB.wideTargetFrame = false
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.wideTargetFrame = false
			else
				eufDB.wideTargetFrame = false
			end
			
			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	mirroredPositioning:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.mirroredPositioning = true
			else
				eufDB.mirroredPositioning = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.mirroredPositioning = false
			else
				eufDB.mirroredPositioning = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	upperCaseAbbreviation:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.upperCaseAbbreviation = true
			else
				eufDB.upperCaseAbbreviation = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.upperCaseAbbreviation = false
			else
				eufDB.upperCaseAbbreviation = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	classIconPortraits:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.classIconPortraits = true
			else
				eufDB.classIconPortraits = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.classIconPortraits = false
			else
				eufDB.classIconPortraits = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	hideHitIndicators:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.hideHitIndicators = true
			else
				eufDB.hideHitIndicators = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.hideHitIndicators = false
			else
				eufDB.hideHitIndicators = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	hideRestingIcon:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.hideRestingIcon = true
			else
				eufDB.hideRestingIcon = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.hideRestingIcon = false
			else
				eufDB.hideRestingIcon = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	if isClassic() then
		shamanClassColorFix:SetScript("OnClick", function(self)
			if self:GetChecked() then
				if eufCharacterDB.enabled then
					eufCharacterDB.shamanClassColorFix = true
				else
					eufDB.shamanClassColorFix = true
				end

				PlaySound(856)
			else
				if eufCharacterDB.enabled then
					eufCharacterDB.shamanClassColorFix = false
				else
					eufDB.shamanClassColorFix = false
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
	playerFrameDropdown.title = playerFrameDropdown:CreateFontString("playerFrameDropdownLabel", "ARTWORK", "GameFontNormal")

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

	if eufCharacterDB.enabled then
		if eufCharacterDB.elitePlayerFrame == true then
			isCheckedPlayerFrame = "Elite Player Frame"
			isCheckedElite = true
		elseif eufCharacterDB.rarePlayerFrame == true then
			isCheckedPlayerFrame = "Rare Player Frame"
			isCheckedRare = true
		elseif eufCharacterDB.rareElitePlayerFrame == true then
			isCheckedPlayerFrame = "Rare Elite Player Frame"
			isCheckedRareElite = true
		else
			isCheckedPlayerFrame = "Default Player Frame"
			isCheckedDefault = true
		end
	else
		if eufDB.elitePlayerFrame == true then
			isCheckedPlayerFrame = "Elite Player Frame"
			isCheckedElite = true
		elseif eufDB.rarePlayerFrame == true then
			isCheckedPlayerFrame = "Rare Player Frame"
			isCheckedRare = true
		elseif eufDB.rareElitePlayerFrame == true then
			isCheckedPlayerFrame = "Rare Elite Player Frame"
			isCheckedRareElite = true
		else
			isCheckedPlayerFrame = "Default Player Frame"
			isCheckedDefault = true
		end
	end

	UIDropDownMenu_SetText(playerFrameDropdown, isCheckedPlayerFrame)

	local function playerFrameTextureDropdownMenuOnClick(self, arg1)
		if arg1 == 1 then
			isCheckedPlayerFrame = "Elite Player Frame"
			isCheckedElite = true
			isCheckedRare = false
			isCheckedRareElite = false
			isCheckedDefault = false

			if eufCharacterDB.enabled then
				eufCharacterDB.elitePlayerFrame = true
				eufCharacterDB.rarePlayerFrame = false
				eufCharacterDB.rareElitePlayerFrame = false
			else
				eufDB.elitePlayerFrame = true
				eufDB.rarePlayerFrame = false
				eufDB.rareElitePlayerFrame = false
			end

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameDropdown, isCheckedPlayerFrame)
		elseif arg1 == 2 then
			isCheckedPlayerFrame = "Rare Player Frame"
			isCheckedElite = false
			isCheckedRare = true
			isCheckedRareElite = false
			isCheckedDefault = false

			if eufCharacterDB.enabled then
				eufCharacterDB.elitePlayerFrame = false
				eufCharacterDB.rarePlayerFrame = true
				eufCharacterDB.rareElitePlayerFrame = false
			else
				eufDB.elitePlayerFrame = false
				eufDB.rarePlayerFrame = true
				eufDB.rareElitePlayerFrame = false
			end

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameDropdown, isCheckedPlayerFrame)
		elseif arg1 == 3 then
			isCheckedPlayerFrame = "Rare Elite Player Frame"
			isCheckedElite = false
			isCheckedRare = false
			isCheckedRareElite = true
			isCheckedDefault = false

			if eufCharacterDB.enabled then
				eufCharacterDB.elitePlayerFrame = false
				eufCharacterDB.rarePlayerFrame = false
				eufCharacterDB.rareElitePlayerFrame = true
			else
				eufDB.elitePlayerFrame = false
				eufDB.rarePlayerFrame = false
				eufDB.rareElitePlayerFrame = true
			end

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameDropdown, isCheckedPlayerFrame)
		elseif arg1 == 4 then
			isCheckedPlayerFrame = "Default Player Frame"
			isCheckedElite = false
			isCheckedRare = false
			isCheckedRareElite = false
			isCheckedDefault = true

			if eufCharacterDB.enabled then
				eufCharacterDB.elitePlayerFrame = false
				eufCharacterDB.rarePlayerFrame = false
				eufCharacterDB.rareElitePlayerFrame = false
			else
				eufDB.elitePlayerFrame = false
				eufDB.rarePlayerFrame = false
				eufDB.rareElitePlayerFrame = false
			end

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameDropdown, isCheckedPlayerFrame)
		end
	end

	local function playerFrameTextureDropdownMenu(frame, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		info.func = playerFrameTextureDropdownMenuOnClick

		info.text, info.arg1, info.checked = "Elite Player Frame", 1, isCheckedElite
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Rare Player Frame", 2, isCheckedRare
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Rare Elite Player Frame", 3, isCheckedRareElite
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Default Player Frame", 4, isCheckedDefault
		UIDropDownMenu_AddButton(info)
	end

	UIDropDownMenu_Initialize(playerFrameDropdown, playerFrameTextureDropdownMenu)

	-- Threat warning dropdown menu.

	if not isClassic() then
		threatWarningDropdown = CreateFrame("Frame", "eufThreatWarningDropdown", self, "UIDropDownMenuTemplate")
		threatWarningDropdown.title = threatWarningDropdown:CreateFontString("threatWarningDropdownLabel", "ARTWORK", "GameFontNormal")

		threatWarningDropdown:SetPoint("TOPLEFT", playerFrameDropdown, "BOTTOMLEFT", 0, -37)
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
			isCheckedThreatWarning = "Off"
			isCheckedOff = true
		elseif C_CVar.GetCVar("threatWarning") == "1" then
			isCheckedThreatWarning = "In Dungeons"
			isCheckedInDungeons = true
		elseif C_CVar.GetCVar("threatWarning") == "2" then
			isCheckedThreatWarning = "In Party/Raid"
			isCheckedPartyRaid = true
		elseif C_CVar.GetCVar("threatWarning") == "3" then
			isCheckedThreatWarning = "Always"
			isCheckedAlways = true
		end

		UIDropDownMenu_SetText(threatWarningDropdown, isCheckedThreatWarning)

		local function threatWarningDropdownOnClick(self, arg1)
			if arg1 == 1 then
				C_CVar.SetCVar("threatWarning", 1)
				isCheckedThreatWarning = "In Dungeons"
				isCheckedOff = false
				isCheckedInDungeons = true
				isCheckedPartyRaid = false
				isCheckedAlways = false

				UIDropDownMenu_SetText(threatWarningDropdown, isCheckedThreatWarning)
			elseif arg1 == 2 then
				C_CVar.SetCVar("threatWarning", 2)
				isCheckedThreatWarning = "In Party/Raid"
				isCheckedOff = false
				isCheckedInDungeons = false
				isCheckedPartyRaid = true
				isCheckedAlways = false

				UIDropDownMenu_SetText(threatWarningDropdown, isCheckedThreatWarning)
			elseif arg1 == 3 then
				C_CVar.SetCVar("threatWarning", 3)
				isCheckedThreatWarning = "Always"
				isCheckedOff = false
				isCheckedInDungeons = false
				isCheckedPartyRaid = false
				isCheckedAlways = true

				UIDropDownMenu_SetText(threatWarningDropdown, isCheckedThreatWarning)
			elseif arg1 == 4 then
				C_CVar.SetCVar("threatWarning", 0)
				isCheckedThreatWarning = "Off"
				isCheckedOff = true
				isCheckedInDungeons = false
				isCheckedPartyRaid = false
				isCheckedAlways = false

				UIDropDownMenu_SetText(threatWarningDropdown, isCheckedThreatWarning)
			end
		end

		local function threatWarningDropdownMenu(frame, level, menuList)
			local info = UIDropDownMenu_CreateInfo()
			info.func = threatWarningDropdownOnClick

			info.text, info.arg1, info.checked = "In Dungeons", 1, isCheckedInDungeons
			UIDropDownMenu_AddButton(info)
			info.text, info.arg1, info.checked = "In Party/Raid", 2, isCheckedPartyRaid
			UIDropDownMenu_AddButton(info)
			info.text, info.arg1, info.checked = "Always", 3, isCheckedAlways
			UIDropDownMenu_AddButton(info)
			info.text, info.arg1, info.checked = "Off", 4, isCheckedOff
			UIDropDownMenu_AddButton(info)
		end

		UIDropDownMenu_Initialize(threatWarningDropdown, threatWarningDropdownMenu)
	end

	-- Initializes the options panel with saved variables.

	if eufCharacterDB.enabled then
		characterDatabaseCheckbox:SetChecked(true)

		if eufCharacterDB.wideTargetFrame == true then
			wideTargetFrameCheckbox:SetChecked(true)
		end

		if eufCharacterDB.mirroredPositioning == true then
			mirroredPositioningCheckbox:SetChecked(true)
		end

		if eufCharacterDB.upperCaseAbbreviation == true then
			upperCaseAbbreviationCheckbox:SetChecked(true)
		end

		if eufCharacterDB.classIconPortraits == true then
			classIconPortraitsCheckbox:SetChecked(true)
		end

		if eufCharacterDB.hideHitIndicators == true then
			hideHitIndicatorsCheckbox:SetChecked(true)
		end

		if eufCharacterDB.hideRestingIcon == true then
			hideRestingIconCheckbox:SetChecked(true)
		end

		if isClassic() then
			if eufCharacterDB.shamanClassColorFix == true then
				shamanClassColorFixCheckbox:SetChecked(true)
			end
		else
			if C_CVar.GetCVar("threatShowNumeric") == "1" then
				threatShowNumericCheckbox:SetChecked(true)
			end
		end
	else
		if eufDB.wideTargetFrame == true then
			wideTargetFrameCheckbox:SetChecked(true)
		end

		if eufDB.mirroredPositioning == true then
			mirroredPositioningCheckbox:SetChecked(true)
		end

		if eufDB.upperCaseAbbreviation == true then
			upperCaseAbbreviationCheckbox:SetChecked(true)
		end

		if eufDB.classIconPortraits == true then
			classIconPortraitsCheckbox:SetChecked(true)
		end

		if eufDB.hideHitIndicators == true then
			hideHitIndicatorsCheckbox:SetChecked(true)
		end

		if eufDB.hideRestingIcon == true then
			hideRestingIconCheckbox:SetChecked(true)
		end

		if isClassic() then
			if eufDB.shamanClassColorFix == true then
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

	-- Applies scripts to the checkboxes.

	bigPlayerHealthBar:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.bigPlayerHealthBar = true
			else
				eufDB.bigPlayerHealthBar = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.bigPlayerHealthBar = false
			else
				eufDB.bigPlayerHealthBar = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	bigTargetHealthBar:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.bigTargetHealthBar = true
			else
				eufDB.bigTargetHealthBar = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.bigTargetHealthBar = false
			else
				eufDB.bigTargetHealthBar = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	classHealthBarColor:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.classHealthBarColor = true
			else
				eufDB.classHealthBarColor = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.classHealthBarColor = false
			else
				eufDB.classHealthBarColor = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	reactionHealthBarColor:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.reactionHealthBarColor = true
			else
				eufDB.reactionHealthBarColor = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.reactionHealthBarColor = false
			else
				eufDB.reactionHealthBarColor = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	hidePowerAnimation:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.hidePowerAnimation = true
			else
				eufDB.hidePowerAnimation = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.hidePowerAnimation = false
			else
				eufDB.hidePowerAnimation = false
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

	if eufCharacterDB.enabled then
		if eufCharacterDB.bigPlayerHealthBar == true then
			bigPlayerHealthBarCheckbox:SetChecked(true)
		end

		if eufCharacterDB.bigTargetHealthBar == true then
			bigTargetHealthBarCheckbox:SetChecked(true)
		end

		if eufCharacterDB.classHealthBarColor == true then
			classHealthBarColorCheckbox:SetChecked(true)
		end

		if eufCharacterDB.reactionHealthBarColor == true then
			reactionHealthBarColorCheckbox:SetChecked(true)
		end

		if eufCharacterDB.hidePowerAnimation == true then
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
		if eufDB.bigPlayerHealthBar == true then
			bigPlayerHealthBarCheckbox:SetChecked(true)
		end

		if eufDB.bigTargetHealthBar == true then
			bigTargetHealthBarCheckbox:SetChecked(true)
		end

		if eufDB.classHealthBarColor == true then
			classHealthBarColorCheckbox:SetChecked(true)
		end

		if eufDB.reactionHealthBarColor == true then
			reactionHealthBarColorCheckbox:SetChecked(true)
		end

		if eufDB.hidePowerAnimation == true then
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

	if eufCharacterDB.enabled then
		wideTargetFrameSlider:SetValue(eufCharacterDB.wideTargetFrameWidth)
		wideTargetFrameSliderEditbox:SetText(eufCharacterDB.wideTargetFrameWidth)
	else
		wideTargetFrameSlider:SetValue(eufDB.wideTargetFrameWidth)
		wideTargetFrameSliderEditbox:SetText(eufDB.wideTargetFrameWidth)
	end

	wideTargetFrame:HookScript("OnValueChanged", function(self, value)
		value = floor(value)

		if eufCharacterDB.enabled then
			eufCharacterDB.wideTargetFrameWidth = value
		else
			eufDB.wideTargetFrameWidth = value
		end
	end)

	if isClassic() then
		-- Creates the aura icon size slider.

		auraIconSize = createSlider("auraIconSize", self, "Aura Size", 17, 30, 1, "Aura Icon Size", "Changes the aura icon size on the target frame.")

		auraIconSize:SetPoint("TOPLEFT", wideTargetFrame, "BOTTOMLEFT", 0, -70)

		if eufCharacterDB.enabled then
			auraIconSizeSlider:SetValue(eufCharacterDB.largeAuraIconSize)
			auraIconSizeSliderEditbox:SetText(eufCharacterDB.largeAuraIconSize)
		else
			auraIconSizeSlider:SetValue(eufDB.largeAuraIconSize)
			auraIconSizeSliderEditbox:SetText(eufDB.largeAuraIconSize)
		end

		auraIconSize:HookScript("OnValueChanged", function(self, value)
			value = floor(value)

			if eufCharacterDB.enabled then
				eufCharacterDB.largeAuraIconSize = value
			else
				eufDB.largeAuraIconSize = value
			end
		end)
	else
		-- Creates the large aura icon size slider.

		largeAuraIconSize = createSlider("largeAuraIconSize", self, "Large Aura", 17, 30, 1, "Large Aura Icon Size", "Changes the large aura icon size on the target and focus frames.")

		largeAuraIconSize:SetPoint("TOPLEFT", wideTargetFrame, "BOTTOMLEFT", 0, -70)

		if eufCharacterDB.enabled then
			largeAuraIconSizeSlider:SetValue(eufCharacterDB.largeAuraIconSize)
			largeAuraIconSizeSliderEditbox:SetText(eufCharacterDB.largeAuraIconSize)
		else
			largeAuraIconSizeSlider:SetValue(eufDB.largeAuraIconSize)
			largeAuraIconSizeSliderEditbox:SetText(eufDB.largeAuraIconSize)
		end

		largeAuraIconSize:HookScript("OnValueChanged", function(self, value)
			value = floor(value)

			if eufCharacterDB.enabled then
				eufCharacterDB.largeAuraIconSize = value
			else
				eufDB.largeAuraIconSize = value
			end
		end)

		-- Creates the small aura icon size slider.

		smallAuraIconSize = createSlider("smallAuraIconSize", self, "Small Aura", 17, 30, 1, "Small Aura Icon Size", "Changes the small aura icon size on the target and focus frames.")

		smallAuraIconSize:SetPoint("TOPLEFT", largeAuraIconSize, "BOTTOMLEFT", 0, -70)

		if eufCharacterDB.enabled then
			smallAuraIconSizeSlider:SetValue(eufCharacterDB.smallAuraIconSize)
			smallAuraIconSizeSliderEditbox:SetText(eufCharacterDB.smallAuraIconSize)
		else
			smallAuraIconSizeSlider:SetValue(eufDB.smallAuraIconSize)
			smallAuraIconSizeSliderEditbox:SetText(eufDB.smallAuraIconSize)
		end

		smallAuraIconSize:HookScript("OnValueChanged", function(self, value)
			value = floor(value)

			if eufCharacterDB.enabled then
				eufCharacterDB.smallAuraIconSize = value
			else
				eufDB.smallAuraIconSize = value
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

eufOptions.statusText:SetScript("OnShow", function(self)
	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

	title:SetPoint("TOPLEFT", self, 16, -16)
	title:SetText("EnhancedUnitFrames")

	local description = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallOutline")

	description:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	description:SetText("Modifies the default unit frames for better visuals.")

	-- Creates checkboxes.

	local hidePetStatusText = createCheckbox("hidePetStatusText", self, "Hide Pet Status Text", "Hides the pet frame status bar text.")

	-- Positions the checkboxes created.

	hidePetStatusText:SetPoint("TOPLEFT", description, "BOTTOMLEFT", -2, -22)

	-- Applies scripts to the checkboxes.

	hidePetStatusText:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.hidePetStatusText = true
			else
				eufDB.hidePetStatusText = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.hidePetStatusText = false
			else
				eufDB.hidePetStatusText = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	-- Status text dropdown menu.

	local statusTextDropdown = CreateFrame("Frame", "eufStatusTextDropdown", self, "UIDropDownMenuTemplate")
	statusTextDropdown.title = statusTextDropdown:CreateFontString("statusTextDropdownLabel", "ARTWORK", "GameFontNormal")

	statusTextDropdown:SetPoint("TOPLEFT", hidePetStatusText, "BOTTOMLEFT", 273, 8)
	statusTextDropdown.title:SetPoint("BOTTOMLEFT", statusTextDropdown, "TOPLEFT", 15, 3)
	statusTextDropdown.title:SetText("Status Text")

	statusTextDropdown:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -17, 1)
		GameTooltip:SetText("Status Text", nil, nil, nil, 1, true)
		GameTooltip:AddLine("Display status text as numbers, percentage, both, or both condensed.", 1, 1, 1, 1)
		GameTooltip:Show()
	end)

	statusTextDropdown:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	UIDropDownMenu_SetWidth(statusTextDropdown, 160)

	if eufCharacterDB.enabled then
		if eufCharacterDB.statusTextNumeric then
			isCheckedStatusText = "Numeric Value"
			isCheckedNumericValue = true
		elseif eufCharacterDB.statusTextPercent then
			isCheckedStatusText = "Percentage"
			isCheckedPercentage = true
		elseif eufCharacterDB.statusTextBoth then
			isCheckedStatusText = "Both"
			isCheckedBoth = true
		elseif eufCharacterDB.statusTextBothCondensed then
			isCheckedStatusText = "Both Condensed"
			isCheckedBothCondensed = true
		elseif eufCharacterDB.statusTextNone then
			isCheckedStatusText = "None"
			isCheckedNone = true
		end
	else
		if eufDB.statusTextNumeric then
			isCheckedStatusText = "Numeric Value"
			isCheckedNumericValue = true
		elseif eufDB.statusTextPercent then
			isCheckedStatusText = "Percentage"
			isCheckedPercentage = true
		elseif eufDB.statusTextBoth then
			isCheckedStatusText = "Both"
			isCheckedBoth = true
		elseif eufDB.statusTextBothCondensed then
			isCheckedStatusText = "Both Condensed"
			isCheckedBothCondensed = true
		elseif eufDB.statusTextNone then
			isCheckedStatusText = "None"
			isCheckedNone = true
		end
	end

	UIDropDownMenu_SetText(statusTextDropdown, isCheckedStatusText)

	local function statusTextDropdownOnClick(self, arg1)
		if arg1 == 1 then
			isCheckedStatusText = "Numeric Value"
			isCheckedNumericValue = true
			isCheckedPercentage = false
			isCheckedBoth = false
			isCheckedBothCondensed = false
			isCheckedNone = false

			if eufCharacterDB.enabled then
				eufCharacterDB.statusTextNumeric = true
				eufCharacterDB.statusTextPercent = false
				eufCharacterDB.statusTextBoth = false
				eufCharacterDB.statusTextBothCondensed = false
				eufCharacterDB.statusTextNone = false
			else
				eufDB.statusTextNumeric = true
				eufDB.statusTextPercent = false
				eufDB.statusTextBoth = false
				eufDB.statusTextBothCondensed = false
				eufDB.statusTextNone = false
			end

			SetCVar("statusText", 1)
			SetCVar("statusTextDisplay", "NUMERIC")
			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(statusTextDropdown, isCheckedStatusText)
		elseif arg1 == 2 then
			isCheckedStatusText = "Percentage"
			isCheckedNumericValue = false
			isCheckedPercentage = true
			isCheckedBoth = false
			isCheckedBothCondensed = false
			isCheckedNone = false

			if eufCharacterDB.enabled then
				eufCharacterDB.statusTextNumeric = false
				eufCharacterDB.statusTextPercent = true
				eufCharacterDB.statusTextBoth = false
				eufCharacterDB.statusTextBothCondensed = false
				eufCharacterDB.statusTextNone = false
			else
				eufDB.statusTextNumeric = false
				eufDB.statusTextPercent = true
				eufDB.statusTextBoth = false
				eufDB.statusTextBothCondensed = false
				eufDB.statusTextNone = false
			end

			SetCVar("statusText", 1)
			SetCVar("statusTextDisplay", "PERCENT")
			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(statusTextDropdown, isCheckedStatusText)
		elseif arg1 == 3 then
			isCheckedStatusText = "Both"
			isCheckedNumericValue = false
			isCheckedPercentage = false
			isCheckedBoth = true
			isCheckedBothCondensed = false
			isCheckedNone = false

			if eufCharacterDB.enabled then
				eufCharacterDB.statusTextNumeric = false
				eufCharacterDB.statusTextPercent = false
				eufCharacterDB.statusTextBoth = true
				eufCharacterDB.statusTextBothCondensed = false
				eufCharacterDB.statusTextNone = false
			else
				eufDB.statusTextNumeric = false
				eufDB.statusTextPercent = false
				eufDB.statusTextBoth = true
				eufDB.statusTextBothCondensed = false
				eufDB.statusTextNone = false
			end

			SetCVar("statusText", 1)
			SetCVar("statusTextDisplay", "BOTH")
			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(statusTextDropdown, isCheckedStatusText)
		elseif arg1 == 4 then
			isCheckedStatusText = "Both Condensed"
			isCheckedNumericValue = false
			isCheckedPercentage = false
			isCheckedBoth = false
			isCheckedBothCondensed = true
			isCheckedNone = false

			if eufCharacterDB.enabled then
				eufCharacterDB.statusTextNumeric = false
				eufCharacterDB.statusTextPercent = false
				eufCharacterDB.statusTextBoth = false
				eufCharacterDB.statusTextBothCondensed = true
				eufCharacterDB.statusTextNone = false
			else
				eufDB.statusTextNumeric = false
				eufDB.statusTextPercent = false
				eufDB.statusTextBoth = false
				eufDB.statusTextBothCondensed = true
				eufDB.statusTextNone = false
			end

			SetCVar("statusText", 1)
			SetCVar("statusTextDisplay", "BOTH")
			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(statusTextDropdown, isCheckedStatusText)
		elseif arg1 == 5 then
			isCheckedStatusText = "None"
			isCheckedNumericValue = false
			isCheckedPercentage = false
			isCheckedBoth = false
			isCheckedBothCondensed = false
			isCheckedNone = true

			if eufCharacterDB.enabled then
				eufCharacterDB.statusTextNumeric = false
				eufCharacterDB.statusTextPercent = false
				eufCharacterDB.statusTextBoth = false
				eufCharacterDB.statusTextBothCondensed = false
				eufCharacterDB.statusTextNone = true
			else
				eufDB.statusTextNumeric = false
				eufDB.statusTextPercent = false
				eufDB.statusTextBoth = false
				eufDB.statusTextBothCondensed = false
				eufDB.statusTextNone = true
			end

			SetCVar("statusText", 0)
			SetCVar("statusTextDisplay", "NONE")
			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(statusTextDropdown, isCheckedStatusText)
		end
	end

	local function statusTextDropdownMenu(frame, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		info.func = statusTextDropdownOnClick

		info.text, info.arg1, info.checked = "Numeric Value", 1, isCheckedNumericValue
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Percentage", 2, isCheckedPercentage
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Both", 3, isCheckedBoth
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Both Condensed", 4, isCheckedBothCondensed
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "None", 5, isCheckedNone
		UIDropDownMenu_AddButton(info)
	end

	UIDropDownMenu_Initialize(statusTextDropdown, statusTextDropdownMenu)

	-- Status text "Both Condensed" dropdown menu.

	local statusTextBothCondensedDropdown = CreateFrame("Frame", "eufStatusTextBothCondensedDropdown", self, "UIDropDownMenuTemplate")
	statusTextBothCondensedDropdown.title = statusTextBothCondensedDropdown:CreateFontString("statusTextBothCondensedDropdownLabel", "ARTWORK", "GameFontNormal")

	statusTextBothCondensedDropdown:SetPoint("TOPLEFT", statusTextDropdown, "BOTTOMLEFT", 0, -37)
	statusTextBothCondensedDropdown.title:SetPoint("BOTTOMLEFT", statusTextBothCondensedDropdown, "TOPLEFT", 15, 3)
	statusTextBothCondensedDropdown.title:SetText("Both Condensed Style")

	statusTextBothCondensedDropdown:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -17, 1)
		GameTooltip:SetText("Both Condensed Style", nil, nil, nil, 1, true)
		GameTooltip:AddLine("Changes the style of the \"Both Condensed\" option.", 1, 1, 1, 1)
		GameTooltip:Show()
	end)

	statusTextBothCondensedDropdown:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	UIDropDownMenu_SetWidth(statusTextBothCondensedDropdown, 160)

	if eufCharacterDB.enabled then
		if eufCharacterDB.statusTextBothCondensedBar then
			isCheckedStatusTextBothCondensed = "Bar"
			isCheckedBar = true
		elseif eufCharacterDB.statusTextBothCondensedBrackets then
			isCheckedStatusTextBothCondensed = "Brackets"
			isCheckedBrackets = true
		elseif eufCharacterDB.statusTextBothCondensedDash then
			isCheckedStatusTextBothCondensed = "Dash"
			isCheckedDash = true
		elseif eufCharacterDB.statusTextBothCondensedParentheses then
			isCheckedStatusTextBothCondensed = "Parentheses"
			isCheckedParentheses = true
		elseif eufCharacterDB.statusTextBothCondensedSlash then
			isCheckedStatusTextBothCondensed = "Slash"
			isCheckedSlash = true
		end
	else
		if eufDB.statusTextBothCondensedBar then
			isCheckedStatusTextBothCondensed = "Bar"
			isCheckedBar = true
		elseif eufDB.statusTextBothCondensedBrackets then
			isCheckedStatusTextBothCondensed = "Brackets"
			isCheckedBrackets = true
		elseif eufDB.statusTextBothCondensedDash then
			isCheckedStatusTextBothCondensed = "Dash"
			isCheckedDash = true
		elseif eufDB.statusTextBothCondensedParentheses then
			isCheckedStatusTextBothCondensed = "Parentheses"
			isCheckedParentheses = true
		elseif eufDB.statusTextBothCondensedSlash then
			isCheckedStatusTextBothCondensed = "Slash"
			isCheckedSlash = true
		end
	end

	UIDropDownMenu_SetText(statusTextBothCondensedDropdown, isCheckedStatusTextBothCondensed)

	local function statusTextBothCondensedDropdownOnClick(self, arg1)
		if arg1 == 1 then
			isCheckedStatusTextBothCondensed = "Bar"
			isCheckedBar = true
			isCheckedBrackets = false
			isCheckedDash = false
			isCheckedParentheses = false
			isCheckedSlash = false

			if eufCharacterDB.enabled then
				eufCharacterDB.statusTextBothCondensedBar = true
				eufCharacterDB.statusTextBothCondensedBrackets = false
				eufCharacterDB.statusTextBothCondensedDash = false
				eufCharacterDB.statusTextBothCondensedParentheses = false
				eufCharacterDB.statusTextBothCondensedSlash = false
			else
				eufDB.statusTextBothCondensedBar = true
				eufDB.statusTextBothCondensedBrackets = false
				eufDB.statusTextBothCondensedDash = false
				eufDB.statusTextBothCondensedParentheses = false
				eufDB.statusTextBothCondensedSlash = false
			end

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(statusTextBothCondensedDropdown, isCheckedStatusTextBothCondensed)
		elseif arg1 == 2 then
			isCheckedStatusTextBothCondensed = "Brackets"
			isCheckedBar = false
			isCheckedBrackets = true
			isCheckedDash = false
			isCheckedParentheses = false
			isCheckedSlash = false

			if eufCharacterDB.enabled then
				eufCharacterDB.statusTextBothCondensedBar = false
				eufCharacterDB.statusTextBothCondensedBrackets = true
				eufCharacterDB.statusTextBothCondensedDash = false
				eufCharacterDB.statusTextBothCondensedParentheses = false
				eufCharacterDB.statusTextBothCondensedSlash = false
			else
				eufDB.statusTextBothCondensedBar = false
				eufDB.statusTextBothCondensedBrackets = true
				eufDB.statusTextBothCondensedDash = false
				eufDB.statusTextBothCondensedParentheses = false
				eufDB.statusTextBothCondensedSlash = false
			end

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(statusTextBothCondensedDropdown, isCheckedStatusTextBothCondensed)
		elseif arg1 == 3 then
			isCheckedStatusTextBothCondensed = "Dash"
			isCheckedBar = false
			isCheckedBrackets = false
			isCheckedDash = true
			isCheckedParentheses = false
			isCheckedSlash = false

			if eufCharacterDB.enabled then
				eufCharacterDB.statusTextBothCondensedBar = false
				eufCharacterDB.statusTextBothCondensedBrackets = false
				eufCharacterDB.statusTextBothCondensedDash = true
				eufCharacterDB.statusTextBothCondensedParentheses = false
				eufCharacterDB.statusTextBothCondensedSlash = false
			else
				eufDB.statusTextBothCondensedBar = false
				eufDB.statusTextBothCondensedBrackets = false
				eufDB.statusTextBothCondensedDash = true
				eufDB.statusTextBothCondensedParentheses = false
				eufDB.statusTextBothCondensedSlash = false
			end

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(statusTextBothCondensedDropdown, isCheckedStatusTextBothCondensed)
		elseif arg1 == 4 then
			isCheckedStatusTextBothCondensed = "Parentheses"
			isCheckedBar = false
			isCheckedBrackets = false
			isCheckedDash = false
			isCheckedParentheses = true
			isCheckedSlash = false

			if eufCharacterDB.enabled then
				eufCharacterDB.statusTextBothCondensedBar = false
				eufCharacterDB.statusTextBothCondensedBrackets = false
				eufCharacterDB.statusTextBothCondensedDash = false
				eufCharacterDB.statusTextBothCondensedParentheses = true
				eufCharacterDB.statusTextBothCondensedSlash = false
			else
				eufDB.statusTextBothCondensedBar = false
				eufDB.statusTextBothCondensedBrackets = false
				eufDB.statusTextBothCondensedDash = false
				eufDB.statusTextBothCondensedParentheses = true
				eufDB.statusTextBothCondensedSlash = false
			end

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(statusTextBothCondensedDropdown, isCheckedStatusTextBothCondensed)
		elseif arg1 == 5 then
			isCheckedStatusTextBothCondensed = "Slash"
			isCheckedBar = false
			isCheckedBrackets = false
			isCheckedDash = false
			isCheckedParentheses = false
			isCheckedSlash = true

			if eufCharacterDB.enabled then
				eufCharacterDB.statusTextBothCondensedBar = false
				eufCharacterDB.statusTextBothCondensedBrackets = false
				eufCharacterDB.statusTextBothCondensedDash = false
				eufCharacterDB.statusTextBothCondensedParentheses = false
				eufCharacterDB.statusTextBothCondensedSlash = true
			else
				eufDB.statusTextBothCondensedBar = false
				eufDB.statusTextBothCondensedBrackets = false
				eufDB.statusTextBothCondensedDash = false
				eufDB.statusTextBothCondensedParentheses = false
				eufDB.statusTextBothCondensedSlash = true
			end

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(statusTextBothCondensedDropdown, isCheckedStatusTextBothCondensed)
		end
	end

	local function statusTextBothCondensedDropdownMenu(frame, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		info.func = statusTextBothCondensedDropdownOnClick

		info.text, info.arg1, info.checked = "Bar", 1, isCheckedBar
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Brackets", 2, isCheckedBrackets
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Dash", 3, isCheckedDash
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Parentheses", 4, isCheckedParentheses
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Slash", 5, isCheckedSlash
		UIDropDownMenu_AddButton(info)
	end

	UIDropDownMenu_Initialize(statusTextBothCondensedDropdown, statusTextBothCondensedDropdownMenu)

	-- Initializes the options panel with saved variables.

	if eufCharacterDB.enabled then
		if eufCharacterDB.hidePetStatusText == true then
			hidePetStatusTextCheckbox:SetChecked(true)
		end
	else
		if eufDB.hidePetStatusText == true then
			hidePetStatusTextCheckbox:SetChecked(true)
		end
	end

	self:SetScript("OnShow", nil)
end)
