function PlayerFrameStyling()
	-- Styles the player frame.

	hooksecurefunc("PlayerFrame_ToPlayerArt", function(self)
		local function BigStyling()
			PlayerFrameHealthBar:SetHeight(29)
			PlayerFrameHealthBar:ClearAllPoints()
			PlayerFrameHealthBar:SetPoint("TOPLEFT", 107, -23)
			PlayerFrameManaBar:SetHeight(12)
			PlayerFrameManaBar:ClearAllPoints()
			PlayerFrameManaBar:SetPoint("TOPLEFT", 107, -52)
			PlayerName:SetAlpha(0)
		end

		local function DefaultStyling()
			PlayerFrameHealthBar:ClearAllPoints()
			PlayerFrameHealthBar:SetPoint("TOPLEFT", 107, -41)
			PlayerFrameManaBar:SetHeight(12)
			PlayerFrameManaBar:ClearAllPoints()
			PlayerFrameManaBar:SetPoint("TOPLEFT", 107, -52)
		end

		local function WhoaStyling()
			PlayerFrameHealthBar:SetHeight(20)
			PlayerFrameHealthBar:ClearAllPoints()
			PlayerFrameHealthBar:SetPoint("TOPLEFT", 107, -23)
			PlayerFrameManaBar:SetHeight(19)
			PlayerFrameManaBar:ClearAllPoints()
			PlayerFrameManaBar:SetPoint("TOPLEFT", 107, -44)
			PlayerName:SetAlpha(0)

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

		if eufCharacterDB.enabled then
			if eufCharacterDB.bigPlayerFrame then
				if eufCharacterDB.elitePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\BigElite")
				elseif eufCharacterDB.rareElitePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\BigRareElite")
				elseif eufCharacterDB.rarePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\BigRare")
				else
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Big")
				end

				BigStyling()
			elseif eufCharacterDB.defaultPlayerFrame then
				if eufCharacterDB.elitePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\DefaultElite")
				elseif eufCharacterDB.rareElitePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\DefaultRareElite")
				elseif eufCharacterDB.rarePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\DefaultRare")
				else
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Default")
				end

				DefaultStyling()
			elseif eufCharacterDB.whoaPlayerFrame then
				if eufCharacterDB.elitePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\WhoaElite")
				elseif eufCharacterDB.rareElitePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\WhoaRareElite")
				elseif eufCharacterDB.rarePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\WhoaRare")
				else
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Whoa")
				end

				WhoaStyling()
			end

			if eufCharacterDB.hidePowerAnimation then
				PlayerFrameManaBar.FullPowerFrame:SetAlpha(0)
			end
		else
			if eufDB.bigPlayerFrame then
				if eufDB.elitePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\BigElite")
				elseif eufDB.rareElitePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\BigRareElite")
				elseif eufDB.rarePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\BigRare")
				else
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Big")
				end

				BigStyling()
			elseif eufDB.defaultPlayerFrame then
				if eufDB.elitePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\DefaultElite")
				elseif eufDB.rareElitePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\DefaultRareElite")
				elseif eufDB.rarePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\DefaultRare")
				else
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Default")
				end

				DefaultStyling()
			elseif eufDB.whoaPlayerFrame then
				if eufDB.elitePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\WhoaElite")
				elseif eufDB.rareElitePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\WhoaRareElite")
				elseif eufDB.rarePlayerFrame then
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\WhoaRare")
				else
					PlayerFrameTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Whoa")
				end

				WhoaStyling()
			end

			if eufDB.hidePowerAnimation then
				PlayerFrameManaBar.FullPowerFrame:Hide()
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
		PlayerFrameHealthBar:SetWidth(119)
		PlayerFrameHealthBar.LeftText:SetJustifyH("RIGHT")
		PlayerFrameHealthBar.LeftText:SetWidth(40)
		PlayerFrameHealthBar.LeftText:ClearAllPoints()
		PlayerFrameHealthBar.LeftText:SetPoint("LEFT", PlayerFrameHealthBar, -1.5, -0.5)
		PlayerFrameHealthBar.RightText:SetJustifyH("RIGHT")
		PlayerFrameHealthBar.RightText:SetWidth(75)
		PlayerFrameHealthBar.RightText:ClearAllPoints()
		PlayerFrameHealthBar.RightText:SetPoint("RIGHT", PlayerFrameHealthBar, -3.5, -0.5)
		PlayerFrameHealthBar.TextString:ClearAllPoints()
		PlayerFrameHealthBar.TextString:SetPoint("CENTER", PlayerFrameHealthBar, 0, -0.5)
		PlayerFrameManaBar:SetWidth(119)
		PlayerFrameManaBar.LeftText:SetJustifyH("RIGHT")
		PlayerFrameManaBar.LeftText:SetWidth(40)
		PlayerFrameManaBar.LeftText:ClearAllPoints()
		PlayerFrameManaBar.LeftText:SetPoint("LEFT", PlayerFrameManaBar, -1.5, 0)
		PlayerFrameManaBar.RightText:SetJustifyH("RIGHT")
		PlayerFrameManaBar.RightText:SetWidth(75)
		PlayerFrameManaBar.RightText:ClearAllPoints()
		PlayerFrameManaBar.RightText:SetPoint("RIGHT", PlayerFrameManaBar, -3.5, 0)
		PlayerFrameManaBar.TextString:ClearAllPoints()
		PlayerFrameManaBar.TextString:SetPoint("CENTER", PlayerFrameManaBar, 0, 0)

		-- Changes the status bar text to reflect live.

		if isClassic() then
			PlayerFrameHealthBar.LeftText:SetFontObject(SystemFont_Outline_Small)
			PlayerFrameHealthBar.RightText:SetFontObject(SystemFont_Outline_Small)
			PlayerFrameHealthBar.TextString:SetFontObject(SystemFont_Outline_Small)
			PlayerFrameManaBar.LeftText:SetFontObject(SystemFont_Outline_Small)
			PlayerFrameManaBar.RightText:SetFontObject(SystemFont_Outline_Small)
			PlayerFrameManaBar.TextString:SetFontObject(SystemFont_Outline_Small)
		end
	end)

	-- Styles the pet frame.

	hooksecurefunc("PetFrame_Update", function(self, override)
		PetFrameHealthBar:ClearAllPoints()
		PetFrameHealthBar:SetPoint("TOPLEFT", 45, -22)
		PetFrameHealthBar.TextString:ClearAllPoints()
		PetFrameHealthBar.TextString:SetPoint("CENTER", PetFrameHealthBar, 0, 0.5)
		PetFrameManaBar:ClearAllPoints()
		PetFrameManaBar:SetPoint("TOPLEFT", 45, -29.5)
		PetFrameManaBar.TextString:ClearAllPoints()
		PetFrameManaBar.TextString:SetPoint("CENTER", PetFrameManaBar, 0, -1.5)
	end)

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
		local function OneHundredPlus()
			PlayerLevelText:ClearAllPoints()
			PlayerLevelText:SetPoint("CENTER", PlayerFrameManaBar, "BOTTOMLEFT", -52.5, -2.5)
		end

		local function BelowOneHundred()
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

		if eufCharacterDB.enabled then
			if eufCharacterDB.bigPlayerFrame or eufCharacterDB.defaultPlayerFrame then
				if level >= 100 then
					OneHundredPlus()
				else
					BelowOneHundred()
				end
			elseif eufDB.whoaPlayerFrame then
				if level >= 100 then
					WhoaOneHundredPlus()
				else
					WhoaBelowOneHundred()
				end
			end
		else
			if eufDB.bigPlayerFrame or eufDB.defaultPlayerFrame then
				if level >= 100 then
					OneHundredPlus()
				else
					BelowOneHundred()
				end
			elseif eufDB.whoaPlayerFrame then
				if level >= 100 then
					WhoaOneHundredPlus()
				else
					WhoaBelowOneHundred()
				end
			end
		end
	end)

	-- Hides the damage/healing indicator on player and pet frames.

	local function HitIndicator()
		hooksecurefunc(PetHitIndicator, "Show", PetHitIndicator.Hide)
		hooksecurefunc(PlayerHitIndicator, "Show", PlayerHitIndicator.Hide)
	end

	if eufCharacterDB.enabled then
		if eufCharacterDB.hideHitIndicator then
			HitIndicator()
		end
	else
		if eufDB.hideHitIndicator then
			HitIndicator()
		end
	end

	-- Hides the resting glow and resting icon on the player frame.

	hooksecurefunc("PlayerFrame_UpdateStatus", function()
		if eufCharacterDB.enabled then
			if eufCharacterDB.hideRestingIcon then
				PlayerRestIcon:SetAlpha(0)
			end
		else
			if eufDB.hideRestingIcon then
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
