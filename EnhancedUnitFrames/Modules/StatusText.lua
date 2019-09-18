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
		local valueDisplay = tostring(ReadableNumber(value))
		local valueMaxDisplay = tostring(ReadableNumber(valueMax))
		local valuePercentageDisplay = math.ceil((value / valueMax) * 100) .. "%"

		local function isDead()
			if UnitIsDead("player") or UnitIsGhost("player") then
				if GetCVar("statusTextDisplay") == "BOTH" then
					PlayerFrameHealthBar.TextString:Show()
				end

				if UnitIsDead("player") then
					PlayerFrameHealthBar.TextString:SetText("Dead")
				elseif UnitIsGhost("player") then
					PlayerFrameHealthBar.TextString:SetText("Ghost")
				end

				PlayerFrameHealthBar:SetAlpha(0)
				PlayerFrameHealthBar.LeftText:SetAlpha(0)
				PlayerFrameHealthBar.RightText:SetAlpha(0)
				PlayerFrameHealthBar.TextString:SetFontObject(GameFontNormalSmall)
				PlayerFrameHealthBar.TextString:SetShadowOffset(1, -1)

				if isClassic() then
					PlayerFrameHealthBar.TextString:SetTextColor(1, 0.82, 0)
				end

				PlayerFrameManaBar:SetAlpha(0)
				PlayerFrameManaBar.LeftText:SetAlpha(0)
				PlayerFrameManaBar.RightText:SetAlpha(0)
				PlayerFrameManaBar.TextString:SetAlpha(0)
			elseif not UnitIsDead("player") or not UnitIsGhost("player") then
				if isClassic() then
					PlayerFrameHealthBar.TextString:SetFontObject(SystemFont_Outline_Small)
					PlayerFrameHealthBar.TextString:SetTextColor(1, 1, 1)
				else
					PlayerFrameHealthBar.TextString:SetFontObject(TextStatusBarText)
				end

				PlayerFrameHealthBar:SetAlpha(1)
				PlayerFrameHealthBar.LeftText:SetAlpha(1)
				PlayerFrameHealthBar.RightText:SetAlpha(1)
				PlayerFrameHealthBar.TextString:SetShadowOffset(0, 999999)
				PlayerFrameManaBar:SetAlpha(1)
				PlayerFrameManaBar.LeftText:SetAlpha(1)
				PlayerFrameManaBar.RightText:SetAlpha(1)
				PlayerFrameManaBar.TextString:SetAlpha(1)
			end

			if UnitIsDead("target") or UnitIsGhost("target") then
				if GetCVar("statusTextDisplay") == "BOTH" then
					TargetFrameHealthBar.TextString:Show()
				end

				if UnitIsDead("target") then
					TargetFrameHealthBar.TextString:SetText("Dead")
				elseif UnitIsGhost("target") then
					TargetFrameHealthBar.TextString:SetText("Ghost")
				end

				TargetFrameHealthBar:SetAlpha(0)
				TargetFrameHealthBar.LeftText:SetAlpha(0)
				TargetFrameHealthBar.RightText:SetAlpha(0)
				TargetFrameHealthBar.TextString:SetFontObject(GameFontNormalSmall)
				TargetFrameHealthBar.TextString:SetShadowOffset(1, -1)

				if isClassic() then
					TargetFrameHealthBar.TextString:SetTextColor(1, 0.82, 0)
				end

				TargetFrameManaBar:SetAlpha(0)
				TargetFrameManaBar.LeftText:SetAlpha(0)
				TargetFrameManaBar.RightText:SetAlpha(0)
				TargetFrameManaBar.TextString:SetAlpha(0)
			elseif not UnitIsDead("target") or not UnitIsGhost("target") then
				if isClassic() then
					TargetFrameHealthBar.TextString:SetFontObject(SystemFont_Outline_Small)
					TargetFrameHealthBar.TextString:SetTextColor(1, 1, 1)
				else
					TargetFrameHealthBar.TextString:SetFontObject(TextStatusBarText)
				end

				TargetFrameHealthBar:SetAlpha(1)
				TargetFrameHealthBar.LeftText:SetAlpha(1)
				TargetFrameHealthBar.RightText:SetAlpha(1)
				TargetFrameHealthBar.TextString:SetShadowOffset(0, 999999)
				TargetFrameManaBar:SetAlpha(1)
				TargetFrameManaBar.LeftText:SetAlpha(1)
				TargetFrameManaBar.RightText:SetAlpha(1)
				TargetFrameManaBar.TextString:SetAlpha(1)
			end

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
					if GetCVar("statusTextDisplay") == "BOTH" then
						FocusFrameHealthBar.TextString:Show()
					end

					if UnitIsDead("focus") then
						FocusFrameHealthBar.TextString:SetText("Dead")
					elseif UnitIsGhost("focus") then
						FocusFrameHealthBar.TextString:SetText("Ghost")
					end

					FocusFrameHealthBar:SetAlpha(0)
					FocusFrameHealthBar.LeftText:SetAlpha(0)
					FocusFrameHealthBar.RightText:SetAlpha(0)
					FocusFrameHealthBar.TextString:SetFontObject(GameFontNormalSmall)
					FocusFrameHealthBar.TextString:SetShadowOffset(1, -1)
					FocusFrameManaBar:SetAlpha(0)
					FocusFrameManaBar.LeftText:SetAlpha(0)
					FocusFrameManaBar.RightText:SetAlpha(0)
					FocusFrameManaBar.TextString:SetAlpha(0)
				elseif not UnitIsDead("focus") or not UnitIsGhost("focus") then
					FocusFrameHealthBar:SetAlpha(1)
					FocusFrameHealthBar.LeftText:SetAlpha(1)
					FocusFrameHealthBar.RightText:SetAlpha(1)
					FocusFrameHealthBar.TextString:SetFontObject(TextStatusBarText)
					FocusFrameHealthBar.TextString:SetShadowOffset(0, 999999)
					FocusFrameManaBar:SetAlpha(1)
					FocusFrameManaBar.LeftText:SetAlpha(1)
					FocusFrameManaBar.RightText:SetAlpha(1)
					FocusFrameManaBar.TextString:SetAlpha(1)
				end
			end
		end

		if value and valueMax > 0 then
			if GetCVar("statusTextDisplay") == "NUMERIC" then
				textString:SetText(valueDisplay)
				isDead()
			elseif GetCVar("statusTextDisplay") == "PERCENT" then
				textString:SetText(valuePercentageDisplay)
				isDead()
			elseif GetCVar("statusTextDisplay") == "BOTH" and statusFrame.LeftText and statusFrame.RightText then
				if not statusFrame.powerToken or statusFrame.powerToken == "MANA" then
					statusFrame.LeftText:Show()
				end

				statusFrame.LeftText:SetText(valuePercentageDisplay)
				statusFrame.RightText:SetText(valueDisplay)
				statusFrame.RightText:Show()
				textString:Hide()
				isDead()
			elseif GetCVar("statusTextDisplay") == "NONE" or GetCVar("statusText") == "0" then
				textString:SetText(valueDisplay)
				isDead()
			end
		end
	end)
end
