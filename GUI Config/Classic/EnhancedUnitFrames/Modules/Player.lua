function PlayerFrameStyling()
	hooksecurefunc("PlayerFrame_ToPlayerArt", function(self)
		-- Styles the player frame.

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

	-- Changes the status bar text to reflect live.

	PlayerFrameHealthBarText:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
	PlayerFrameHealthBarTextLeft:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
	PlayerFrameHealthBarTextRight:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
	PlayerFrameManaBarText:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
	PlayerFrameManaBarTextLeft:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
	PlayerFrameManaBarTextRight:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")

	hooksecurefunc("PlayerFrame_UpdateLevelTextAnchor", function(level)
		-- Fixes the level text positioning on the player frame.

		if cfg.bigPlayerHealthBar then
			PlayerLevelText:ClearAllPoints()
			PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -53.5, -2.5)
		else
			PlayerLevelText:ClearAllPoints()
			PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -53.5, -4.5)
		end
	end)

	if cfg.hideHitIndicators then
		-- Fixes the level text positioning on the player frame.

		hooksecurefunc(PetHitIndicator, "Show", PetHitIndicator.Hide)
		hooksecurefunc(PlayerHitIndicator, "Show", PlayerHitIndicator.Hide)
	end

	hooksecurefunc("PlayerFrame_UpdateStatus", function()
		-- Hides the resting glow and resting icon on the player frame.

		if cfg.hideRestingIcon then
			PlayerRestIcon:SetAlpha(0)
		end

		PlayerRestGlow:SetAlpha(0)
		PlayerStatusTexture:Hide()
	end)

	if cfg.hidePetStatusText then
		-- Hides the pet frame status bar text if enabled.

		PetFrameHealthBarText:SetAlpha(0)
		PetFrameHealthBarTextLeft:SetAlpha(0)
		PetFrameHealthBarTextRight:SetAlpha(0)
		PetFrameManaBarText:SetAlpha(0)
		PetFrameManaBarTextLeft:SetAlpha(0)
		PetFrameManaBarTextRight:SetAlpha(0)
	end

	if IsAddOnLoaded("OmniCC") or IsAddOnLoaded("tullaCC") then
		-- Hides the totem duration text if you use OmniCC or tullaCC.

		TotemFrameTotem1Duration:SetAlpha(0)
		TotemFrameTotem2Duration:SetAlpha(0)
		TotemFrameTotem3Duration:SetAlpha(0)
		TotemFrameTotem4Duration:SetAlpha(0)
	end
end
