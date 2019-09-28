-- Creates the options panel.

eufOptions = CreateFrame("Frame", "eufOptionsPanel", UIParent)
eufOptions.general = CreateFrame("Frame", "eufOptionsGeneral", eufOptions)
eufOptions.color = CreateFrame("Frame", "eufOptionsColor", eufOptions)
eufOptions.scaling = CreateFrame("Frame", "eufOptionsPanelScaling", eufOptions)
eufOptions.statusText = CreateFrame("Frame", "eufOptionsPanelStatusText", eufOptions)
eufOptions.name = "EnhancedUnitFrames"
eufOptions.general.name = "General"
eufOptions.color.name = "Color"
eufOptions.scaling.name = "Frame Scaling"
eufOptions.statusText.name = "Status Text"
eufOptions.general.parent = eufOptions.name
eufOptions.color.parent = eufOptions.name
eufOptions.scaling.parent = eufOptions.name
eufOptions.statusText.parent = eufOptions.name

InterfaceOptions_AddCategory(eufOptions)
InterfaceOptions_AddCategory(eufOptions.general)
InterfaceOptions_AddCategory(eufOptions.color)

if not isClassic() then
	eufOptions.healthBars = CreateFrame("Frame", "eufOptionsHealthBars", eufOptions)
	eufOptions.healthBars.name = "Health Bars"
	eufOptions.healthBars.parent = eufOptions.name

	InterfaceOptions_AddCategory(eufOptions.healthBars)

	eufOptions.healthBars:Hide()
end

InterfaceOptions_AddCategory(eufOptions.scaling)
InterfaceOptions_AddCategory(eufOptions.statusText)

eufOptions:Hide()
eufOptions.general:Hide()
eufOptions.color:Hide()
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

eufOptions:SetScript("OnShow", function(self)
	InterfaceOptionsFrame_OpenToCategory(eufOptions.general)
end)

-- Draws the general option panel elements.

eufOptions.general:SetScript("OnShow", function(self)
	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

	title:SetPoint("TOPLEFT", self, 16, -16)
	title:SetText("EnhancedUnitFrames")

	local description = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallOutline")

	description:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	description:SetText("Modifies the default unit frames for better visuals.")

	-- Creates checkboxes.

	characterDatabase = createCheckbox("characterDatabase", self, "Per-Character Configuration", "If enabled, this character's configuration will not affect the global configuration.")
	local wideTargetFrame = createCheckbox("wideTargetFrame", self, "Wide Target Frame", "Makes the target frame wider.\nSource: Wide Target by Gello.")

	if not isClassic() then
		wideFocusFrame = createCheckbox("wideFocusFrame", self, "Wide Focus Frame", "Makes the focus frame wider.\nSource: Wide Target by Gello.")
	end

	local mirroredPositioning = createCheckbox("mirroredPositioning", self, "Mirrored Positioning", "Allows the easy mirrored positioning of the player and target frames.\n1. Right-click the player frame.\n2. Hover over \"Move Frame\".\n3. Select \"Unlock Frame\" to begin.\nSource: Focused by haggen.")
	local classIconPortraits = createCheckbox("classIconPortraits", self, "Class Icon Portraits", "Changes the unit frame portraits to the unit's class icon.")
	local fontOutline = createCheckbox("fontOutline", self, "Font Outline", "Gives text strings modified by the \"Color\" section outlines to improve visibility.")
	local hideRealmName = createCheckbox("hideRealmName", self, "Hide Realm Name", "Hides unit frame realm names and labels.")
	local hideNameBackground = createCheckbox("hideNameBackground", self, "Hide Name BG", "Hides the unit frame name background.")
	local hideHitIndicator = createCheckbox("hideHitIndicator", self, "Hide Hit Indicator", "Hides the damage/healing indicator on player and pet frames.")
	local hideRestingIcon = createCheckbox("hideRestingIcon", self, "Hide Resting Icon", "Hides the resting icon on the player frame.")

	if isClassic() then
		shamanClassColorFix = createCheckbox("shamanClassColorFix", self, "Shaman Class Color Fix", "Changes the Shaman class color to reflect live.")
	else
		threatShowNumeric = createCheckbox("threatShowNumeric", self, "Show Numeric Threat", "Shows a numerical target threat indicator on the player frame.\nRequires \"Threat Warning\" to be enabled to display.")
	end

	-- Positions the checkboxes created.

	characterDatabase:SetPoint("RIGHT", title, 50, 0)

	wideTargetFrame:SetPoint("TOPLEFT", description, "BOTTOMLEFT", -2, -22)

	if not isClassic() then
		wideFocusFrame:SetPoint("TOPLEFT", wideTargetFrame, "BOTTOMLEFT", 0, -8)
		mirroredPositioning:SetPoint("TOPLEFT", wideFocusFrame, "BOTTOMLEFT", 0, -8)
	else
		mirroredPositioning:SetPoint("TOPLEFT", wideTargetFrame, "BOTTOMLEFT", 0, -8)
	end

	classIconPortraits:SetPoint("TOPLEFT", mirroredPositioning, "BOTTOMLEFT", 0, -8)
	fontOutline:SetPoint("TOPLEFT", classIconPortraits, "BOTTOMLEFT", 0, -8)
	hideRealmName:SetPoint("TOPLEFT", fontOutline, "BOTTOMLEFT", 0, -8)
	hideNameBackground:SetPoint("TOPLEFT", hideRealmName, "BOTTOMLEFT", 0, -8)
	hideHitIndicator:SetPoint("TOPLEFT", hideNameBackground, "BOTTOMLEFT", 0, -8)
	hideRestingIcon:SetPoint("TOPLEFT", hideHitIndicator, "BOTTOMLEFT", 0, -8)

	if isClassic() then
		shamanClassColorFix:SetPoint("TOPLEFT", hideRestingIcon, "BOTTOMLEFT", 0, -8)
	else
		threatShowNumeric:SetPoint("TOPLEFT", hideRestingIcon, "BOTTOMLEFT", 0, -8)
	end

	-- Applies scripts to the checkboxes.

	characterDatabase:SetScript("OnClick", function(self)
		if self:GetChecked() then
			eufCharacterDB.enabled = true

			PlaySound(856)
		else
			eufCharacterDB.enabled = false

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	wideTargetFrame:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.wideTargetFrame = true
			else
				eufDB.wideTargetFrame = true
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

	if not isClassic() then
		wideFocusFrame:SetScript("OnClick", function(self)
			if self:GetChecked() then
				if eufCharacterDB.enabled then
					eufCharacterDB.wideFocusFrame = true
				else
					eufDB.wideFocusFrame = true
				end

				PlaySound(856)
			else
				if eufCharacterDB.enabled then
					eufCharacterDB.wideFocusFrame = false
				else
					eufDB.wideFocusFrame = false
				end
			
				PlaySound(857)
			end

			StaticPopup_Show("RELOAD_UI")
		end)
	end			

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

	fontOutline:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.fontOutline = true
			else
				eufDB.fontOutline = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.fontOutline = false
			else
				eufDB.fontOutline = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	hideRealmName:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.hideRealmName = true
			else
				eufDB.hideRealmName = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.hideRealmName = false
			else
				eufDB.hideRealmName = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	hideNameBackground:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.hideNameBackground = true
			else
				eufDB.hideNameBackground = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.hideNameBackground = false
			else
				eufDB.hideNameBackground = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	hideHitIndicator:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.hideHitIndicator = true
			else
				eufDB.hideHitIndicator = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.hideHitIndicator = false
			else
				eufDB.hideHitIndicator = false
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

	local playerFrameTextureDropdown = CreateFrame("Frame", "eufPlayerFrameTextureDropdown", self, "UIDropDownMenuTemplate")
	playerFrameTextureDropdown.title = playerFrameTextureDropdown:CreateFontString("playerFrameTextureDropdownLabel", "ARTWORK", "GameFontNormal")

	playerFrameTextureDropdown:SetPoint("TOPLEFT", wideTargetFrame, "BOTTOMLEFT", 273, 8)
	playerFrameTextureDropdown.title:SetPoint("BOTTOMLEFT", playerFrameTextureDropdown, "TOPLEFT", 15, 3)
	playerFrameTextureDropdown.title:SetText("Player Frame Texture")

	playerFrameTextureDropdown:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -17, 1)
		GameTooltip:SetText("Player Frame Texture", nil, nil, nil, 1, true)
		GameTooltip:AddLine("Changes the player frame to use the default, elite, rare, or rare-elite texture.", 1, 1, 1, 1)
		GameTooltip:Show()
	end)

	playerFrameTextureDropdown:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	UIDropDownMenu_SetWidth(playerFrameTextureDropdown, 160)

	if eufCharacterDB.enabled then
		if eufCharacterDB.elitePlayerFrame == true then
			isCheckedPlayerFrameTexture = "Elite Player Texture"
			isCheckedEliteTexture = true
		elseif eufCharacterDB.rarePlayerFrame == true then
			isCheckedPlayerFrameTexture = "Rare Player Texture"
			isCheckedRareTexture = true
		elseif eufCharacterDB.rareElitePlayerFrame == true then
			isCheckedPlayerFrameTexture = "Rare Elite Player Texture"
			isCheckedRareEliteTexture = true
		else
			isCheckedPlayerFrameTexture = "Default Player Texture"
			isCheckedDefaultTexture = true
		end
	else
		if eufDB.elitePlayerFrame == true then
			isCheckedPlayerFrameTexture = "Elite Player Texture"
			isCheckedEliteTexture = true
		elseif eufDB.rarePlayerFrame == true then
			isCheckedPlayerFrameTexture = "Rare Player Texture"
			isCheckedRareTexture = true
		elseif eufDB.rareElitePlayerFrame == true then
			isCheckedPlayerFrameTexture = "Rare Elite Player Texture"
			isCheckedRareEliteTexture = true
		else
			isCheckedPlayerFrameTexture = "Default Player Texture"
			isCheckedDefaultTexture = true
		end
	end

	UIDropDownMenu_SetText(playerFrameTextureDropdown, isCheckedPlayerFrameTexture)

	local function playerFrameTextureDropdownMenuOnClick(self, arg1)
		if arg1 == 1 then
			isCheckedPlayerFrameTexture = "Elite Player Texture"
			isCheckedEliteTexture = true
			isCheckedRareTexture = false
			isCheckedRareEliteTexture = false
			isCheckedDefaultTexture = false

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
			UIDropDownMenu_SetText(playerFrameTextureDropdown, isCheckedPlayerFrameTexture)
		elseif arg1 == 2 then
			isCheckedPlayerFrameTexture = "Rare Player Texture"
			isCheckedEliteTexture = false
			isCheckedRareTexture = true
			isCheckedRareEliteTexture = false
			isCheckedDefaultTexture = false

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
			UIDropDownMenu_SetText(playerFrameTextureDropdown, isCheckedPlayerFrameTexture)
		elseif arg1 == 3 then
			isCheckedPlayerFrameTexture = "Rare Elite Player Texture"
			isCheckedEliteTexture = false
			isCheckedRareTexture = false
			isCheckedRareEliteTexture = true
			isCheckedDefaultTexture = false

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
			UIDropDownMenu_SetText(playerFrameTextureDropdown, isCheckedPlayerFrameTexture)
		elseif arg1 == 4 then
			isCheckedPlayerFrameTexture = "Default Player Texture"
			isCheckedEliteTexture = false
			isCheckedRareTexture = false
			isCheckedRareEliteTexture = false
			isCheckedDefaultTexture = true

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
			UIDropDownMenu_SetText(playerFrameTextureDropdown, isCheckedPlayerFrameTexture)
		end
	end

	local function playerFrameTextureDropdownMenu(frame, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		info.func = playerFrameTextureDropdownMenuOnClick

		info.text, info.arg1, info.checked = "Elite Player Texture", 1, isCheckedEliteTexture
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Rare Player Texture", 2, isCheckedRareTexture
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Rare Elite Player Texture", 3, isCheckedRareEliteTexture
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Default Player Texture", 4, isCheckedDefaultTexture
		UIDropDownMenu_AddButton(info)
	end

	UIDropDownMenu_Initialize(playerFrameTextureDropdown, playerFrameTextureDropdownMenu)

	-- Player frame style dropdown menu.

	local playerFrameStyleDropdown = CreateFrame("Frame", "eufPlayerFrameStyleDropdown", self, "UIDropDownMenuTemplate")
	playerFrameStyleDropdown.title = playerFrameStyleDropdown:CreateFontString("playerFrameStyleDropdownLabel", "ARTWORK", "GameFontNormal")

	playerFrameStyleDropdown:SetPoint("TOPLEFT", playerFrameTextureDropdown, "BOTTOMLEFT", 0, -37)
	playerFrameStyleDropdown.title:SetPoint("BOTTOMLEFT", playerFrameStyleDropdown, "TOPLEFT", 15, 3)
	playerFrameStyleDropdown.title:SetText("Player Frame Style")

	playerFrameStyleDropdown:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -17, 1)
		GameTooltip:SetText("Player Frame Style", nil, nil, nil, 1, true)
		GameTooltip:AddLine("Changes the player frame to use the whoa, big, or default style.", 1, 1, 1, 1)
		GameTooltip:Show()
	end)

	playerFrameStyleDropdown:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	UIDropDownMenu_SetWidth(playerFrameStyleDropdown, 160)

	if eufCharacterDB.enabled then
		if eufCharacterDB.whoaPlayerFrame == true then
			isCheckedPlayerFrameStyle = "Whoa Player Style"
			isCheckedPlayerWhoaStyle = true
		elseif eufCharacterDB.bigPlayerFrame == true then
			isCheckedPlayerFrameStyle = "Big Player Style"
			isCheckedPlayerBigStyle = true
		elseif eufCharacterDB.defaultPlayerFrame == true then
			isCheckedPlayerFrameStyle = "Default Player Style"
			isCheckedPlayerDefaultStyle = true
		end
	else
		if eufDB.whoaPlayerFrame == true then
			isCheckedPlayerFrameStyle = "Whoa Player Style"
			isCheckedPlayerWhoaStyle = true
		elseif eufDB.bigPlayerFrame == true then
			isCheckedPlayerFrameStyle = "Big Player Style"
			isCheckedPlayerBigStyle = true
		elseif eufDB.defaultPlayerFrame == true then
			isCheckedPlayerFrameStyle = "Default Player Style"
			isCheckedPlayerDefaultStyle = true
		end
	end

	UIDropDownMenu_SetText(playerFrameStyleDropdown, isCheckedPlayerFrameStyle)

	local function playerFrameStyleDropdownMenuOnClick(self, arg1)
		if arg1 == 1 then
			isCheckedPlayerFrameStyle = "Whoa Player Style"
			isCheckedPlayerWhoaStyle = true
			isCheckedPlayerBigStyle = false
			isCheckedPlayerDefaultStyle = false

			if eufCharacterDB.enabled then
				eufCharacterDB.whoaPlayerFrame = true
				eufCharacterDB.bigPlayerFrame = false
				eufCharacterDB.defaultPlayerFrame = false
			else
				eufDB.whoaPlayerFrame = true
				eufDB.bigPlayerFrame = false
				eufDB.defaultPlayerFrame = false
			end

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameStyleDropdown, isCheckedPlayerFrameStyle)
		elseif arg1 == 2 then
			isCheckedPlayerFrameStyle = "Big Player Style"
			isCheckedPlayerWhoaStyle = false
			isCheckedPlayerBigStyle = true
			isCheckedPlayerDefaultStyle = false

			if eufCharacterDB.enabled then
				eufCharacterDB.whoaPlayerFrame = false
				eufCharacterDB.bigPlayerFrame = true
				eufCharacterDB.defaultPlayerFrame = false
			else
				eufDB.whoaPlayerFrame = false
				eufDB.bigPlayerFrame = true
				eufDB.defaultPlayerFrame = false
			end

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameStyleDropdown, isCheckedPlayerFrameStyle)
		elseif arg1 == 3 then
			isCheckedPlayerFrameStyle = "Default Player Style"
			isCheckedPlayerWhoaStyle = false
			isCheckedPlayerBigStyle = false
			isCheckedPlayerDefaultStyle = true

			if eufCharacterDB.enabled then
				eufCharacterDB.whoaPlayerFrame = false
				eufCharacterDB.bigPlayerFrame = false
				eufCharacterDB.defaultPlayerFrame = true
			else
				eufDB.whoaPlayerFrame = false
				eufDB.bigPlayerFrame = false
				eufDB.defaultPlayerFrame = true
			end

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(playerFrameStyleDropdown, isCheckedPlayerFrameStyle)
		end
	end

	local function playerFrameStyleDropdownMenu(frame, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		info.func = playerFrameStyleDropdownMenuOnClick

		info.text, info.arg1, info.checked = "Whoa Player Style", 1, isCheckedPlayerWhoaStyle
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Big Player Style", 2, isCheckedPlayerBigStyle
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Default Player Style", 3, isCheckedPlayerDefaultStyle
		UIDropDownMenu_AddButton(info)
	end

	UIDropDownMenu_Initialize(playerFrameStyleDropdown, playerFrameStyleDropdownMenu)

	-- Target frame style dropdown menu.

	local targetFrameStyleDropdown = CreateFrame("Frame", "eufTargetFrameStyleDropdown", self, "UIDropDownMenuTemplate")
	targetFrameStyleDropdown.title = targetFrameStyleDropdown:CreateFontString("targetFrameStyleDropdownLabel", "ARTWORK", "GameFontNormal")

	targetFrameStyleDropdown:SetPoint("TOPLEFT", playerFrameStyleDropdown, "BOTTOMLEFT", 0, -37)
	targetFrameStyleDropdown.title:SetPoint("BOTTOMLEFT", targetFrameStyleDropdown, "TOPLEFT", 15, 3)
	targetFrameStyleDropdown.title:SetText("Target Frame Style")

	targetFrameStyleDropdown:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -17, 1)
		GameTooltip:SetText("Target Frame Style", nil, nil, nil, 1, true)
		GameTooltip:AddLine("Changes the target frame to use the whoa, big, or default style.", 1, 1, 1, 1)
		GameTooltip:Show()
	end)

	targetFrameStyleDropdown:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	UIDropDownMenu_SetWidth(targetFrameStyleDropdown, 160)

	if eufCharacterDB.enabled then
		if eufCharacterDB.whoaTargetFrame == true then
			isCheckedTargetFrameStyle = "Whoa Target Style"
			isCheckedTargetWhoaStyle = true
		elseif eufCharacterDB.bigTargetFrame == true then
			isCheckedTargetFrameStyle = "Big Target Style"
			isCheckedTargetBigStyle = true
		elseif eufCharacterDB.defaultTargetFrame == true then
			isCheckedTargetFrameStyle = "Default Target Style"
			isCheckedTargetDefaultStyle = true
		end
	else
		if eufDB.whoaTargetFrame == true then
			isCheckedTargetFrameStyle = "Whoa Target Style"
			isCheckedTargetWhoaStyle = true
		elseif eufDB.bigTargetFrame == true then
			isCheckedTargetFrameStyle = "Big Target Style"
			isCheckedTargetBigStyle = true
		elseif eufDB.defaultTargetFrame == true then
			isCheckedTargetFrameStyle = "Default Target Style"
			isCheckedTargetDefaultStyle = true
		end
	end

	UIDropDownMenu_SetText(targetFrameStyleDropdown, isCheckedTargetFrameStyle)

	local function targetFrameStyleDropdownMenuOnClick(self, arg1)
		if arg1 == 1 then
			isCheckedTargetFrameStyle = "Whoa Target Style"
			isCheckedTargetWhoaStyle = true
			isCheckedTargetBigStyle = false
			isCheckedTargetDefaultStyle = false

			if eufCharacterDB.enabled then
				eufCharacterDB.whoaTargetFrame = true
				eufCharacterDB.bigTargetFrame = false
				eufCharacterDB.defaultTargetFrame = false
			else
				eufDB.whoaTargetFrame = true
				eufDB.bigTargetFrame = false
				eufDB.defaultTargetFrame = false
			end

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(targetFrameStyleDropdown, isCheckedTargetFrameStyle)
		elseif arg1 == 2 then
			isCheckedTargetFrameStyle = "Big Target Style"
			isCheckedTargetWhoaStyle = false
			isCheckedTargetBigStyle = true
			isCheckedTargetDefaultStyle = false

			if eufCharacterDB.enabled then
				eufCharacterDB.whoaTargetFrame = false
				eufCharacterDB.bigTargetFrame = true
				eufCharacterDB.defaultTargetFrame = false
			else
				eufDB.whoaTargetFrame = false
				eufDB.bigTargetFrame = true
				eufDB.defaultTargetFrame = false
			end

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(targetFrameStyleDropdown, isCheckedTargetFrameStyle)
		elseif arg1 == 3 then
			isCheckedTargetFrameStyle = "Default Target Style"
			isCheckedTargetWhoaStyle = false
			isCheckedTargetBigStyle = false
			isCheckedTargetDefaultStyle = true

			if eufCharacterDB.enabled then
				eufCharacterDB.whoaTargetFrame = false
				eufCharacterDB.bigTargetFrame = false
				eufCharacterDB.defaultTargetFrame = true
			else
				eufDB.whoaTargetFrame = false
				eufDB.bigTargetFrame = false
				eufDB.defaultTargetFrame = true
			end

			StaticPopup_Show("RELOAD_UI")
			UIDropDownMenu_SetText(targetFrameStyleDropdown, isCheckedTargetFrameStyle)
		end
	end

	local function targetFrameStyleDropdownMenu(frame, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		info.func = targetFrameStyleDropdownMenuOnClick

		info.text, info.arg1, info.checked = "Whoa Target Style", 1, isCheckedTargetWhoaStyle
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Big Target Style", 2, isCheckedTargetBigStyle
		UIDropDownMenu_AddButton(info)
		info.text, info.arg1, info.checked = "Default Target Style", 3, isCheckedTargetDefaultStyle
		UIDropDownMenu_AddButton(info)
	end

	UIDropDownMenu_Initialize(targetFrameStyleDropdown, targetFrameStyleDropdownMenu)

	if not isClassic() then
		-- Focus frame style dropdown menu.

		local focusFrameStyleDropdown = CreateFrame("Frame", "eufFocusFrameStyleDropdown", self, "UIDropDownMenuTemplate")
		focusFrameStyleDropdown.title = focusFrameStyleDropdown:CreateFontString("focusFrameStyleDropdownLabel", "ARTWORK", "GameFontNormal")

		focusFrameStyleDropdown:SetPoint("TOPLEFT", targetFrameStyleDropdown, "BOTTOMLEFT", 0, -37)
		focusFrameStyleDropdown.title:SetPoint("BOTTOMLEFT", focusFrameStyleDropdown, "TOPLEFT", 15, 3)
		focusFrameStyleDropdown.title:SetText("Focus Frame Style")

		focusFrameStyleDropdown:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -17, 1)
			GameTooltip:SetText("Focus Frame Style", nil, nil, nil, 1, true)
			GameTooltip:AddLine("Changes the focus frame to use the whoa, big, or default style.", 1, 1, 1, 1)
			GameTooltip:Show()
		end)

		focusFrameStyleDropdown:SetScript("OnLeave", function(self)
			GameTooltip:Hide()
		end)

		UIDropDownMenu_SetWidth(focusFrameStyleDropdown, 160)

		if eufCharacterDB.enabled then
			if eufCharacterDB.whoaFocusFrame == true then
				isCheckedFocusFrameStyle = "Whoa Focus Style"
				isCheckedFocusWhoaStyle = true
			elseif eufCharacterDB.bigFocusFrame == true then
				isCheckedFocusFrameStyle = "Big Focus Style"
				isCheckedFocusBigStyle = true
			elseif eufCharacterDB.defaultFocusFrame == true then
				isCheckedFocusFrameStyle = "Default Focus Style"
				isCheckedFocusDefaultStyle = true
			end
		else
			if eufDB.whoaFocusFrame == true then
				isCheckedFocusFrameStyle = "Whoa Focus Style"
				isCheckedFocusWhoaStyle = true
			elseif eufDB.bigFocusFrame == true then
				isCheckedFocusFrameStyle = "Big Focus Style"
				isCheckedFocusBigStyle = true
			elseif eufDB.defaultFocusFrame == true then
				isCheckedFocusFrameStyle = "Default Focus Style"
				isCheckedFocusDefaultStyle = true
			end
		end

		UIDropDownMenu_SetText(focusFrameStyleDropdown, isCheckedFocusFrameStyle)

		local function focusFrameStyleDropdownMenuOnClick(self, arg1)
			if arg1 == 1 then
				isCheckedFocusFrameStyle = "Whoa Focus Style"
				isCheckedFocusWhoaStyle = true
				isCheckedFocusBigStyle = false
				isCheckedFocusDefaultStyle = false

				if eufCharacterDB.enabled then
					eufCharacterDB.whoaFocusFrame = true
					eufCharacterDB.bigFocusFrame = false
					eufCharacterDB.defaultFocusFrame = false
				else
					eufDB.whoaFocusFrame = true
					eufDB.bigFocusFrame = false
					eufDB.defaultFocusFrame = false
				end

				StaticPopup_Show("RELOAD_UI")
				UIDropDownMenu_SetText(focusFrameStyleDropdown, isCheckedFocusFrameStyle)
			elseif arg1 == 2 then
				isCheckedFocusFrameStyle = "Big Focus Style"
				isCheckedFocusWhoaStyle = false
				isCheckedFocusBigStyle = true
				isCheckedFocusDefaultStyle = false

				if eufCharacterDB.enabled then
					eufCharacterDB.whoaFocusFrame = false
					eufCharacterDB.bigFocusFrame = true
					eufCharacterDB.defaultFocusFrame = false
				else
					eufDB.whoaFocusFrame = false
					eufDB.bigFocusFrame = true
					eufDB.defaultFocusFrame = false
				end

				StaticPopup_Show("RELOAD_UI")
				UIDropDownMenu_SetText(focusFrameStyleDropdown, isCheckedFocusFrameStyle)
			elseif arg1 == 3 then
				isCheckedFocusFrameStyle = "Default Focus Style"
				isCheckedFocusWhoaStyle = false
				isCheckedFocusBigStyle = false
				isCheckedFocusDefaultStyle = true

				if eufCharacterDB.enabled then
					eufCharacterDB.whoaFocusFrame = false
					eufCharacterDB.bigFocusFrame = false
					eufCharacterDB.defaultFocusFrame = true
				else
					eufDB.whoaFocusFrame = false
					eufDB.bigFocusFrame = false
					eufDB.defaultFocusFrame = true
				end

				StaticPopup_Show("RELOAD_UI")
				UIDropDownMenu_SetText(focusFrameStyleDropdown, isCheckedFocusFrameStyle)
			end
		end

		local function focusFrameStyleDropdownMenu(frame, level, menuList)
			local info = UIDropDownMenu_CreateInfo()
			info.func = focusFrameStyleDropdownMenuOnClick

			info.text, info.arg1, info.checked = "Whoa Focus Style", 1, isCheckedFocusWhoaStyle
			UIDropDownMenu_AddButton(info)
			info.text, info.arg1, info.checked = "Big Focus Style", 2, isCheckedFocusBigStyle
			UIDropDownMenu_AddButton(info)
			info.text, info.arg1, info.checked = "Default Focus Style", 3, isCheckedFocusDefaultStyle
			UIDropDownMenu_AddButton(info)
		end

		UIDropDownMenu_Initialize(focusFrameStyleDropdown, focusFrameStyleDropdownMenu)

		-- Threat warning dropdown menu.

		threatWarningDropdown = CreateFrame("Frame", "eufThreatWarningDropdown", self, "UIDropDownMenuTemplate")
		threatWarningDropdown.title = threatWarningDropdown:CreateFontString("threatWarningDropdownLabel", "ARTWORK", "GameFontNormal")

		threatWarningDropdown:SetPoint("TOPLEFT", focusFrameStyleDropdown, "BOTTOMLEFT", 0, -37)
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

		if not isClassic() then
			if eufCharacterDB.wideFocusFrame == true then
				wideFocusFrameCheckbox:SetChecked(true)
			end
		end

		if eufCharacterDB.mirroredPositioning == true then
			mirroredPositioningCheckbox:SetChecked(true)
		end

		if eufCharacterDB.classIconPortraits == true then
			classIconPortraitsCheckbox:SetChecked(true)
		end

		if eufCharacterDB.fontOutline == true then
			fontOutlineCheckbox:SetChecked(true)
		end

		if eufCharacterDB.hideRealmName == true then
			hideRealmNameCheckbox:SetChecked(true)
		end

		if eufCharacterDB.hideNameBackground == true then
			hideNameBackgroundCheckbox:SetChecked(true)
		end

		if eufCharacterDB.hideHitIndicator == true then
			hideHitIndicatorCheckbox:SetChecked(true)
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

		if not isClassic() then
			if eufDB.wideFocusFrame == true then
				wideFocusFrameCheckbox:SetChecked(true)
			end
		end

		if eufDB.mirroredPositioning == true then
			mirroredPositioningCheckbox:SetChecked(true)
		end

		if eufDB.classIconPortraits == true then
			classIconPortraitsCheckbox:SetChecked(true)
		end

		if eufDB.fontOutline == true then
			fontOutlineCheckbox:SetChecked(true)
		end

		if eufDB.hideRealmName == true then
			hideRealmNameCheckbox:SetChecked(true)
		end

		if eufDB.hideNameBackground == true then
			hideNameBackgroundCheckbox:SetChecked(true)
		end

		if eufDB.hideHitIndicator == true then
			hideHitIndicatorCheckbox:SetChecked(true)
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

-- Draws the color option panel elements.

eufOptions.color:SetScript("OnShow", function(self)
	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

	title:SetPoint("TOPLEFT", self, 16, -16)
	title:SetText("EnhancedUnitFrames")

	local description = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallOutline")

	description:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	description:SetText("Modifies the default unit frames for better visuals.")

	-- Creates checkboxes.

	local classHealthBarColor = createCheckbox("classHealthBarColor", self, "Class Color HP", "Changes the unit frame health bar colors to the unit's class color.")
	local reactionHealthBarColor = createCheckbox("reactionHealthBarColor", self, "Reaction Color HP", "Changes the unit frame health bar colors to the unit's reaction color.")
	local classNameColor = createCheckbox("classNameColor", self, "Class Color Name", "Changes the unit frame name color to the unit's class color.")
	local reactionNameColor = createCheckbox("reactionNameColor", self, "Reaction Color Name", "Changes the unit frame name color to the unit's reaction color.")
	local classNameBackgroundColor = createCheckbox("classNameBackgroundColor", self, "Class Color Name BG", "Changes the unit frame name background color to the unit's class color.")
	local reactionNameBackgroundColor = createCheckbox("reactionNameBackgroundColor", self, "Reaction Color Name BG", "Changes the unit frame name background color to the unit's reaction color.")
	local classLevelTextColor = createCheckbox("classLevelTextColor", self, "Class Color Level Text", "Changes the unit frame level text color to the unit's class color.")
	local reactionLevelTextColor = createCheckbox("reactionLevelTextColor", self, "Reaction Color Level Text", "Changes the unit frame level text color to the unit's reaction color.")
	local classDeadTextColor = createCheckbox("classDeadTextColor", self, "Class Color Dead Text", "Changes the unit frame dead text color to the unit's class color.")
	local reactionDeadTextColor = createCheckbox("reactionDeadTextColor", self, "Reaction Color Dead Text", "Changes the unit frame dead text color to the unit's reaction color.")
	local classPvPTimerTextColor = createCheckbox("classPvPTimerTextColor", self, "Class Color PvP Timer Text", "Changes the player frame PvP timer text to the player's class color.")

	-- Positions the checkboxes created.

	classHealthBarColor:SetPoint("TOPLEFT", description, "BOTTOMLEFT", -2, -22)
	reactionHealthBarColor:SetPoint("TOPLEFT", classHealthBarColor, "BOTTOMLEFT", 0, -8)
	classNameColor:SetPoint("TOPLEFT", reactionHealthBarColor, "BOTTOMLEFT", 0, -8)
	reactionNameColor:SetPoint("TOPLEFT", classNameColor, "BOTTOMLEFT", 0, -8)
	classNameBackgroundColor:SetPoint("TOPLEFT", reactionNameColor, "BOTTOMLEFT", 0, -8)
	reactionNameBackgroundColor:SetPoint("TOPLEFT", classNameBackgroundColor, "BOTTOMLEFT", 0, -8)
	classLevelTextColor:SetPoint("TOPLEFT", reactionNameBackgroundColor, "BOTTOMLEFT", 0, -8)
	reactionLevelTextColor:SetPoint("TOPLEFT", classLevelTextColor, "BOTTOMLEFT", 0, -8)
	classDeadTextColor:SetPoint("TOPLEFT", reactionLevelTextColor, "BOTTOMLEFT", 0, -8)
	reactionDeadTextColor:SetPoint("TOPLEFT", classDeadTextColor, "BOTTOMLEFT", 0, -8)
	classPvPTimerTextColor:SetPoint("TOPLEFT", reactionDeadTextColor, "BOTTOMLEFT", 0, -8)

	-- Applies scripts to the checkboxes.

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

	classNameColor:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.classNameColor = true
			else
				eufDB.classNameColor = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.classNameColor = false
			else
				eufDB.classNameColor = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	reactionNameColor:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.reactionNameColor = true
			else
				eufDB.reactionNameColor = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.reactionNameColor = false
			else
				eufDB.reactionNameColor = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	classNameBackgroundColor:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.classNameBackgroundColor = true
			else
				eufDB.classNameBackgroundColor = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.classNameBackgroundColor = false
			else
				eufDB.classNameBackgroundColor = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	reactionNameBackgroundColor:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.reactionNameBackgroundColor = true
			else
				eufDB.reactionNameBackgroundColor = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.reactionNameBackgroundColor = false
			else
				eufDB.reactionNameBackgroundColor = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	classLevelTextColor:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.classLevelTextColor = true
			else
				eufDB.classLevelTextColor = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.classLevelTextColor = false
			else
				eufDB.classLevelTextColor = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	reactionLevelTextColor:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.reactionLevelTextColor = true
			else
				eufDB.reactionLevelTextColor = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.reactionLevelTextColor = false
			else
				eufDB.reactionLevelTextColor = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	classDeadTextColor:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.classDeadTextColor = true
			else
				eufDB.classDeadTextColor = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.classDeadTextColor = false
			else
				eufDB.classDeadTextColor = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	reactionDeadTextColor:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.reactionDeadTextColor = true
			else
				eufDB.reactionDeadTextColor = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.reactionDeadTextColor = false
			else
				eufDB.reactionDeadTextColor = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	classPvPTimerTextColor:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.classPvPTimerTextColor = true
			else
				eufDB.classPvPTimerTextColor = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.classPvPTimerTextColor = false
			else
				eufDB.classPvPTimerTextColor = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	-- Initializes the options panel with saved variables.

	if eufCharacterDB.enabled then
		if eufCharacterDB.classHealthBarColor == true then
			classHealthBarColorCheckbox:SetChecked(true)
		end

		if eufCharacterDB.reactionHealthBarColor == true then
			reactionHealthBarColorCheckbox:SetChecked(true)
		end

		if eufCharacterDB.classNameColor == true then
			classNameColorCheckbox:SetChecked(true)
		end

		if eufCharacterDB.reactionNameColor == true then
			reactionNameColorCheckbox:SetChecked(true)
		end

		if eufCharacterDB.classNameBackgroundColor == true then
			classNameBackgroundColorCheckbox:SetChecked(true)
		end

		if eufCharacterDB.reactionNameBackgroundColor == true then
			reactionNameBackgroundColorCheckbox:SetChecked(true)
		end

		if eufCharacterDB.classLevelTextColor == true then
			classLevelTextColorCheckbox:SetChecked(true)
		end

		if eufCharacterDB.reactionLevelTextColor == true then
			reactionLevelTextColorCheckbox:SetChecked(true)
		end

		if eufCharacterDB.classDeadTextColor == true then
			classDeadTextColorCheckbox:SetChecked(true)
		end

		if eufCharacterDB.reactionDeadTextColor == true then
			reactionDeadTextColorCheckbox:SetChecked(true)
		end

		if eufCharacterDB.classPvPTimerTextColor == true then
			classPvPTimerTextColorCheckbox:SetChecked(true)
		end
	else
		if eufDB.classHealthBarColor == true then
			classHealthBarColorCheckbox:SetChecked(true)
		end

		if eufDB.reactionHealthBarColor == true then
			reactionHealthBarColorCheckbox:SetChecked(true)
		end

		if eufDB.classNameColor == true then
			classNameColorCheckbox:SetChecked(true)
		end

		if eufDB.reactionNameColor == true then
			reactionNameColorCheckbox:SetChecked(true)
		end

		if eufDB.classNameBackgroundColor == true then
			classNameBackgroundColorCheckbox:SetChecked(true)
		end

		if eufDB.reactionNameBackgroundColor == true then
			reactionNameBackgroundColorCheckbox:SetChecked(true)
		end

		if eufDB.classLevelTextColor == true then
			classLevelTextColorCheckbox:SetChecked(true)
		end

		if eufDB.reactionLevelTextColor == true then
			reactionLevelTextColorCheckbox:SetChecked(true)
		end

		if eufDB.classDeadTextColor == true then
			classDeadTextColorCheckbox:SetChecked(true)
		end

		if eufDB.reactionDeadTextColor == true then
			reactionDeadTextColorCheckbox:SetChecked(true)
		end

		if eufDB.classPvPTimerTextColor == true then
			classPvPTimerTextColor:SetChecked(true)
		end
	end

	self:SetScript("OnShow", nil)
end)

-- Draws the health bar option panel elements.

if not isClassic() then
	eufOptions.healthBars:SetScript("OnShow", function(self)
		local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

		title:SetPoint("TOPLEFT", self, 16, -16)
		title:SetText("EnhancedUnitFrames")

		local description = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallOutline")

		description:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
		description:SetText("Modifies the default unit frames for better visuals.")

		-- Creates checkboxes.

		local hidePowerAnimation = createCheckbox("hidePowerAnimation", self, "Hide Power Animations", "Hides the animation when the resource bar is full.")
		local predictedHealth = createCheckbox("predictedHealth", self, "Show Predicted Health", "Shows an animation when you lose health.")
		local showBuilderFeedback = createCheckbox("showBuilderFeedback", self, "Show Builder Feedback", "Shows an animation when you build your class resource.")
		local showSpenderFeedback = createCheckbox("showSpenderFeedback", self, "Show Spender Feedback", "Shows an animation when you spend your class resource.")

		-- Positions the checkboxes created.

		hidePowerAnimation:SetPoint("TOPLEFT", description, "BOTTOMLEFT", -2, -22)
		predictedHealth:SetPoint("TOPLEFT", hidePowerAnimation, "BOTTOMLEFT", 0, -8)
		showBuilderFeedback:SetPoint("TOPLEFT", predictedHealth, "BOTTOMLEFT", 0, -8)
		showSpenderFeedback:SetPoint("TOPLEFT", showBuilderFeedback, "BOTTOMLEFT", 0, -8)

		-- Applies scripts to the checkboxes.

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

		-- Initializes the options panel with saved variables.

		if eufCharacterDB.enabled then
			if eufCharacterDB.hidePowerAnimation == true then
				hidePowerAnimationCheckbox:SetChecked(true)
			end

			if C_CVar.GetCVar("predictedHealth") == "1" then
				predictedHealthCheckbox:SetChecked(true)
			end

			if C_CVar.GetCVar("showBuilderFeedback") == "1" then
				showBuilderFeedbackCheckbox:SetChecked(true)
			end

			if C_CVar.GetCVar("showSpenderFeedback") == "1" then
				showSpenderFeedbackCheckbox:SetChecked(true)
			end
		else
			if eufDB.hidePowerAnimation == true then
				hidePowerAnimationCheckbox:SetChecked(true)
			end

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
end

-- Draws the frame scaling option panel elements.

eufOptions.scaling:SetScript("OnShow", function(self)
	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

	title:SetPoint("TOPLEFT", self, 16, -16)
	title:SetText("EnhancedUnitFrames")

	local description = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallOutline")

	description:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	description:SetText("Modifies the default unit frames for better visuals.")

	-- Creates the focus frame width slider.

	if not isClassic() then
		wideFocusFrame = createSlider("wideFocusFrame", self, "Focus Width", 231, 400, 1, "Wide Focus Frame Width", "Changes the focus frame width.\nRequires \"Wide Focus Frame\" to be checked for changes to take effect.")
		wideFocusFrame:SetPoint("TOPLEFT", description, "BOTTOMLEFT", 1, -36)

		if eufCharacterDB.enabled then
			wideFocusFrameSlider:SetValue(eufCharacterDB.wideFocusFrameWidth)
			wideFocusFrameSliderEditbox:SetText(eufCharacterDB.wideFocusFrameWidth)
		else
			wideFocusFrameSlider:SetValue(eufDB.wideFocusFrameWidth)
			wideFocusFrameSliderEditbox:SetText(eufDB.wideFocusFrameWidth)
		end

		wideFocusFrame:HookScript("OnValueChanged", function(self, value)
			value = floor(value)

			if eufCharacterDB.enabled then
				eufCharacterDB.wideFocusFrameWidth = value
			else
				eufDB.wideFocusFrameWidth = value
			end
		end)
	end	

	-- Creates the target frame width slider.

	wideTargetFrame = createSlider("wideTargetFrame", self, "Target Width", 231, 400, 1, "Wide Target Frame Width", "Changes the target frame width.\nRequires \"Wide Target Frame\" to be checked for changes to take effect.")

	if isClassic() then
		wideTargetFrame:SetPoint("TOPLEFT", description, "BOTTOMLEFT", 1, -36)
	else
		wideTargetFrame:SetPoint("TOPLEFT", wideFocusFrame, "BOTTOMLEFT", 0, -70)
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

-- Draws the status text option panel elements.

eufOptions.statusText:SetScript("OnShow", function(self)
	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

	title:SetPoint("TOPLEFT", self, 16, -16)
	title:SetText("EnhancedUnitFrames")

	local description = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallOutline")

	description:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	description:SetText("Modifies the default unit frames for better visuals.")

	-- Creates checkboxes.

	local upperCaseAbbreviation = createCheckbox("upperCaseAbbreviation", self, "Uppercase Abbreviation", "Changes whether long status text numbers are abbreviated with a capital letter at the end or not.")

	if not isClassic() then
		hideArenaStatusText = createCheckbox("hideArenaStatusText", self, "Hide Arena Status Text", "Hides the arena frame status bar text.")
		hideBossStatusText = createCheckbox("hideBossStatusText", self, "Hide Boss Status Text", "Hides the boss frame status bar text.")
		hideFocusStatusText = createCheckbox("hideFocusStatusText", self, "Hide Focus Status Text", "Hides the focus frame status bar text.")
	end

	local hidePartyStatusText = createCheckbox("hidePartyStatusText", self, "Hide Party Status Text", "Hides the party frame status bar text.")
	local hidePetStatusText = createCheckbox("hidePetStatusText", self, "Hide Pet Status Text", "Hides the pet frame status bar text.")
	local hidePlayerStatusText = createCheckbox("hidePlayerStatusText", self, "Hide Player Status Text", "Hides the player frame status bar text.")
	local hidePowerBarStatusText = createCheckbox("hidePowerBarStatusText", self, "Hide Power Bar Status Text", "Hides the alternate power bar status bar text.")
	local hideTargetStatusText = createCheckbox("hideTargetStatusText", self, "Hide Target Status Text", "Hides the target frame status bar text.")

	-- Positions the checkboxes created.

	upperCaseAbbreviation:SetPoint("TOPLEFT", description, "BOTTOMLEFT", -2, -22)

	if not isClassic() then
		hideArenaStatusText:SetPoint("TOPLEFT", upperCaseAbbreviation, "BOTTOMLEFT", 0, -8)
		hideBossStatusText:SetPoint("TOPLEFT", hideArenaStatusText, "BOTTOMLEFT", 0, -8)
		hideFocusStatusText:SetPoint("TOPLEFT", hideBossStatusText, "BOTTOMLEFT", 0, -8)
		hidePartyStatusText:SetPoint("TOPLEFT", hideFocusStatusText, "BOTTOMLEFT", 0, -8)
	else
		hidePartyStatusText:SetPoint("TOPLEFT", upperCaseAbbreviation, "BOTTOMLEFT", 0, -8)
	end

	hidePetStatusText:SetPoint("TOPLEFT", hidePartyStatusText, "BOTTOMLEFT", 0, -8)
	hidePlayerStatusText:SetPoint("TOPLEFT", hidePetStatusText, "BOTTOMLEFT", 0, -8)
	hidePowerBarStatusText:SetPoint("TOPLEFT", hidePlayerStatusText, "BOTTOMLEFT", 0, -8)
	hideTargetStatusText:SetPoint("TOPLEFT", hidePowerBarStatusText, "BOTTOMLEFT", 0, -8)

	-- Applies scripts to the checkboxes.

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

	if not isClassic() then
		hideArenaStatusText:SetScript("OnClick", function(self)
			if self:GetChecked() then
				if eufCharacterDB.enabled then
					eufCharacterDB.hideArenaStatusText = true
				else
					eufDB.hideArenaStatusText = true
				end

				PlaySound(856)
			else
				if eufCharacterDB.enabled then
					eufCharacterDB.hideArenaStatusText = false
				else
					eufDB.hideArenaStatusText = false
				end

				PlaySound(857)
			end

			StaticPopup_Show("RELOAD_UI")
		end)

		hideBossStatusText:SetScript("OnClick", function(self)
			if self:GetChecked() then
				if eufCharacterDB.enabled then
					eufCharacterDB.hideBossStatusText = true
				else
					eufDB.hideBossStatusText = true
				end

				PlaySound(856)
			else
				if eufCharacterDB.enabled then
					eufCharacterDB.hideBossStatusText = false
				else
					eufDB.hideBossStatusText = false
				end

				PlaySound(857)
			end

			StaticPopup_Show("RELOAD_UI")
		end)

		hideFocusStatusText:SetScript("OnClick", function(self)
			if self:GetChecked() then
				if eufCharacterDB.enabled then
					eufCharacterDB.hideFocusStatusText = true
				else
					eufDB.hideFocusStatusText = true
				end

				PlaySound(856)
			else
				if eufCharacterDB.enabled then
					eufCharacterDB.hideFocusStatusText = false
				else
					eufDB.hideFocusStatusText = false
				end

				PlaySound(857)
			end

			StaticPopup_Show("RELOAD_UI")
		end)
	end

	hidePartyStatusText:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.hidePartyStatusText = true
			else
				eufDB.hidePartyStatusText = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.hidePartyStatusText = false
			else
				eufDB.hidePartyStatusText = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

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

	hidePlayerStatusText:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.hidePlayerStatusText = true
			else
				eufDB.hidePlayerStatusText = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.hidePlayerStatusText = false
			else
				eufDB.hidePlayerStatusText = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	hidePowerBarStatusText:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.hidePowerBarStatusText = true
			else
				eufDB.hidePowerBarStatusText = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.hidePowerBarStatusText = false
			else
				eufDB.hidePowerBarStatusText = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	hideTargetStatusText:SetScript("OnClick", function(self)
		if self:GetChecked() then
			if eufCharacterDB.enabled then
				eufCharacterDB.hideTargetStatusText = true
			else
				eufDB.hideTargetStatusText = true
			end

			PlaySound(856)
		else
			if eufCharacterDB.enabled then
				eufCharacterDB.hideTargetStatusText = false
			else
				eufDB.hideTargetStatusText = false
			end

			PlaySound(857)
		end

		StaticPopup_Show("RELOAD_UI")
	end)

	-- Status text dropdown menu.

	local statusTextDropdown = CreateFrame("Frame", "eufStatusTextDropdown", self, "UIDropDownMenuTemplate")
	statusTextDropdown.title = statusTextDropdown:CreateFontString("statusTextDropdownLabel", "ARTWORK", "GameFontNormal")

	statusTextDropdown:SetPoint("TOPLEFT", upperCaseAbbreviation, "BOTTOMLEFT", 273, 8)
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
		if eufCharacterDB.upperCaseAbbreviation == true then
			upperCaseAbbreviationCheckbox:SetChecked(true)
		end

		if not isClassic() then
			if eufCharacterDB.hideArenaStatusText == true then
				hideArenaStatusTextCheckbox:SetChecked(true)
			end

			if eufCharacterDB.hideBossStatusText == true then
				hideBossStatusTextCheckbox:SetChecked(true)
			end

			if eufCharacterDB.hideFocusStatusText == true then
				hideFocusStatusTextCheckbox:SetChecked(true)
			end
		end

		if eufCharacterDB.hidePartyStatusText == true then
			hidePartyStatusTextCheckbox:SetChecked(true)
		end

		if eufCharacterDB.hidePetStatusText == true then
			hidePetStatusTextCheckbox:SetChecked(true)
		end

		if eufCharacterDB.hidePlayerStatusText == true then
			hidePlayerStatusTextCheckbox:SetChecked(true)
		end

		if eufCharacterDB.hidePowerBarStatusText == true then
			hidePowerBarStatusTextCheckbox:SetChecked(true)
		end

		if eufCharacterDB.hideTargetStatusText == true then
			hideTargetStatusTextCheckbox:SetChecked(true)
		end
	else
		if eufDB.upperCaseAbbreviation == true then
			upperCaseAbbreviationCheckbox:SetChecked(true)
		end

		if not isClassic() then
			if eufDB.hideArenaStatusText == true then
				hideArenaStatusTextCheckbox:SetChecked(true)
			end

			if eufDB.hideBossStatusText == true then
				hideBossStatusTextCheckbox:SetChecked(true)
			end

			if eufDB.hideFocusStatusText == true then
				hideFocusStatusTextCheckbox:SetChecked(true)
			end
		end

		if eufDB.hidePartyStatusText == true then
			hidePartyStatusTextCheckbox:SetChecked(true)
		end

		if eufDB.hidePetStatusText == true then
			hidePetStatusTextCheckbox:SetChecked(true)
		end

		if eufDB.hidePlayerStatusText == true then
			hidePlayerStatusTextCheckbox:SetChecked(true)
		end

		if eufDB.hidePowerBarStatusText == true then
			hidePowerBarStatusTextCheckbox:SetChecked(true)
		end

		if eufDB.hideTargetStatusText == true then
			hideTargetStatusTextCheckbox:SetChecked(true)
		end
	end

	self:SetScript("OnShow", nil)
end)
