function StatusTextStyling()
	-- Formats numbers so they are readable.

	local function ReadableNumber(number)
		if eufCharacterDB.enabled then
			if eufCharacterDB.upperCaseAbbreviation then
				if not number then
					return 0
				elseif number >= 1000000000000000 then
					return format("%.1fQ", number / 1000000000000000)
				elseif number >= 1000000000000 then
					return format("%.1fT", number / 1000000000000)
				elseif number >= 1000000000 then
					return format("%.1fB", number / 1000000000)
				elseif number >= 1000000 then
					return format("%.1fM", number / 1000000)
				elseif number >= 1000 then
					return format("%.1fK", number / 1000)
				else
					return number
				end
			else
				if not number then
					return 0
				elseif number >= 1000000000000000 then
					return format("%.1fq", number / 1000000000000000)
				elseif number >= 1000000000000 then
					return format("%.1ft", number / 1000000000000)
				elseif number >= 1000000000 then
					return format("%.1fb", number / 1000000000)
				elseif number >= 1000000 then
					return format("%.1fm", number / 1000000)
				elseif number >= 1000 then
					return format("%.1fk", number / 1000)
				else
					return number
				end
			end
		else
			if eufDB.upperCaseAbbreviation then
				if not number then
					return 0
				elseif number >= 1000000000000000 then
					return format("%.1fQ", number / 1000000000000000)
				elseif number >= 1000000000000 then
					return format("%.1fT", number / 1000000000000)
				elseif number >= 1000000000 then
					return format("%.1fB", number / 1000000000)
				elseif number >= 1000000 then
					return format("%.1fM", number / 1000000)
				elseif number >= 1000 then
					return format("%.1fK", number / 1000)
				else
					return number
				end
			else
				if not number then
					return 0
				elseif number >= 1000000000000000 then
					return format("%.1fq", number / 1000000000000000)
				elseif number >= 1000000000000 then
					return format("%.1ft", number / 1000000000000)
				elseif number >= 1000000000 then
					return format("%.1fb", number / 1000000000)
				elseif number >= 1000000 then
					return format("%.1fm", number / 1000000)
				elseif number >= 1000 then
					return format("%.1fk", number / 1000)
				else
					return number
				end
			end
		end
	end

	if not isClassic() then
		-- Hides or shows the focus frame status bar text.

		function HideFocusStatusText()
			FocusFrameHealthBar.LeftText:SetAlpha(0)
			FocusFrameHealthBar.RightText:SetAlpha(0)
			FocusFrameHealthBar.TextString:SetAlpha(0)
			FocusFrameManaBar.LeftText:SetAlpha(0)
			FocusFrameManaBar.RightText:SetAlpha(0)
			FocusFrameManaBar.TextString:SetAlpha(0)
		end

		function ShowFocusStatusText()
			FocusFrameHealthBar.LeftText:SetAlpha(1)
			FocusFrameHealthBar.RightText:SetAlpha(1)
			FocusFrameHealthBar.TextString:SetAlpha(1)
			FocusFrameManaBar.LeftText:SetAlpha(1)
			FocusFrameManaBar.RightText:SetAlpha(1)
			FocusFrameManaBar.TextString:SetAlpha(1)
		end

		if eufCharacterDB.enabled then
			if eufCharacterDB.hideFocusStatusText then
				HideFocusStatusText()
			end
		else
			if eufDB.hideFocusStatusText then
				HideFocusStatusText()
			end
		end
	end

	-- Hides the party frame status bar text.

	local function HidePartyStatusText()
		for i = 1, 4 do
			_G["PartyMemberFrame" .. i .. "HealthBarText"]:SetAlpha(0)
			_G["PartyMemberFrame" .. i .. "HealthBarTextLeft"]:SetAlpha(0)
			_G["PartyMemberFrame" .. i .. "HealthBarTextRight"]:SetAlpha(0)
			_G["PartyMemberFrame" .. i .. "ManaBarText"]:SetAlpha(0)
			_G["PartyMemberFrame" .. i .. "ManaBarTextLeft"]:SetAlpha(0)
			_G["PartyMemberFrame" .. i .. "ManaBarTextRight"]:SetAlpha(0)
		end
	end

	if eufCharacterDB.enabled then
		if eufCharacterDB.hidePartyStatusText then
			HidePartyStatusText()
		end
	else
		if eufDB.hidePartyStatusText then
			HidePartyStatusText()
		end
	end

	-- Hides the pet frame status bar text.

	local function HidePetStatusText()
		PetFrameHealthBar.LeftText:SetAlpha(0)
		PetFrameHealthBar.RightText:SetAlpha(0)
		PetFrameHealthBar.TextString:SetAlpha(0)
		PetFrameManaBar.LeftText:SetAlpha(0)
		PetFrameManaBar.RightText:SetAlpha(0)
		PetFrameManaBar.TextString:SetAlpha(0)
	end

	if eufCharacterDB.enabled then
		if eufCharacterDB.hidePetStatusText then
			HidePetStatusText()
		end
	else
		if eufDB.hidePetStatusText then
			HidePetStatusText()
		end
	end

	-- Hides or shows the player frame status bar text.

	local function HidePlayerStatusText()
		PlayerFrameHealthBar.LeftText:SetAlpha(0)
		PlayerFrameHealthBar.RightText:SetAlpha(0)
		PlayerFrameHealthBar.TextString:SetAlpha(0)
		PlayerFrameManaBar.LeftText:SetAlpha(0)
		PlayerFrameManaBar.RightText:SetAlpha(0)
		PlayerFrameManaBar.TextString:SetAlpha(0)
	end

	local function ShowPlayerStatusText()
		PlayerFrameHealthBar.LeftText:SetAlpha(1)
		PlayerFrameHealthBar.RightText:SetAlpha(1)
		PlayerFrameHealthBar.TextString:SetAlpha(1)
		PlayerFrameManaBar.LeftText:SetAlpha(1)
		PlayerFrameManaBar.RightText:SetAlpha(1)
		PlayerFrameManaBar.TextString:SetAlpha(1)
	end

	if eufCharacterDB.enabled then
		if eufCharacterDB.hidePlayerStatusText then
			HidePlayerStatusText()
		end
	else
		if eufDB.hidePlayerStatusText then
			HidePlayerStatusText()
		end
	end

	-- Hides or shows the target frame status bar text.

	local function HideTargetStatusText()
		TargetFrameHealthBar.LeftText:SetAlpha(0)
		TargetFrameHealthBar.RightText:SetAlpha(0)
		TargetFrameHealthBar.TextString:SetAlpha(0)
		TargetFrameManaBar.LeftText:SetAlpha(0)
		TargetFrameManaBar.RightText:SetAlpha(0)
		TargetFrameManaBar.TextString:SetAlpha(0)
	end

	local function ShowTargetStatusText()
		TargetFrameHealthBar.LeftText:SetAlpha(1)
		TargetFrameHealthBar.RightText:SetAlpha(1)
		TargetFrameHealthBar.TextString:SetAlpha(1)
		TargetFrameManaBar.LeftText:SetAlpha(1)
		TargetFrameManaBar.RightText:SetAlpha(1)
		TargetFrameManaBar.TextString:SetAlpha(1)
	end

	if eufCharacterDB.enabled then
		if eufCharacterDB.hideTargetStatusText then
			HideTargetStatusText()
		end
	else
		if eufDB.hideTargetStatusText then
			HideTargetStatusText()
		end
	end

	-- Formats the raid frame status text so it's readable.

	hooksecurefunc("CompactUnitFrame_UpdateStatusText", function(self)
		if self and not self:IsForbidden() then
			if not self.statusText then
				return
			end

			if not self.optionTable.displayStatusText then
				self.statusText:Hide()

				return
			end

			if not UnitIsConnected(self.unit) then
				self.statusText:SetText(PLAYER_OFFLINE)
				self.statusText:Show()
			elseif UnitIsDeadOrGhost(self.displayedUnit) then
				self.statusText:SetText(DEAD)
				self.statusText:Show()
			elseif self.optionTable.healthText == "health" then
				local healthRemaining = UnitHealth(self.displayedUnit)

				self.statusText:SetText(tostring(ReadableNumber(healthRemaining)))
				self.statusText:Show()
			elseif self.optionTable.healthText == "losthealth" then
				local healthLost = UnitHealthMax(self.displayedUnit) - UnitHealth(self.displayedUnit)

				if healthLost > 0 then
					self.statusText:SetText("-" .. tostring(ReadableNumber(healthLost)))
					self.statusText:Show()
				else
					self.statusText:Hide()
				end
			elseif self.optionTable.healthText == "perc" and UnitHealthMax(self.displayedUnit) > 0 then
				local perc = math.ceil(100 * (UnitHealth(self.displayedUnit) / UnitHealthMax(self.displayedUnit)))

				self.statusText:SetFormattedText("%d%%", perc)
				self.statusText:Show()
			else
				self.statusText:Hide()
			end
		end
	end)

	-- Formats the unit frame status text so it's readable.

	hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function(statusFrame, textString, value, valueMin, valueMax)
		if not isClassic() then
			focusPowerType = UnitPowerType("focus")
			focusValueHealth = UnitHealth("focus")
			focusValueHealthMax = UnitHealthMax("focus")
			focusValuePower = UnitPower("focus")
			focusValuePowerMax = UnitPowerMax("focus")
			focusValueHealthDisplay = tostring(ReadableNumber(focusValueHealth))
			focusValueHealthMaxDisplay = tostring(ReadableNumber(focusValueHealthMax))
			focusValueHealthPercentageDisplay = math.ceil((focusValueHealth / focusValueHealthMax) * 100) .. "%"
			focusValuePowerDisplay = tostring(ReadableNumber(focusValuePower))
			focusValuePowerMaxDisplay = tostring(ReadableNumber(focusValuePowerMax))
			focusValuePowerPercentageDisplay = math.ceil((focusValuePower / focusValuePowerMax) * 100) .. "%"
		end

		local party1PowerType = UnitPowerType("party1")
		local party1ValueHealth = UnitHealth("party1")
		local party1ValueHealthMax = UnitHealthMax("party1")
		local party1ValuePower = UnitPower("party1")
		local party1ValuePowerMax = UnitPowerMax("party1")
		local party1ValueHealthDisplay = tostring(ReadableNumber(party1ValueHealth))
		local party1ValueHealthMaxDisplay = tostring(ReadableNumber(party1ValueHealthMax))
		local party1ValueHealthPercentageDisplay = math.ceil((party1ValueHealth / party1ValueHealthMax) * 100) .. "%"
		local party1ValuePowerDisplay = tostring(ReadableNumber(party1ValuePower))
		local party1ValuePowerMaxDisplay = tostring(ReadableNumber(party1ValuePowerMax))
		local party1ValuePowerPercentageDisplay = math.ceil((party1ValuePower / party1ValuePowerMax) * 100) .. "%"
		local party2PowerType = UnitPowerType("party2")
		local party2ValueHealth = UnitHealth("party2")
		local party2ValueHealthMax = UnitHealthMax("party2")
		local party2ValuePower = UnitPower("party2")
		local party2ValuePowerMax = UnitPowerMax("party2")
		local party2ValueHealthDisplay = tostring(ReadableNumber(party2ValueHealth))
		local party2ValueHealthMaxDisplay = tostring(ReadableNumber(party2ValueHealthMax))
		local party2ValueHealthPercentageDisplay = math.ceil((party2ValueHealth / party2ValueHealthMax) * 100) .. "%"
		local party2ValuePowerDisplay = tostring(ReadableNumber(party2ValuePower))
		local party2ValuePowerMaxDisplay = tostring(ReadableNumber(party2ValuePowerMax))
		local party2ValuePowerPercentageDisplay = math.ceil((party2ValuePower / party2ValuePowerMax) * 100) .. "%"
		local party3PowerType = UnitPowerType("party3")
		local party3ValueHealth = UnitHealth("party3")
		local party3ValueHealthMax = UnitHealthMax("party3")
		local party3ValuePower = UnitPower("party3")
		local party3ValuePowerMax = UnitPowerMax("party3")
		local party3ValueHealthDisplay = tostring(ReadableNumber(party3ValueHealth))
		local party3ValueHealthMaxDisplay = tostring(ReadableNumber(party3ValueHealthMax))
		local party3ValueHealthPercentageDisplay = math.ceil((party3ValueHealth / party3ValueHealthMax) * 100) .. "%"
		local party3ValuePowerDisplay = tostring(ReadableNumber(party3ValuePower))
		local party3ValuePowerMaxDisplay = tostring(ReadableNumber(party3ValuePowerMax))
		local party3ValuePowerPercentageDisplay = math.ceil((party3ValuePower / party3ValuePowerMax) * 100) .. "%"
		local party4PowerType = UnitPowerType("party4")
		local party4ValueHealth = UnitHealth("party4")
		local party4ValueHealthMax = UnitHealthMax("party4")
		local party4ValuePower = UnitPower("party4")
		local party4ValuePowerMax = UnitPowerMax("party4")
		local party4ValueHealthDisplay = tostring(ReadableNumber(party4ValueHealth))
		local party4ValueHealthMaxDisplay = tostring(ReadableNumber(party4ValueHealthMax))
		local party4ValueHealthPercentageDisplay = math.ceil((party4ValueHealth / party4ValueHealthMax) * 100) .. "%"
		local party4ValuePowerDisplay = tostring(ReadableNumber(party4ValuePower))
		local party4ValuePowerMaxDisplay = tostring(ReadableNumber(party4ValuePowerMax))
		local party4ValuePowerPercentageDisplay = math.ceil((party4ValuePower / party4ValuePowerMax) * 100) .. "%"
		local petPowerType = UnitPowerType("pet")
		local petValueHealth = UnitHealth("pet")
		local petValueHealthMax = UnitHealthMax("pet")
		local petValuePower = UnitPower("pet")
		local petValuePowerMax = UnitPowerMax("pet")
		local petValueHealthDisplay = tostring(ReadableNumber(petValueHealth))
		local petValueHealthMaxDisplay = tostring(ReadableNumber(petValueHealthMax))
		local petValueHealthPercentageDisplay = math.ceil((petValueHealth / petValueHealthMax) * 100) .. "%"
		local petValuePowerDisplay = tostring(ReadableNumber(petValuePower))
		local petValuePowerMaxDisplay = tostring(ReadableNumber(petValuePowerMax))
		local petValuePowerPercentageDisplay = math.ceil((petValuePower / petValuePowerMax) * 100) .. "%"
		local targetPowerType = UnitPowerType("target")
		local targetValueHealth = UnitHealth("target")
		local targetValueHealthMax = UnitHealthMax("target")
		local targetValuePower = UnitPower("target")
		local targetValuePowerMax = UnitPowerMax("target")
		local targetValueHealthDisplay = tostring(ReadableNumber(targetValueHealth))
		local targetValueHealthMaxDisplay = tostring(ReadableNumber(targetValueHealthMax))
		local targetValueHealthPercentageDisplay = math.ceil((targetValueHealth / targetValueHealthMax) * 100) .. "%"
		local targetValuePowerDisplay = tostring(ReadableNumber(targetValuePower))
		local targetValuePowerMaxDisplay = tostring(ReadableNumber(targetValuePowerMax))
		local targetValuePowerPercentageDisplay = math.ceil((targetValuePower / targetValuePowerMax) * 100) .. "%"
		local valueDisplay = tostring(ReadableNumber(value))
		local valueMaxDisplay = tostring(ReadableNumber(valueMax))
		local valuePercentageDisplay = math.ceil((value / valueMax) * 100) .. "%"

		local function isDeadOrGhost()
			if not isClassic() then
				if UnitExists("boss1") and UnitIsDead("boss1") then
					Boss1TargetFrameTextureFrameHealthBarText:SetText("")
				elseif UnitExists("boss2") and UnitIsDead("boss2") then
					Boss2TargetFrameTextureFrameHealthBarText:SetText("")
				elseif UnitExists("boss3") and UnitIsDead("boss3") then
					Boss3TargetFrameTextureFrameHealthBarText:SetText("")
				elseif UnitExists("boss4") and UnitIsDead("boss4") then
					Boss4TargetFrameTextureFrameHealthBarText:SetText("")
				end

				if UnitIsDead("focus") or UnitIsGhost("focus") then
					if eufCharacterDB.enabled then
						if eufCharacterDB.statusTextBoth then
							FocusFrameHealthBar.TextString:Show()
						end
					else
						if eufDB.statusTextBoth then
							FocusFrameHealthBar.TextString:Show()
						end
					end

					if UnitIsDead("focus") then
						FocusFrameHealthBar.TextString:SetText("Dead")
					elseif UnitIsGhost("focus") then
						FocusFrameHealthBar.TextString:SetText("Ghost")
					end

					FocusDeadTextColor()

					FocusFrameHealthBar:SetAlpha(0)
					FocusFrameHealthBar.LeftText:SetAlpha(0)
					FocusFrameHealthBar.RightText:SetAlpha(0)
					FocusFrameHealthBar.TextString:SetAlpha(1)
					FocusFrameHealthBar.TextString:SetFontObject(GameFontNormalSmall)
					FocusFrameHealthBar.TextString:SetShadowOffset(1, -1)
					FocusFrameManaBar:SetAlpha(0)
					FocusFrameManaBar.LeftText:SetAlpha(0)
					FocusFrameManaBar.RightText:SetAlpha(0)
					FocusFrameManaBar.TextString:SetAlpha(0)
				elseif not UnitIsDead("focus") or not UnitIsGhost("focus") then
					if eufCharacterDB.enabled then
						if eufCharacterDB.hideFocusStatusText then
							HideFocusStatusText()
						else
							ShowFocusStatusText()
						end
					else
						if eufDB.hideFocusStatusText then
							HideFocusStatusText()
						else
							ShowFocusStatusText()
						end
					end

					FocusFrameHealthBar:SetAlpha(1)
					FocusFrameHealthBar.TextString:SetFontObject(TextStatusBarText)
					FocusFrameHealthBar.TextString:SetShadowOffset(0, 999999)
					FocusFrameHealthBar.TextString:SetTextColor(1, 1, 1)
					FocusFrameManaBar:SetAlpha(1)
				end
			end

			if UnitIsDead("player") or UnitIsGhost("player") then
				if eufCharacterDB.enabled then
					if eufCharacterDB.statusTextBoth then
						PlayerFrameHealthBar.TextString:Show()
					end
				else
					if eufDB.statusTextBoth then
						PlayerFrameHealthBar.TextString:Show()
					end
				end

				if UnitIsDead("player") then
					PlayerFrameHealthBar.TextString:SetText("Dead")
				elseif UnitIsGhost("player") then
					PlayerFrameHealthBar.TextString:SetText("Ghost")
				end

				PlayerFrameHealthBar:SetAlpha(0)
				PlayerFrameHealthBar.LeftText:SetAlpha(0)
				PlayerFrameHealthBar.RightText:SetAlpha(0)
				PlayerFrameHealthBar.TextString:SetAlpha(1)
				PlayerFrameHealthBar.TextString:SetFontObject(GameFontNormalSmall)
				PlayerFrameHealthBar.TextString:SetShadowOffset(1, -1)

				if isClassic() then
					if eufCharacterDB.enabled then
						if eufCharacterDB.classDeadTextColor or eufCharacterDB.reactionDeadTextColor then
							PlayerDeadTextColor()
						else
							PlayerFrameHealthBar.TextString:SetTextColor(1, 0.82, 0)
						end
					else
						if eufDB.classDeadTextColor or eufDB.reactionDeadTextColor then
							PlayerDeadTextColor()
						else
							PlayerFrameHealthBar.TextString:SetTextColor(1, 0.82, 0)
						end
					end
				else
					PlayerDeadTextColor()
				end

				PlayerFrameManaBar:SetAlpha(0)
				PlayerFrameManaBar.LeftText:SetAlpha(0)
				PlayerFrameManaBar.RightText:SetAlpha(0)
				PlayerFrameManaBar.TextString:SetAlpha(0)
			elseif not UnitIsDead("player") or not UnitIsGhost("player") then
				if eufCharacterDB.enabled then
					if eufCharacterDB.hidePlayerStatusText then
						HidePlayerStatusText()
					else
						ShowPlayerStatusText()
					end
				else
					if eufDB.hidePlayerStatusText then
						HidePlayerStatusText()
					else
						ShowPlayerStatusText()
					end
				end

				if isClassic() then
					PlayerFrameHealthBar.TextString:SetFontObject(SystemFont_Outline_Small)
				else
					PlayerFrameHealthBar.TextString:SetFontObject(TextStatusBarText)
				end

				PlayerFrameHealthBar:SetAlpha(1)
				PlayerFrameHealthBar.TextString:SetShadowOffset(0, 999999)
				PlayerFrameHealthBar.TextString:SetTextColor(1, 1, 1)
				PlayerFrameManaBar:SetAlpha(1)
			end

			if UnitIsDead("target") or UnitIsGhost("target") then
				if eufCharacterDB.enabled then
					if eufCharacterDB.statusTextBoth then
						TargetFrameHealthBar.TextString:Show()
					end
				else
					if eufDB.statusTextBoth then
						TargetFrameHealthBar.TextString:Show()
					end
				end

				if UnitIsDead("target") then
					TargetFrameHealthBar.TextString:SetText("Dead")
				elseif UnitIsGhost("target") then
					TargetFrameHealthBar.TextString:SetText("Ghost")
				end

				TargetFrameHealthBar:SetAlpha(0)
				TargetFrameHealthBar.LeftText:SetAlpha(0)
				TargetFrameHealthBar.RightText:SetAlpha(0)
				TargetFrameHealthBar.TextString:SetAlpha(1)
				TargetFrameHealthBar.TextString:SetFontObject(GameFontNormalSmall)
				TargetFrameHealthBar.TextString:SetShadowOffset(1, -1)

				if isClassic() then
					if eufCharacterDB.enabled then
						if eufCharacterDB.classDeadTextColor or eufCharacterDB.reactionDeadTextColor then
							TargetDeadTextColor()
						else
							TargetFrameHealthBar.TextString:SetTextColor(1, 0.82, 0)
						end
					else
						if eufDB.classDeadTextColor or eufDB.reactionDeadTextColor then
							TargetDeadTextColor()
						else
							TargetFrameHealthBar.TextString:SetTextColor(1, 0.82, 0)
						end
					end
				else
					TargetDeadTextColor()
				end

				TargetFrameManaBar:SetAlpha(0)
				TargetFrameManaBar.LeftText:SetAlpha(0)
				TargetFrameManaBar.RightText:SetAlpha(0)
				TargetFrameManaBar.TextString:SetAlpha(0)
			elseif not UnitIsDead("target") or not UnitIsGhost("target") then
				if eufCharacterDB.enabled then
					if eufCharacterDB.hideTargetStatusText then
						HideTargetStatusText()
					else
						ShowTargetStatusText()
					end
				else
					if eufDB.hideTargetStatusText then
						HideTargetStatusText()
					else
						ShowTargetStatusText()
					end
				end

				if isClassic() then
					TargetFrameHealthBar.TextString:SetFontObject(SystemFont_Outline_Small)
				else
					TargetFrameHealthBar.TextString:SetFontObject(TextStatusBarText)
				end

				TargetFrameHealthBar:SetAlpha(1)
				TargetFrameHealthBar.TextString:SetShadowOffset(0, 999999)
				TargetFrameHealthBar.TextString:SetTextColor(1, 1, 1)
				TargetFrameManaBar:SetAlpha(1)
			end
		end

		if value and valueMax > 0 then
			if eufCharacterDB.enabled then
				if eufCharacterDB.statusTextNumeric and statusFrame.LeftText and statusFrame.RightText then
					statusFrame.LeftText:Hide()
					statusFrame.RightText:Hide()
					textString:SetText(valueDisplay)
					textString:Show()
				elseif eufCharacterDB.statusTextPercent and statusFrame.LeftText and statusFrame.RightText then
					if not statusFrame.powerToken or statusFrame.powerToken == "MANA" then
						textString:SetText(valuePercentageDisplay)
					else
						textString:SetText(valueDisplay)
					end

					statusFrame.LeftText:Hide()
					statusFrame.RightText:Hide()
					textString:Show()
				elseif eufCharacterDB.statusTextBoth and statusFrame.LeftText and statusFrame.RightText then
					if not statusFrame.powerToken or statusFrame.powerToken == "MANA" then
						statusFrame.LeftText:Show()
					end

					statusFrame.LeftText:SetText(valuePercentageDisplay)
					statusFrame.RightText:SetText(valueDisplay)
					statusFrame.RightText:Show()
					textString:Hide()
					PartyMemberFrame1HealthBarText:SetText(party1ValueHealthPercentageDisplay)
					PartyMemberFrame2HealthBarText:SetText(party2ValueHealthPercentageDisplay)
					PartyMemberFrame3HealthBarText:SetText(party3ValueHealthPercentageDisplay)
					PartyMemberFrame4HealthBarText:SetText(party4ValueHealthPercentageDisplay)
					PetFrameHealthBar.LeftText:Hide()
					PetFrameHealthBar.RightText:Hide()
					PetFrameManaBar.LeftText:Hide()
					PetFrameManaBar.RightText:Hide()
					PetFrameHealthBar.TextString:SetText(petValueHealthPercentageDisplay)
					PetFrameHealthBar.TextString:Show()
					PetFrameManaBar.TextString:Show()

					for i = 1, 4 do
						_G["PartyMemberFrame" .. i .. "HealthBarText"]:Show()
						_G["PartyMemberFrame" .. i .. "HealthBarTextLeft"]:Hide()
						_G["PartyMemberFrame" .. i .. "HealthBarTextRight"]:Hide()
						_G["PartyMemberFrame" .. i .. "ManaBarText"]:Show()
						_G["PartyMemberFrame" .. i .. "ManaBarTextLeft"]:Hide()
						_G["PartyMemberFrame" .. i .. "ManaBarTextRight"]:Hide()
					end

					if party1PowerType == 0 then
						PartyMemberFrame1ManaBarText:SetText(party1ValuePowerPercentageDisplay)
					else
						PartyMemberFrame1ManaBarText:SetText(party1ValuePowerDisplay)
					end

					if party2PowerType == 0 then
						PartyMemberFrame2ManaBarText:SetText(party2ValuePowerPercentageDisplay)
					else
						PartyMemberFrame2ManaBarText:SetText(party2ValuePowerDisplay)
					end

					if party3PowerType == 0 then
						PartyMemberFrame3ManaBarText:SetText(party3ValuePowerPercentageDisplay)
					else
						PartyMemberFrame3ManaBarText:SetText(party3ValuePowerDisplay)
					end

					if party4PowerType == 0 then
						PartyMemberFrame4ManaBarText:SetText(party4ValuePowerPercentageDisplay)
					else
						PartyMemberFrame4ManaBarText:SetText(party4ValuePowerDisplay)
					end

					if petPowerType == 0 then
						PetFrameManaBar.TextString:SetText(petValuePowerPercentageDisplay)
					else
						PetFrameManaBar.TextString:SetText(petValuePowerDisplay)
					end
				elseif eufCharacterDB.statusTextBothCondensed and statusFrame.LeftText and statusFrame.RightText then
					if not statusFrame.powerToken or statusFrame.powerToken == "MANA" then
						textString:SetText(valuePercentageDisplay)
					else
						textString:SetText(valueDisplay)
					end

					if not isClassic() then
						if eufCharacterDB.statusTextBothCondensedBar then
							FocusFrameHealthBar.TextString:SetText(focusValueHealthDisplay .. " | " .. focusValueHealthPercentageDisplay)					
						elseif eufCharacterDB.statusTextBothCondensedBrackets then
							FocusFrameHealthBar.TextString:SetText(focusValueHealthDisplay .. " [" .. focusValueHealthPercentageDisplay .. "]")
						elseif eufCharacterDB.statusTextBothCondensedDash then
							FocusFrameHealthBar.TextString:SetText(focusValueHealthDisplay .. " - " .. focusValueHealthPercentageDisplay)
						elseif eufCharacterDB.statusTextBothCondensedParentheses then
							FocusFrameHealthBar.TextString:SetText(focusValueHealthDisplay .. " (" .. focusValueHealthPercentageDisplay .. ")")
						elseif eufCharacterDB.statusTextBothCondensedSlash then
							FocusFrameHealthBar.TextString:SetText(focusValueHealthDisplay .. " / " .. focusValueHealthPercentageDisplay)
						end

						if focusPowerType == 0 then
							if eufCharacterDB.statusTextBothCondensedBar then
								FocusFrameManaBar.TextString:SetText(focusValuePowerDisplay .. " | " .. focusValuePowerPercentageDisplay)						
							elseif eufCharacterDB.statusTextBothCondensedBrackets then
								FocusFrameManaBar.TextString:SetText(focusValuePowerDisplay .. " [" .. focusValuePowerPercentageDisplay .. "]")
							elseif eufCharacterDB.statusTextBothCondensedDash then
								FocusFrameManaBar.TextString:SetText(focusValuePowerDisplay .. " - " .. focusValuePowerPercentageDisplay)
							elseif eufCharacterDB.statusTextBothCondensedParentheses then
								FocusFrameManaBar.TextString:SetText(focusValuePowerDisplay .. " (" .. focusValuePowerPercentageDisplay .. ")")
							elseif eufCharacterDB.statusTextBothCondensedSlash then
								FocusFrameManaBar.TextString:SetText(focusValuePowerDisplay .. " / " .. focusValuePowerPercentageDisplay)
							end
						else
							FocusFrameManaBar.TextString:SetText(focusValuePowerDisplay)
						end
					end

					if eufCharacterDB.statusTextBothCondensedBar then
						TargetFrameHealthBar.TextString:SetText(targetValueHealthDisplay .. " | " .. targetValueHealthPercentageDisplay)					
					elseif eufCharacterDB.statusTextBothCondensedBrackets then
						TargetFrameHealthBar.TextString:SetText(targetValueHealthDisplay .. " [" .. targetValueHealthPercentageDisplay .. "]")
					elseif eufCharacterDB.statusTextBothCondensedDash then
						TargetFrameHealthBar.TextString:SetText(targetValueHealthDisplay .. " - " .. targetValueHealthPercentageDisplay)
					elseif eufCharacterDB.statusTextBothCondensedParentheses then
						TargetFrameHealthBar.TextString:SetText(targetValueHealthDisplay .. " (" .. targetValueHealthPercentageDisplay .. ")")
					elseif eufCharacterDB.statusTextBothCondensedSlash then
						TargetFrameHealthBar.TextString:SetText(targetValueHealthDisplay .. " / " .. targetValueHealthPercentageDisplay)
					end

					if targetPowerType == 0 then
						if eufCharacterDB.statusTextBothCondensedBar then
							TargetFrameManaBar.TextString:SetText(targetValuePowerDisplay .. " | " .. targetValuePowerPercentageDisplay)						
						elseif eufCharacterDB.statusTextBothCondensedBrackets then
							TargetFrameManaBar.TextString:SetText(targetValuePowerDisplay .. " [" .. targetValuePowerPercentageDisplay .. "]")
						elseif eufCharacterDB.statusTextBothCondensedDash then
							TargetFrameManaBar.TextString:SetText(targetValuePowerDisplay .. " - " .. targetValuePowerPercentageDisplay)
						elseif eufCharacterDB.statusTextBothCondensedParentheses then
							TargetFrameManaBar.TextString:SetText(targetValuePowerDisplay .. " (" .. targetValuePowerPercentageDisplay .. ")")
						elseif eufCharacterDB.statusTextBothCondensedSlash then
							TargetFrameManaBar.TextString:SetText(targetValuePowerDisplay .. " / " .. targetValuePowerPercentageDisplay)
						end
					else
						TargetFrameManaBar.TextString:SetText(targetValuePowerDisplay)
					end

					statusFrame.LeftText:Hide()
					statusFrame.RightText:Hide()
					textString:Show()
				elseif eufCharacterDB.statusTextNone and statusFrame.LeftText and statusFrame.RightText then
					statusFrame.LeftText:Hide()
					statusFrame.RightText:Hide()
					textString:Hide()
					textString:SetText(valueDisplay)
				end
			else
				if eufDB.statusTextNumeric and statusFrame.LeftText and statusFrame.RightText then
					statusFrame.LeftText:Hide()
					statusFrame.RightText:Hide()
					textString:SetText(valueDisplay)
					textString:Show()
				elseif eufDB.statusTextPercent and statusFrame.LeftText and statusFrame.RightText then
					if not statusFrame.powerToken or statusFrame.powerToken == "MANA" then
						textString:SetText(valuePercentageDisplay)
					else
						textString:SetText(valueDisplay)
					end

					statusFrame.LeftText:Hide()
					statusFrame.RightText:Hide()
					textString:Show()
				elseif eufDB.statusTextBoth and statusFrame.LeftText and statusFrame.RightText then
					if not statusFrame.powerToken or statusFrame.powerToken == "MANA" then
						statusFrame.LeftText:Show()
					end

					statusFrame.LeftText:SetText(valuePercentageDisplay)
					statusFrame.RightText:SetText(valueDisplay)
					statusFrame.RightText:Show()
					textString:Hide()
					PartyMemberFrame1HealthBarText:SetText(party1ValueHealthPercentageDisplay)
					PartyMemberFrame2HealthBarText:SetText(party2ValueHealthPercentageDisplay)
					PartyMemberFrame3HealthBarText:SetText(party3ValueHealthPercentageDisplay)
					PartyMemberFrame4HealthBarText:SetText(party4ValueHealthPercentageDisplay)
					PetFrameHealthBar.LeftText:Hide()
					PetFrameHealthBar.RightText:Hide()
					PetFrameManaBar.LeftText:Hide()
					PetFrameManaBar.RightText:Hide()
					PetFrameHealthBar.TextString:SetText(petValueHealthPercentageDisplay)
					PetFrameHealthBar.TextString:Show()
					PetFrameManaBar.TextString:Show()

					for i = 1, 4 do
						_G["PartyMemberFrame" .. i .. "HealthBarText"]:Show()
						_G["PartyMemberFrame" .. i .. "HealthBarTextLeft"]:Hide()
						_G["PartyMemberFrame" .. i .. "HealthBarTextRight"]:Hide()
						_G["PartyMemberFrame" .. i .. "ManaBarText"]:Show()
						_G["PartyMemberFrame" .. i .. "ManaBarTextLeft"]:Hide()
						_G["PartyMemberFrame" .. i .. "ManaBarTextRight"]:Hide()
					end

					if party1PowerType == 0 then
						PartyMemberFrame1ManaBarText:SetText(party1ValuePowerPercentageDisplay)
					else
						PartyMemberFrame1ManaBarText:SetText(party1ValuePowerDisplay)
					end

					if party2PowerType == 0 then
						PartyMemberFrame2ManaBarText:SetText(party2ValuePowerPercentageDisplay)
					else
						PartyMemberFrame2ManaBarText:SetText(party2ValuePowerDisplay)
					end

					if party3PowerType == 0 then
						PartyMemberFrame3ManaBarText:SetText(party3ValuePowerPercentageDisplay)
					else
						PartyMemberFrame3ManaBarText:SetText(party3ValuePowerDisplay)
					end

					if party4PowerType == 0 then
						PartyMemberFrame4ManaBarText:SetText(party4ValuePowerPercentageDisplay)
					else
						PartyMemberFrame4ManaBarText:SetText(party4ValuePowerDisplay)
					end

					if petPowerType == 0 then
						PetFrameManaBar.TextString:SetText(petValuePowerPercentageDisplay)
					else
						PetFrameManaBar.TextString:SetText(petValuePowerDisplay)
					end
				elseif eufDB.statusTextBothCondensed and statusFrame.LeftText and statusFrame.RightText then
					if not statusFrame.powerToken or statusFrame.powerToken == "MANA" then
						textString:SetText(valuePercentageDisplay)
					else
						textString:SetText(valueDisplay)
					end

					if not isClassic() then
						if eufDB.statusTextBothCondensedBar then
							FocusFrameHealthBar.TextString:SetText(focusValueHealthDisplay .. " | " .. focusValueHealthPercentageDisplay)					
						elseif eufDB.statusTextBothCondensedBrackets then
							FocusFrameHealthBar.TextString:SetText(focusValueHealthDisplay .. " [" .. focusValueHealthPercentageDisplay .. "]")
						elseif eufDB.statusTextBothCondensedDash then
							FocusFrameHealthBar.TextString:SetText(focusValueHealthDisplay .. " - " .. focusValueHealthPercentageDisplay)
						elseif eufDB.statusTextBothCondensedParentheses then
							FocusFrameHealthBar.TextString:SetText(focusValueHealthDisplay .. " (" .. focusValueHealthPercentageDisplay .. ")")
						elseif eufDB.statusTextBothCondensedSlash then
							FocusFrameHealthBar.TextString:SetText(focusValueHealthDisplay .. " / " .. focusValueHealthPercentageDisplay)
						end

						if focusPowerType == 0 then
							if eufDB.statusTextBothCondensedBar then
								FocusFrameManaBar.TextString:SetText(focusValuePowerDisplay .. " | " .. focusValuePowerPercentageDisplay)						
							elseif eufDB.statusTextBothCondensedBrackets then
								FocusFrameManaBar.TextString:SetText(focusValuePowerDisplay .. " [" .. focusValuePowerPercentageDisplay .. "]")
							elseif eufDB.statusTextBothCondensedDash then
								FocusFrameManaBar.TextString:SetText(focusValuePowerDisplay .. " - " .. focusValuePowerPercentageDisplay)
							elseif eufDB.statusTextBothCondensedParentheses then
								FocusFrameManaBar.TextString:SetText(focusValuePowerDisplay .. " (" .. focusValuePowerPercentageDisplay .. ")")
							elseif eufDB.statusTextBothCondensedSlash then
								FocusFrameManaBar.TextString:SetText(focusValuePowerDisplay .. " / " .. focusValuePowerPercentageDisplay)
							end
						else
							FocusFrameManaBar.TextString:SetText(focusValuePowerDisplay)
						end
					end

					if eufDB.statusTextBothCondensedBar then
						TargetFrameHealthBar.TextString:SetText(targetValueHealthDisplay .. " | " .. targetValueHealthPercentageDisplay)					
					elseif eufDB.statusTextBothCondensedBrackets then
						TargetFrameHealthBar.TextString:SetText(targetValueHealthDisplay .. " [" .. targetValueHealthPercentageDisplay .. "]")
					elseif eufDB.statusTextBothCondensedDash then
						TargetFrameHealthBar.TextString:SetText(targetValueHealthDisplay .. " - " .. targetValueHealthPercentageDisplay)
					elseif eufDB.statusTextBothCondensedParentheses then
						TargetFrameHealthBar.TextString:SetText(targetValueHealthDisplay .. " (" .. targetValueHealthPercentageDisplay .. ")")
					elseif eufDB.statusTextBothCondensedSlash then
						TargetFrameHealthBar.TextString:SetText(targetValueHealthDisplay .. " / " .. targetValueHealthPercentageDisplay)
					end

					if targetPowerType == 0 then
						if eufDB.statusTextBothCondensedBar then
							TargetFrameManaBar.TextString:SetText(targetValuePowerDisplay .. " | " .. targetValuePowerPercentageDisplay)						
						elseif eufDB.statusTextBothCondensedBrackets then
							TargetFrameManaBar.TextString:SetText(targetValuePowerDisplay .. " [" .. targetValuePowerPercentageDisplay .. "]")
						elseif eufDB.statusTextBothCondensedDash then
							TargetFrameManaBar.TextString:SetText(targetValuePowerDisplay .. " - " .. targetValuePowerPercentageDisplay)
						elseif eufDB.statusTextBothCondensedParentheses then
							TargetFrameManaBar.TextString:SetText(targetValuePowerDisplay .. " (" .. targetValuePowerPercentageDisplay .. ")")
						elseif eufDB.statusTextBothCondensedSlash then
							TargetFrameManaBar.TextString:SetText(targetValuePowerDisplay .. " / " .. targetValuePowerPercentageDisplay)
						end
					else
						TargetFrameManaBar.TextString:SetText(targetValuePowerDisplay)
					end

					statusFrame.LeftText:Hide()
					statusFrame.RightText:Hide()
					textString:Show()
				elseif eufDB.statusTextNone and statusFrame.LeftText and statusFrame.RightText then
					statusFrame.LeftText:Hide()
					statusFrame.RightText:Hide()
					textString:Hide()
					textString:SetText(valueDisplay)
				end
			end

			isDeadOrGhost()
		end
	end)
end
