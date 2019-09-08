function PlayerFrameStyling()
	-- Styles the player frame.

	hooksecurefunc("PlayerFrame_ToPlayerArt", function(self)
		if cfg.bigPlayerHealthBar then
			if cfg.elitePlayerFrame then
				PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameElite")
			elseif cfg.rareElitePlayerFrame then
				PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRareElite")
			elseif cfg.rarePlayerFrame then
				PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRare")
			else
				PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrame")
			end

			PlayerFrameHealthBar:SetHeight(27)
			PlayerFrameManaBar:SetHeight(12)
			PlayerFrameManaBar:ClearAllPoints()
			PlayerFrameManaBar:SetPoint("TOPLEFT", 108, -52)
		else
			if cfg.elitePlayerFrame then
				PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameEliteWhoa")
			elseif cfg.rareElitePlayerFrame then
				PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRareEliteWhoa")
			elseif cfg.rarePlayerFrame then
				PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRareWhoa")
			else
				PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameWhoa")
			end

			PlayerFrameHealthBar:SetHeight(18)
			PlayerFrameManaBar:SetHeight(17)
			PlayerFrameManaBar:ClearAllPoints()
			PlayerFrameManaBar:SetPoint("TOPLEFT", 108, -45)

			if not isClassic() then
				InsanityBarFrame.InsanitySpark:ClearAllPoints()
				InsanityBarFrame.InsanitySpark:SetPoint("CENTER", InsanityBarFrame.InsanityOn.Tentacles, "RIGHT", 0, 9)
				PlayerFrameManaBar.FeedbackFrame:ClearAllPoints()
				PlayerFrameManaBar.FeedbackFrame:SetPoint("CENTER", PlayerFrameManaBar, 0, 0)
				PlayerFrameManaBar.FeedbackFrame:SetSize(117, 17)
				PlayerFrameManaBar.FullPowerFrame:SetSize(117, 17)
				PlayerFrameManaBar.FullPowerFrame.PulseFrame:ClearAllPoints()
				PlayerFrameManaBar.FullPowerFrame.PulseFrame:SetPoint("CENTER", PlayerFrameManaBar.FullPowerFrame, -6, 0)
				PlayerFrameManaBar.FullPowerFrame.PulseFrame:SetSize(117, 17)
				PlayerFrameManaBar.FullPowerFrame.SpikeFrame:SetSize(117, 17)
				PlayerFrameManaBar.FullPowerFrame.SpikeFrame.AlertSpikeStay:ClearAllPoints()
				PlayerFrameManaBar.FullPowerFrame.SpikeFrame.AlertSpikeStay:SetPoint("CENTER", PlayerFrameManaBar.FullPowerFrame, "RIGHT", -6, -1)
				PlayerFrameManaBar.FullPowerFrame.SpikeFrame.AlertSpikeStay:SetSize(30, 29)
				PlayerFrameManaBar.FullPowerFrame.SpikeFrame.BigSpikeGlow:ClearAllPoints()
				PlayerFrameManaBar.FullPowerFrame.SpikeFrame.BigSpikeGlow:SetPoint("CENTER", PlayerFrameManaBar.FullPowerFrame, "RIGHT", 5, -2)
				PlayerFrameManaBar.FullPowerFrame.SpikeFrame.BigSpikeGlow:SetSize(30, 50)
			end
		end

		PlayerFrameBackground:ClearAllPoints()
		PlayerFrameBackground:SetPoint("CENTER", PlayerFrame, 51, 7)
		PlayerFrameBackground:SetSize(117, 38)
		PlayerFrameGroupIndicatorLeft:SetAlpha(0)
		PlayerFrameGroupIndicatorMiddle:SetAlpha(0)
		PlayerFrameGroupIndicatorRight:SetAlpha(0)
		PlayerFrameGroupIndicatorText:ClearAllPoints()
		PlayerFrameGroupIndicatorText:SetPoint("BOTTOMLEFT", PlayerFrame, "TOP", 0, -18.5)
		PlayerFrameHealthBar:ClearAllPoints()
		PlayerFrameHealthBar:SetPoint("TOPLEFT", 108, -24)
		PlayerFrameHealthBar:SetWidth(117)
		PlayerFrameHealthBar.LeftText:ClearAllPoints()
		PlayerFrameHealthBar.LeftText:SetPoint("LEFT", PlayerFrameHealthBar, 2, 0)
		PlayerFrameHealthBar.RightText:ClearAllPoints()
		PlayerFrameHealthBar.RightText:SetPoint("RIGHT", PlayerFrameHealthBar, 0, 0)
		PlayerFrameHealthBarText:ClearAllPoints()
		PlayerFrameHealthBarText:SetPoint("CENTER", PlayerFrameHealthBar, 0, 0)
		PlayerFrameManaBar:SetWidth(117)
		PlayerFrameManaBar.LeftText:ClearAllPoints()
		PlayerFrameManaBar.LeftText:SetPoint("LEFT", PlayerFrameManaBar, 2, 0)
		PlayerFrameManaBar.RightText:ClearAllPoints()
		PlayerFrameManaBar.RightText:SetPoint("RIGHT", PlayerFrameManaBar, 0, 0)
		PlayerFrameManaBarText:ClearAllPoints()
		PlayerFrameManaBarText:SetPoint("CENTER", PlayerFrameManaBar, 0, 0)
		PlayerName:SetAlpha(0)
	end)

	if isClassic() then
		-- Changes the status bar text to reflect live.

		PlayerFrameHealthBarText:SetFontObject(SystemFont_Outline_Small)
		PlayerFrameHealthBarTextLeft:SetFontObject(SystemFont_Outline_Small)
		PlayerFrameHealthBarTextRight:SetFontObject(SystemFont_Outline_Small)
		PlayerFrameManaBarText:SetFontObject(SystemFont_Outline_Small)
		PlayerFrameManaBarTextLeft:SetFontObject(SystemFont_Outline_Small)
		PlayerFrameManaBarTextRight:SetFontObject(SystemFont_Outline_Small)
	else
		-- Fixes the vehicle frame.

		hooksecurefunc("PlayerFrame_ToVehicleArt", function(self, vehicleType)
			if vehicleType == "Natural" then
				PlayerFrameHealthBar:SetSize(103, 12)
				PlayerFrameHealthBar:ClearAllPoints()
				PlayerFrameHealthBar:SetPoint("TOPLEFT", 116, -41)
				PlayerFrameManaBar:SetSize(103, 12)
				PlayerFrameManaBar:ClearAllPoints()
				PlayerFrameManaBar:SetPoint("TOPLEFT", 116, -52)
			else
				PlayerFrameHealthBar:SetSize(100, 12)
				PlayerFrameHealthBar:ClearAllPoints()
				PlayerFrameHealthBar:SetPoint("TOPLEFT", 119, -41)
				PlayerFrameManaBar:SetSize(100, 12)
				PlayerFrameManaBar:ClearAllPoints()
				PlayerFrameManaBar:SetPoint("TOPLEFT", 119, -52)
			end

			PlayerName:SetAlpha(1)
			PlayerName:ClearAllPoints()
			PlayerName:SetPoint("CENTER", 50, 23)
		end)
	end

	-- Fixes the level text positioning on the player frame.

	hooksecurefunc("PlayerFrame_UpdateLevelTextAnchor", function(level)
		if isClassic() then
			if cfg.bigPlayerHealthBar then
				PlayerLevelText:ClearAllPoints()
				PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -53.5, -2.5)
			else
				PlayerLevelText:ClearAllPoints()
				PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -53.5, -4.5)
			end
		else
			if cfg.bigPlayerHealthBar then
				if level < 10 then
					PlayerLevelText:ClearAllPoints()
					PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -53.5, -2.5)
				elseif level < 100 then
					PlayerLevelText:ClearAllPoints()
					PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -52.5, -2.5)
				else
					PlayerLevelText:ClearAllPoints()
					PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -53.5, -2.5)
				end
			else
				if level < 10 then
					PlayerLevelText:ClearAllPoints()
					PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -53.5, -4.5)
				elseif level < 100 then
					PlayerLevelText:ClearAllPoints()
					PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -52.5, -4.5)
				else
					PlayerLevelText:ClearAllPoints()
					PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -53.5, -4.5)
				end
			end
		end
	end)

	-- Hides the damage/healing spam on player and pet frames.

	if cfg.hideHitIndicators then
		hooksecurefunc(PetHitIndicator, "Show", PetHitIndicator.Hide)
		hooksecurefunc(PlayerHitIndicator, "Show", PlayerHitIndicator.Hide)
	end

	-- Hides the pet frame status bar text.

	if cfg.hidePetStatusText then
		PetFrameHealthBarText:SetAlpha(0)
		PetFrameHealthBarTextLeft:SetAlpha(0)
		PetFrameHealthBarTextRight:SetAlpha(0)
		PetFrameManaBarText:SetAlpha(0)
		PetFrameManaBarTextLeft:SetAlpha(0)
		PetFrameManaBarTextRight:SetAlpha(0)
	end

	-- Hides the resting glow and resting icon on the player frame.

	hooksecurefunc("PlayerFrame_UpdateStatus", function()
		if cfg.hideRestingIcon then
			PlayerRestIcon:SetAlpha(0)
		end

		PlayerRestGlow:SetAlpha(0)
		PlayerStatusTexture:Hide()
	end)

	-- Hides the totem duration text if you use OmniCC or tullaCC.

	if IsAddOnLoaded("OmniCC") or IsAddOnLoaded("tullaCC") then
		TotemFrameTotem1Duration:SetAlpha(0)
		TotemFrameTotem2Duration:SetAlpha(0)
		TotemFrameTotem3Duration:SetAlpha(0)
		TotemFrameTotem4Duration:SetAlpha(0)
	end
end
