function PlayerFrameStyling()
	-- Styles the player frame.

	hooksecurefunc("PlayerFrame_ToPlayerArt", function(self)
		local function BigStyling()
			PlayerFrameHealthBar:SetHeight(29)
			PlayerFrameManaBar:SetHeight(12)
			PlayerFrameManaBar:ClearAllPoints()
			PlayerFrameManaBar:SetPoint("TOPLEFT", 107, -52)
		end

		local function WhoaStyling()
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

		if eufCfgCharacter.enabled then
			if eufCfgCharacter.bigPlayerHealthBar then
				if eufCfgCharacter.elitePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameElite")
				elseif eufCfgCharacter.rareElitePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRareElite")
				elseif eufCfgCharacter.rarePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRare")
				else
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrame")
				end

				BigStyling()
			else
				if eufCfgCharacter.elitePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameEliteWhoa")
				elseif eufCfgCharacter.rareElitePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRareEliteWhoa")
				elseif eufCfgCharacter.rarePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRareWhoa")
				else
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameWhoa")
				end

				WhoaStyling()
			end
		else
			if eufCfg.bigPlayerHealthBar then
				if eufCfg.elitePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameElite")
				elseif eufCfg.rareElitePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRareElite")
				elseif eufCfg.rarePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRare")
				else
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrame")
				end

				BigStyling()
			else
				if eufCfg.elitePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameEliteWhoa")
				elseif eufCfg.rareElitePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRareEliteWhoa")
				elseif eufCfg.rarePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRareWhoa")
				else
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameWhoa")
				end

				WhoaStyling()
			end
		end

		if isClassic() then
			PlayerRestIcon:ClearAllPoints()
			PlayerRestIcon:SetPoint("TOPLEFT", 39, -50)
			PlayerAttackGlow:SetAlpha(0)
			PlayerAttackIcon:ClearAllPoints()
			PlayerAttackIcon:SetPoint("TOPLEFT", PlayerRestIcon, 1, 1)
		else
			if C_CVar.GetCVar("threatWarning") == "0" then
				PlayerAttackGlow:SetAlpha(0)
			end
		end

		PlayerAttackBackground:SetAlpha(0.4)
		PlayerAttackBackground:SetVertexColor(0, 0, 0)
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
		PlayerFrameHealthBar.LeftText:SetJustifyH("RIGHT")
		PlayerFrameHealthBar.LeftText:SetWidth(40)
		PlayerFrameHealthBar.LeftText:ClearAllPoints()
		PlayerFrameHealthBar.LeftText:SetPoint("LEFT", PlayerFrameHealthBar, -1.5, -0.5)
		PlayerFrameHealthBar.RightText:SetJustifyH("RIGHT")
		PlayerFrameHealthBar.RightText:SetWidth(75)
		PlayerFrameHealthBar.RightText:ClearAllPoints()
		PlayerFrameHealthBar.RightText:SetPoint("RIGHT", PlayerFrameHealthBar, -3.5, -0.5)
		PlayerFrameHealthBarText:ClearAllPoints()
		PlayerFrameHealthBarText:SetPoint("CENTER", PlayerFrameHealthBar, 0, -0.5)
		PlayerFrameManaBar:SetWidth(119)
		PlayerFrameManaBar.LeftText:SetJustifyH("RIGHT")
		PlayerFrameManaBar.LeftText:SetWidth(40)
		PlayerFrameManaBar.LeftText:ClearAllPoints()
		PlayerFrameManaBar.LeftText:SetPoint("LEFT", PlayerFrameManaBar, -1.5, 0)
		PlayerFrameManaBar.RightText:SetJustifyH("RIGHT")
		PlayerFrameManaBar.RightText:SetWidth(75)
		PlayerFrameManaBar.RightText:ClearAllPoints()
		PlayerFrameManaBar.RightText:SetPoint("RIGHT", PlayerFrameManaBar, -3.5, 0)
		PlayerFrameManaBarText:ClearAllPoints()
		PlayerFrameManaBarText:SetPoint("CENTER", PlayerFrameManaBar, 0, 0)
		PlayerName:SetAlpha(0)
	end)

	-- Styles the pet frame.

	PetFrameHealthBar:ClearAllPoints()
	PetFrameHealthBar:SetPoint("TOPLEFT", 45, -22)
	PetFrameHealthBarText:ClearAllPoints()
	PetFrameHealthBarText:SetPoint("CENTER", PetFrameHealthBar, 0, 0.5)
	PetFrameHealthBarTextLeft:ClearAllPoints()
	PetFrameHealthBarTextLeft:SetPoint("CENTER", PetFrameHealthBar, 0, 0.5)
	PetFrameHealthBarTextRight:SetAlpha(0)
	PetFrameManaBar:ClearAllPoints()
	PetFrameManaBar:SetPoint("TOPLEFT", 45, -29.5)
	PetFrameManaBarText:ClearAllPoints()
	PetFrameManaBarText:SetPoint("CENTER", PetFrameManaBar, 0, -1.5)
	PetFrameManaBarTextLeft:SetAlpha(0)
	PetFrameManaBarTextRight:ClearAllPoints()
	PetFrameManaBarTextRight:SetPoint("CENTER", PetFrameManaBar, 0, -1.5)

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
		local function BigOneHundredPlus()
			PlayerLevelText:ClearAllPoints()
			PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -52.5, -2.5)
		end

		local function BigBelowOneHundred()
			PlayerLevelText:ClearAllPoints()
			PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -51.5, -2.5)
		end

		local function WhoaOneHundredPlus()
			PlayerLevelText:ClearAllPoints()
			PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -52.5, -3.5)
		end

		local function WhoaBelowOneHundred()
			PlayerLevelText:ClearAllPoints()
			PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -51.5, -3.5)
		end

		if eufCfgCharacter.enabled then
			if eufCfgCharacter.bigPlayerHealthBar then
				if level >= 100 then
					BigOneHundredPlus()
				else
					BigBelowOneHundred()
				end
			else
				if level >= 100 then
					WhoaOneHundredPlus()
				else
					WhoaBelowOneHundred()
				end
			end
		else
			if eufCfg.bigPlayerHealthBar then
				if level >= 100 then
					BigOneHundredPlus()
				else
					BigBelowOneHundred()
				end
			else
				if level >= 100 then
					WhoaOneHundredPlus()
				else
					WhoaBelowOneHundred()
				end
			end
		end
	end)

	-- Hides the damage/healing spam on player and pet frames.

	local function HitIndicators()
		hooksecurefunc(PetHitIndicator, "Show", PetHitIndicator.Hide)
		hooksecurefunc(PlayerHitIndicator, "Show", PlayerHitIndicator.Hide)
	end

	if eufCfgCharacter.enabled then
		if eufCfgCharacter.hideHitIndicators then
			HitIndicators()
		end
	else
		if eufCfg.hideHitIndicators then
			HitIndicators()
		end
	end

	-- Hides the pet frame status bar text.

	local function PetStatusText()
		PetFrameHealthBarText:SetAlpha(0)
		PetFrameHealthBarTextLeft:SetAlpha(0)
		PetFrameHealthBarTextRight:SetAlpha(0)
		PetFrameManaBarText:SetAlpha(0)
		PetFrameManaBarTextLeft:SetAlpha(0)
		PetFrameManaBarTextRight:SetAlpha(0)
	end

	if eufCfgCharacter.enabled then
		if eufCfgCharacter.hidePetStatusText then
			PetStatusText()
		end
	else
		if eufCfg.hidePetStatusText then
			PetStatusText()
		end
	end

	-- Hides the resting glow and resting icon on the player frame.

	hooksecurefunc("PlayerFrame_UpdateStatus", function()
		if eufCfgCharacter.enabled then
			if eufCfgCharacter.hideRestingIcon then
				PlayerRestIcon:SetAlpha(0)
			end
		else
			if eufCfg.hideRestingIcon then
				PlayerRestIcon:SetAlpha(0)
			end
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
