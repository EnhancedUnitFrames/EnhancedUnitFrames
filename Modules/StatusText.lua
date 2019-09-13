function StatusTextStyling()
	-- Formats numbers so they are readable.

	local function ReadableNumber(number)
		if cfg.upperCaseAbbreviation then
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
			if isClassic() then
				if UnitExists("target") and UnitIsDead("target") then
					TargetFrameHealthBarText:SetText("")
				end
			else
				if UnitExists("boss1") and UnitIsDead("boss1") then
					Boss1TargetFrameTextureFrameHealthBarText:SetText("")
				elseif UnitExists("boss2") and UnitIsDead("boss2") then
					Boss2TargetFrameTextureFrameHealthBarText:SetText("")
				elseif UnitExists("boss3") and UnitIsDead("boss3") then
					Boss3TargetFrameTextureFrameHealthBarText:SetText("")
				elseif UnitExists("boss4") and UnitIsDead("boss4") then
					Boss4TargetFrameTextureFrameHealthBarText:SetText("")
				elseif UnitExists("focus") and UnitIsDead("focus") then
					FocusFrameTextureFrameHealthBarText:SetText("")
				elseif UnitExists("target") and UnitIsDead("target") then
					TargetFrameTextureFrameHealthBarText:SetText("")
				end
			end
		end

		if value and valueMax > 0 then
			if GetCVar("statusTextDisplay") == "NUMERIC" then
				textString:SetText(valueDisplay)
			elseif GetCVar("statusTextDisplay") == "PERCENT" then
				textString:SetText(valuePercentageDisplay)
				isDead()
			elseif GetCVar("statusTextDisplay") == "BOTH" and statusFrame.LeftText and statusFrame.RightText then
				statusFrame.LeftText:SetText(valuePercentageDisplay)
				statusFrame.RightText:SetText(valueDisplay)
				textString:Hide()
				isDead()
			elseif GetCVar("statusTextDisplay") == "NONE" or GetCVar("statusText") == "0" then
				textString:SetText(valueDisplay)
				isDead()
			end
		end
	end)

	if GetCVar("statusTextDisplay") == "BOTH" then
		hooksecurefunc("ShowTextStatusBarText", function(bar)
			if bar and bar.TextString then
				bar.TextString:Hide()
				PlayerFrameHealthBar.LeftText:Show()
				PlayerFrameHealthBar.RightText:Show()
				PlayerFrameManaBar.LeftText:Show()
				PlayerFrameManaBar.RightText:Show()
			end
		end)
	end
end
