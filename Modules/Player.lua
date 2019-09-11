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

			PlayerFrameHealthBar:SetHeight(29)
			PlayerFrameManaBar:SetHeight(12)
			PlayerFrameManaBar:ClearAllPoints()
			PlayerFrameManaBar:SetPoint("TOPLEFT", 107, -52)
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

			PlayerFrameHealthBar:SetHeight(20)
			PlayerFrameManaBar:SetHeight(19)
			PlayerFrameManaBar:ClearAllPoints()
			PlayerFrameManaBar:SetPoint("TOPLEFT", 107, -44)

			if not isClassic() then
				InsanityBarFrame.InsanitySpark:ClearAllPoints()
				InsanityBarFrame.InsanitySpark:SetPoint("CENTER", InsanityBarFrame.InsanityOn.Tentacles, "RIGHT", 0, 9)
				PlayerFrameManaBar.FeedbackFrame:ClearAllPoints()
				PlayerFrameManaBar.FeedbackFrame:SetPoint("CENTER", PlayerFrameManaBar, 0, 0)
				PlayerFrameManaBar.FeedbackFrame:SetSize(119, 19)
				PlayerFrameManaBar.FullPowerFrame:SetSize(119, 19)
				PlayerFrameManaBar.FullPowerFrame.PulseFrame:ClearAllPoints()
				PlayerFrameManaBar.FullPowerFrame.PulseFrame:SetPoint("CENTER", PlayerFrameManaBar.FullPowerFrame, -6, 0)
				PlayerFrameManaBar.FullPowerFrame.PulseFrame:SetSize(119, 19)
				PlayerFrameManaBar.FullPowerFrame.SpikeFrame:SetSize(119, 19)
				PlayerFrameManaBar.FullPowerFrame.SpikeFrame.AlertSpikeStay:ClearAllPoints()
				PlayerFrameManaBar.FullPowerFrame.SpikeFrame.AlertSpikeStay:SetPoint("CENTER", PlayerFrameManaBar.FullPowerFrame, "RIGHT", -6, -1)
				PlayerFrameManaBar.FullPowerFrame.SpikeFrame.AlertSpikeStay:SetSize(30, 29)
				PlayerFrameManaBar.FullPowerFrame.SpikeFrame.BigSpikeGlow:ClearAllPoints()
				PlayerFrameManaBar.FullPowerFrame.SpikeFrame.BigSpikeGlow:SetPoint("CENTER", PlayerFrameManaBar.FullPowerFrame, "RIGHT", 5, -2)
				PlayerFrameManaBar.FullPowerFrame.SpikeFrame.BigSpikeGlow:SetSize(30, 50)
			end
		end

		if isClassic() then
			PlayerRestIcon:ClearAllPoints()
			PlayerRestIcon:SetPoint("TOPLEFT", 39, -50)
			PlayerAttackIcon:ClearAllPoints()
			PlayerAttackIcon:SetPoint("TOPLEFT", PlayerRestIcon, 1, 1)
		end

		PlayerFrameBackground:ClearAllPoints()
		PlayerFrameBackground:SetPoint("TOPLEFT", 107, -23)
		PlayerFrameBackground:SetSize(119, 40)
		PlayerFrameGroupIndicatorLeft:SetAlpha(0)
		PlayerFrameGroupIndicatorMiddle:SetAlpha(0)
		PlayerFrameGroupIndicatorRight:SetAlpha(0)
		PlayerFrameGroupIndicatorText:ClearAllPoints()
		PlayerFrameGroupIndicatorText:SetPoint("BOTTOMLEFT", PlayerFrame, "TOP", 0, -18.5)
		PlayerFrameHealthBar:ClearAllPoints()
		PlayerFrameHealthBar:SetPoint("TOPLEFT", 107, -23)
		PlayerFrameHealthBar:SetWidth(119)
		PlayerFrameHealthBar.LeftText:ClearAllPoints()
		PlayerFrameHealthBar.LeftText:SetPoint("LEFT", PlayerFrameHealthBar, 2.5, -0.5)
		PlayerFrameHealthBar.RightText:ClearAllPoints()
		PlayerFrameHealthBar.RightText:SetPoint("RIGHT", PlayerFrameHealthBar, -1, -0.5)
		PlayerFrameHealthBarText:ClearAllPoints()
		PlayerFrameHealthBarText:SetPoint("CENTER", PlayerFrameHealthBar, 0, -0.5)
		PlayerFrameManaBar:SetWidth(119)
		PlayerFrameManaBar.LeftText:ClearAllPoints()
		PlayerFrameManaBar.LeftText:SetPoint("LEFT", PlayerFrameManaBar, 2.5, -0.5)
		PlayerFrameManaBar.RightText:ClearAllPoints()
		PlayerFrameManaBar.RightText:SetPoint("RIGHT", PlayerFrameManaBar, -1, -0.5)
		PlayerFrameManaBarText:ClearAllPoints()
		PlayerFrameManaBarText:SetPoint("CENTER", PlayerFrameManaBar, 0, -0.5)
		PlayerName:SetAlpha(0)
	end)

	-- Changes the status bar text to reflect live.

	if isClassic() then
		PlayerFrameHealthBarText:SetFontObject(SystemFont_Outline_Small)
		PlayerFrameHealthBarTextLeft:SetFontObject(SystemFont_Outline_Small)
		PlayerFrameHealthBarTextRight:SetFontObject(SystemFont_Outline_Small)
		PlayerFrameManaBarText:SetFontObject(SystemFont_Outline_Small)
		PlayerFrameManaBarTextLeft:SetFontObject(SystemFont_Outline_Small)
		PlayerFrameManaBarTextRight:SetFontObject(SystemFont_Outline_Small)
	end

	-- Fixes the vehicle frame.

	if not isClassic() then
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
				if level < 10 then
					PlayerLevelText:ClearAllPoints()
					PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -52.5, -1.5)
				else
					PlayerLevelText:ClearAllPoints()
					PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -51.5, -1.5)
				end
			else
				if level < 10 then
					PlayerLevelText:ClearAllPoints()
					PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -52.5, -3.5)
				else
					PlayerLevelText:ClearAllPoints()
					PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -51.5, -3.5)
				end
			end
		else
			if cfg.bigPlayerHealthBar then
				if level >= 100 or level < 10 then
					PlayerLevelText:ClearAllPoints()
					PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -52.5, -1.5)
				else
					PlayerLevelText:ClearAllPoints()
					PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -51.5, -1.5)
				end
			else
				if level >= 100 or level < 10 then
					PlayerLevelText:ClearAllPoints()
					PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -52.5, -3.5)
				else
					PlayerLevelText:ClearAllPoints()
					PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -51.5, -3.5)
				end
			end
		end
	end)

	-- Fixes the pet frame health and resource bars.

	PetFrameHealthBar:ClearAllPoints()
	PetFrameHealthBar:SetPoint("TOPLEFT", 45, -22)
	PetFrameManaBar:ClearAllPoints()
	PetFrameManaBar:SetPoint("TOPLEFT", 45, -29.5)

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
