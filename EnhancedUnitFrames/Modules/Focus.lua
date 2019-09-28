function FocusFrameStyling()
	-- Changes the aura icon sizes and automatically changes their row's width based on the width of the focus frame.

	local function AuraStyling()
		hooksecurefunc("TargetFrame_UpdateAuraPositions", function(self, auraName, numAuras, numOppositeAuras, largeAuraList, updateFunc, maxRowWidth, offsetX, mirrorAurasVertically)
			local selfName = self:GetName()

			if selfName and selfName:match("FocusFrame") then
				local AURA_OFFSET_Y = 3
				local AURA_ROW_WIDTH = 90 + (wideFocusFrameWidth - 230)
				local NUM_TOT_AURA_ROWS = 2
				local size
				local offsetY = AURA_OFFSET_Y
				local rowWidth = 0
				local firstBuffOnRow = 1
				local maxRowWidth = 90 + (wideFocusFrameWidth - 230)

				for i = 1, numAuras do
					if largeAuraList[i] then
						size = LARGE_AURA_SIZE
						offsetY = AURA_OFFSET_Y + AURA_OFFSET_Y
					else
						size = SMALL_AURA_SIZE
					end

					if i == 1 then
						rowWidth = size
						FocusFrame.auraRows = FocusFrame.auraRows + 1
					else
						rowWidth = rowWidth + size + offsetX
					end

					if rowWidth > maxRowWidth then
						updateFunc(FocusFrame, auraName, i, numOppositeAuras, firstBuffOnRow, size, offsetX, offsetY, mirrorAurasVertically)

						rowWidth = size
						FocusFrame.auraRows = FocusFrame.auraRows + 1
						firstBuffOnRow = i
						offsetY = AURA_OFFSET_Y

						if FocusFrame.auraRows > NUM_TOT_AURA_ROWS then
							maxRowWidth = AURA_ROW_WIDTH
						end
					else
						updateFunc(FocusFrame, auraName, i, numOppositeAuras, i - 1, size, offsetX, offsetY, mirrorAurasVertically)
					end
				end
			end
		end)
	end

	if eufCharacterDB.enabled then
		LARGE_AURA_SIZE = eufCharacterDB.largeAuraIconSize
		SMALL_AURA_SIZE = eufCharacterDB.smallAuraIconSize

		if eufCharacterDB.wideFocusFrame and eufCharacterDB.wideFocusFrameWidth >= 231 then
			wideFocusFrameWidth = eufCharacterDB.wideFocusFrameWidth
		else
			wideFocusFrameWidth = 230
		end

		AuraStyling()
	else
		LARGE_AURA_SIZE = eufDB.largeAuraIconSize
		SMALL_AURA_SIZE = eufDB.smallAuraIconSize

		if eufDB.wideFocusFrame and eufDB.wideFocusFrameWidth >= 231 then
			wideFocusFrameWidth = eufDB.wideFocusFrameWidth
		else
			wideFocusFrameWidth = 230
		end

		AuraStyling()
	end

	-- Source: Wide Target by Gello.
	-- Makes the focus frame wider.

	local function WideFocus()
		local cx = 232
		local cy = 100
		local frame = FocusFrame.textureFrame
		local left = frame:CreateTexture(nil, "BACKGROUND")
		local mid = frame:CreateTexture(nil, "BACKGROUND")
		local tex = FocusFrame.borderTexture

		hooksecurefunc(tex, "SetGradientAlpha", function(self, ...)
			left:SetGradientAlpha(...)
			mid:SetGradientAlpha(...)
		end)

		hooksecurefunc(tex, "SetTexture", function(self, texture)
			left:SetTexture(texture)
			mid:SetTexture(texture)
		end)

		hooksecurefunc(tex, "SetVertexColor", function(self, ...)
			left:SetVertexColor(...)
			mid:SetVertexColor(...)
		end)

		left:SetSize(cx / 4, cy)
		left:SetPoint("TOPLEFT")
		left:SetTexCoord(0.09375, 0.3203125, 0, 0.78125)
		tex:ClearAllPoints()
		tex:SetPoint("TOPRIGHT", frame)
		tex:SetSize(cx / 2, cy)
		tex:SetTexCoord(0.546875, 1, 0, 0.78125)
		mid:SetPoint("TOPLEFT", left, "TOPRIGHT")
		mid:SetPoint("BOTTOMRIGHT", tex, "BOTTOMLEFT")
		mid:SetTexCoord(0.3203125, 0.546875, 0, 0.78125)

		local r, g, b, a = tex:GetVertexColor()

		left:SetVertexColor(r, g, b, a)
		mid:SetVertexColor(r, g, b, a)

		local flash = FocusFrameFlash
		flash.midFlash = FocusFrame:CreateTexture(nil, "BACKGROUND")
		flash.rightFlash = FocusFrame:CreateTexture(nil, "BACKGROUND")

		hooksecurefunc(flash, "Hide", function(self)
			self.midFlash:Hide()
			self.rightFlash:Hide()
		end)

		hooksecurefunc(flash, "SetTexture", function(self, texture)
			flash.midFlash:SetTexture(texture)
			flash.rightFlash:SetTexture(texture)
		end)

		hooksecurefunc(flash, "SetPoint", function(self, anchorPoint, relativeTo, relativePoint, xoff, yoff)
			local cx = self:GetWidth()
			local cy = self:GetHeight()
			local specificXoff

			self:SetWidth(cx / 2)
			self.midFlash:SetHeight(cy)
			self.rightFlash:SetWidth(cx / 2)
			self.rightFlash:SetHeight(cy)

			if cy < 100 then
				self:SetTexCoord(0, 0.47265625, 0, 0.181640625)
				self.midFlash:SetTexCoord(0.25, 0.5, 0, 0.181640625)
				self.rightFlash:SetTexCoord(0.47265625, 0.9453125, 0, 0.181640625)

				specificXoff = -38
			elseif cx > 255 then
				self:SetTexCoord(0, .5, 0, 1)
				self.midFlash:SetTexCoord(0.25, 0.5, 0, 1)
				self.rightFlash:SetTexCoord(.5, 1, 0, 1)

				specificXoff = -24
			elseif cy > 100 then
				self:SetTexCoord(0, 0.47265625, 0.181640625, 0.400390625)
				self.midFlash:SetTexCoord(0.19, 0.39, 0.181640625, 0.400390625)
				self.rightFlash:SetTexCoord(0.47265625, 0.9453125, 0.181640625, 0.400390625)

				specificXoff = -34
			end

			self.rightFlash:SetPoint("TOPRIGHT", FocusFrame, "TOPRIGHT", specificXoff - xoff, yoff)
			self.midFlash:SetPoint("TOPLEFT", self, "TOPRIGHT")
			self.midFlash:SetPoint("BOTTOMRIGHT", self.rightFlash, "BOTTOMLEFT")
		end)

		hooksecurefunc(flash, "SetVertexColor", function(self, ...)
			self.midFlash:SetVertexColor(...)
			self.rightFlash:SetVertexColor(...)
		end)

		hooksecurefunc(flash, "Show", function(self)
			self.midFlash:Show()
			self.rightFlash:Show()
		end)

		FocusFrame:SetWidth(focusWidth)
	end

	if eufCharacterDB.enabled then
		focusWidth = eufCharacterDB.wideFocusFrameWidth

		if eufCharacterDB.wideFocusFrame and eufCharacterDB.wideFocusFrameWidth >= 231 then
			WideFocus()
		end
	else
		focusWidth = eufDB.wideFocusFrameWidth

		if eufDB.wideFocusFrame and eufDB.wideFocusFrameWidth >= 231 then
			WideFocus()
		end
	end

	-- Styles the focus frame.

	hooksecurefunc("TargetFrame_CheckClassification", function(self, forceNormalTexture)
		local classification = UnitClassification(FocusFrame.unit)

		local function FocusStyling()
			local function BigStyling()
				FocusFrame.healthbar:SetHeight(29)
				FocusFrame.healthbar:ClearAllPoints()
				FocusFrame.healthbar:SetPoint("TOPRIGHT", -107, -23)
				FocusFrame.highLevelTexture:ClearAllPoints()
				FocusFrame.highLevelTexture:SetPoint("CENTER", FocusFrame.manabar, "BOTTOMRIGHT", 52.5, -1.5)
				FocusFrame.manabar:SetHeight(12)
				FocusFrame.manabar:ClearAllPoints()
				FocusFrame.manabar:SetPoint("TOPRIGHT", -107, -52)
				FocusFrame.name:ClearAllPoints()
				FocusFrame.name:SetPoint("TOPLEFT", 8, -7.5)
				FocusFrame.name:SetPoint("BOTTOMRIGHT", FocusFrame, "TOPRIGHT", -110, -19.5)
				FocusFrame.nameBackground:Hide()
				FocusFrame.nameBackground:SetAlpha(0)
				FocusFrameManaBar.LeftText:ClearAllPoints()
				FocusFrameManaBar.LeftText:SetPoint("LEFT", FocusFrame.manabar, -1.5, -0.5)
				FocusFrameManaBar.RightText:ClearAllPoints()
				FocusFrameManaBar.RightText:SetPoint("RIGHT", FocusFrame.manabar, -3.5, -0.5)
				FocusFrameManaBar.TextString:ClearAllPoints()
				FocusFrameManaBar.TextString:SetPoint("CENTER", FocusFrame.manabar, 0, -0.5)
			end

			local function DefaultStyling()
				FocusFrame.highLevelTexture:ClearAllPoints()
				FocusFrame.highLevelTexture:SetPoint("CENTER", FocusFrame.manabar, "BOTTOMRIGHT", 52.5, -1.5)
				FocusFrame.healthbar:ClearAllPoints()
				FocusFrame.healthbar:SetPoint("TOPRIGHT", -107, -41)
				FocusFrame.manabar:SetHeight(12)
				FocusFrame.manabar:ClearAllPoints()
				FocusFrame.manabar:SetPoint("TOPRIGHT", -107, -52)
				FocusFrame.name:ClearAllPoints()
				FocusFrame.name:SetPoint("TOPLEFT", FocusFrame, "TOPLEFT", 8, -24.5)
				FocusFrame.name:SetPoint("BOTTOMRIGHT", FocusFrame, "TOPRIGHT", -110, -37.5)
				FocusFrame.nameBackground:SetPoint("TOPLEFT", FocusFrame, "TOPLEFT", 6, -22)
				FocusFrameManaBar.LeftText:ClearAllPoints()
				FocusFrameManaBar.LeftText:SetPoint("LEFT", FocusFrame.manabar, -1.5, -0.5)
				FocusFrameManaBar.RightText:ClearAllPoints()
				FocusFrameManaBar.RightText:SetPoint("RIGHT", FocusFrame.manabar, -3.5, -0.5)
				FocusFrameManaBar.TextString:ClearAllPoints()
				FocusFrameManaBar.TextString:SetPoint("CENTER", FocusFrame.manabar, 0, -0.5)
			end

			local function WhoaStyling()
				FocusFrame.healthbar:SetHeight(20)
				FocusFrame.healthbar:ClearAllPoints()
				FocusFrame.healthbar:SetPoint("TOPRIGHT", -107, -23)
				FocusFrame.highLevelTexture:ClearAllPoints()
				FocusFrame.highLevelTexture:SetPoint("CENTER", FocusFrame.manabar, "BOTTOMRIGHT", 52.5, -2.5)
				FocusFrame.manabar:SetHeight(19)
				FocusFrame.manabar:ClearAllPoints()
				FocusFrame.manabar:SetPoint("TOPRIGHT", -107, -44)
				FocusFrame.name:ClearAllPoints()
				FocusFrame.name:SetPoint("TOPLEFT", 8, -7.5)
				FocusFrame.name:SetPoint("BOTTOMRIGHT", FocusFrame, "TOPRIGHT", -110, -19.5)
				FocusFrame.nameBackground:Hide()
				FocusFrame.nameBackground:SetAlpha(0)
				FocusFrameManaBar.LeftText:ClearAllPoints()
				FocusFrameManaBar.LeftText:SetPoint("LEFT", FocusFrame.manabar, -1.5, 0)
				FocusFrameManaBar.RightText:ClearAllPoints()
				FocusFrameManaBar.RightText:SetPoint("RIGHT", FocusFrame.manabar, -3.5, 0)
				FocusFrameManaBar.TextString:ClearAllPoints()
				FocusFrameManaBar.TextString:SetPoint("CENTER", FocusFrame.manabar, 0, 0)
			end

			local function WideStyling()
				if eufCharacterDB.enabled then
					FocusFrameBackground:SetSize(eufCharacterDB.wideFocusFrameWidth - 113, 40)
					FocusFrame.Background:SetSize(eufCharacterDB.wideFocusFrameWidth - 113, 40)
					FocusFrame.healthbar:SetWidth(eufCharacterDB.wideFocusFrameWidth - 113)
					FocusFrame.manabar:SetWidth(eufCharacterDB.wideFocusFrameWidth - 113)
				else
					FocusFrameBackground:SetSize(eufDB.wideFocusFrameWidth - 113, 40)
					FocusFrame.Background:SetSize(eufDB.wideFocusFrameWidth - 113, 40)
					FocusFrame.healthbar:SetWidth(eufDB.wideFocusFrameWidth - 113)
					FocusFrame.manabar:SetWidth(eufDB.wideFocusFrameWidth - 113)
				end
			end

			local function NarrowStyling()
				FocusFrameBackground:SetSize(119, 40)
				FocusFrame.Background:SetSize(119, 40)
				FocusFrame.healthbar:SetWidth(119)
				FocusFrame.manabar:SetWidth(119)
			end

			if eufCharacterDB.enabled then
				if eufCharacterDB.bigFocusFrame then
					BigStyling()
				elseif eufCharacterDB.defaultFocusFrame then
					DefaultStyling()
				elseif eufCharacterDB.whoaFocusFrame then
					WhoaStyling()
				end

				if eufCharacterDB.wideFocusFrame and eufCharacterDB.wideFocusFrameWidth >= 231 then
					WideStyling()
				else
					NarrowStyling()
				end
			else
				if eufDB.bigFocusFrame then
					BigStyling()
				elseif eufDB.defaultFocusFrame then
					DefaultStyling()
				elseif eufDB.whoaFocusFrame then
					WhoaStyling()
				end

				if eufDB.wideFocusFrame and eufDB.wideFocusFrameWidth >= 231 then
					WideStyling()
				else
					NarrowStyling()
				end
			end

			FocusFrame.Background:ClearAllPoints()
			FocusFrame.Background:SetPoint("TOPRIGHT", -107, -23)
			FocusFrame.deadText:SetAlpha(0)
			FocusFrameHealthBar.LeftText:SetJustifyH("RIGHT")
			FocusFrameHealthBar.LeftText:SetWidth(40)
			FocusFrameHealthBar.LeftText:ClearAllPoints()
			FocusFrameHealthBar.LeftText:SetPoint("LEFT", FocusFrame.healthbar, -1.5, -0.5)
			FocusFrameHealthBar.RightText:SetJustifyH("RIGHT")
			FocusFrameHealthBar.RightText:SetWidth(75)
			FocusFrameHealthBar.RightText:ClearAllPoints()
			FocusFrameHealthBar.RightText:SetPoint("RIGHT", FocusFrame.healthbar, -3.5, -0.5)
			FocusFrameHealthBar.TextString:ClearAllPoints()
			FocusFrameHealthBar.TextString:SetPoint("CENTER", FocusFrame.healthbar, 0, -0.5)
			FocusFrameManaBar.LeftText:SetJustifyH("RIGHT")
			FocusFrameManaBar.LeftText:SetWidth(40)
			FocusFrameManaBar.RightText:SetJustifyH("RIGHT")
			FocusFrameManaBar.RightText:SetWidth(75)
		end

		if eufCharacterDB.enabled then
			if forceNormalTexture then
				if eufCharacterDB.bigFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Big")
				elseif eufCharacterDB.defaultFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Default")					
				elseif eufCharacterDB.whoaFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Whoa")
				end
			elseif classification == "minus" then
				forceNormalTexture = true

				FocusFrame.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Minus")
			elseif classification == "worldboss" or classification == "elite" then
				if eufCharacterDB.bigFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\BigElite")
				elseif eufCharacterDB.defaultFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\DefaultElite")
				elseif eufCharacterDB.whoaFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\WhoaElite")
				end
			elseif classification == "rareelite" then
				if eufCharacterDB.bigFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\BigRareElite")
				elseif eufCharacterDB.defaultFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\DefaultRareElite")	
				elseif eufCharacterDB.whoaFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\WhoaRareElite")
				end
			elseif classification == "rare" then
				if eufCharacterDB.bigFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\BigRare")
				elseif eufCharacterDB.defaultFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\DefaultRare")	
				elseif eufCharacterDB.whoaFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\WhoaRare")
				end
			else
				forceNormalTexture = true

				if eufCharacterDB.bigFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Big")
				elseif eufCharacterDB.defaultFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Default")					
				elseif eufCharacterDB.whoaFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Whoa")
				end
			end
		else
			if forceNormalTexture then
				if eufDB.bigFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Big")
				elseif eufDB.defaultFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Default")
				elseif eufDB.whoaFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Whoa")
				end
			elseif classification == "minus" then
				forceNormalTexture = true

				FocusFrame.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Minus")
			elseif classification == "worldboss" or classification == "elite" then
				if eufDB.bigFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\BigElite")
				elseif eufDB.defaultFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\DefaultElite")
				elseif eufDB.whoaFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\WhoaElite")
				end
			elseif classification == "rareelite" then
				if eufDB.bigFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\BigRareElite")
				elseif eufDB.defaultFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\DefaultRareElite")
				elseif eufDB.whoaFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\WhoaRareElite")
				end
			elseif classification == "rare" then
				if eufDB.bigFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\BigRare")
				elseif eufDB.defaultFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\DefaultRare")
				elseif eufDB.whoaFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\WhoaRare")
				end
			else
				forceNormalTexture = true

				if eufDB.bigFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Big")
				elseif eufDB.defaultFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Default")
				elseif eufDB.whoaFocusFrame then
					FocusFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Whoa")
				end
			end
		end

		if forceNormalTexture then
			FocusFrame.haveElite = nil

			if classification == "minus" then
				local function MinusStyling()
					FocusFrame.highLevelTexture:SetPoint("CENTER", FocusFrame.manabar, "BOTTOMRIGHT", 52.5, -1.5)
					FocusFrame.manabar:SetHeight(12)
					FocusFrame.manabar:ClearAllPoints()
					FocusFrame.manabar:SetPoint("TOPRIGHT", -107, -52)
				end

				local function MinusWhoaStyling()
					FocusFrame.highLevelTexture:SetPoint("CENTER", FocusFrame.manabar, "BOTTOMRIGHT", 52.5, -2.5)
					FocusFrame.manabar:SetHeight(19)
					FocusFrame.manabar:ClearAllPoints()
					FocusFrame.manabar:SetPoint("TOPRIGHT", -107, -44)
				end

				local function MinusNarrowStyling()
					FocusFrame.Background:SetSize(119, 10)
					FocusFrame.healthbar:SetSize(119, 12)
					FocusFrame.manabar:SetWidth(119)
				end

				local function MinusWideStyling()
					if eufCharacterDB.enabled then
						FocusFrame.Background:SetSize(eufCharacterDB.wideFocusFrameWidth - 113, 10)
						FocusFrame.healthbar:SetSize(eufCharacterDB.wideFocusFrameWidth - 113, 12)
						FocusFrame.manabar:SetWidth(eufCharacterDB.wideFocusFrameWidth - 113)
					else
						FocusFrame.Background:SetSize(eufDB.wideFocusFrameWidth - 113, 10)
						FocusFrame.healthbar:SetSize(eufDB.wideFocusFrameWidth - 113, 12)
						FocusFrame.manabar:SetWidth(eufDB.wideFocusFrameWidth - 113)
					end
				end

				if eufCharacterDB.enabled then
					if eufCharacterDB.bigFocusFrame or eufCharacterDB.defaultFocusFrame then
						MinusStyling()
					elseif eufCharacterDB.whoaFocusFrame then
						MinusWhoaStyling()
					end

					if eufCharacterDB.wideFocusFrame and eufCharacterDB.wideFocusFrameWidth >= 231 then
						MinusWideStyling()
					else
						MinusNarrowStyling()
					end
				else
					if eufDB.bigFocusFrame or eufDB.defaultFocusFrame then
						MinusStyling()
					elseif eufDB.whoaFocusFrame then
						MinusWhoaStyling()
					end

					if eufDB.wideFocusFrame and eufDB.wideFocusFrameWidth >= 231 then
						MinusWideStyling()
					else
						MinusNarrowStyling()
					end
				end

				FocusFrame.Background:ClearAllPoints()
				FocusFrame.Background:SetPoint("TOPRIGHT", -107, -42)
				FocusFrame.deadText:SetAlpha(0)
				FocusFrame.healthbar:ClearAllPoints()
				FocusFrame.healthbar:SetPoint("TOPRIGHT", -107, -41)
				FocusFrame.name:ClearAllPoints()
				FocusFrame.name:SetPoint("TOPLEFT", FocusFrame, "TOPLEFT", 8, -24.5)
				FocusFrame.name:SetPoint("BOTTOMRIGHT", FocusFrame, "TOPRIGHT", -110, -37.5)
				FocusFrameHealthBar.LeftText:SetJustifyH("RIGHT")
				FocusFrameHealthBar.LeftText:SetWidth(40)
				FocusFrameHealthBar.LeftText:ClearAllPoints()
				FocusFrameHealthBar.LeftText:SetPoint("LEFT", FocusFrame.healthbar, -1.5, -0.5)
				FocusFrameHealthBar.RightText:SetJustifyH("RIGHT")
				FocusFrameHealthBar.RightText:SetWidth(75)
				FocusFrameHealthBar.RightText:ClearAllPoints()
				FocusFrameHealthBar.RightText:SetPoint("RIGHT", FocusFrame.healthbar, -3.5, -0.5)
				FocusFrameHealthBar.TextString:ClearAllPoints()
				FocusFrameHealthBar.TextString:SetPoint("CENTER", FocusFrame.healthbar, 0, -0.5)
			else
				FocusStyling()
			end
		else
			FocusFrame.haveElite = true

			FocusStyling()
		end

		if not isClassic() then
			if C_CVar.GetCVar("threatShowNumeric") == "1" then
				if eufCharacterDB.enabled then
					if eufCharacterDB.bigFocusFrame or eufCharacterDB.whoaFocusFrame then
						FocusFrame.threatNumericIndicator:SetAlpha(0)
					end
				else
					if eufDB.bigFocusFrame or eufDB.whoaFocusFrame then
						FocusFrame.threatNumericIndicator:SetAlpha(0)
					end
				end
			end

			FocusFrame.questIcon:ClearAllPoints()
			FocusFrame.questIcon:SetPoint("TOPLEFT", FocusFrame, "TOPRIGHT", -117, -12)
		end
	end)

	-- Disables the buffs on top option.

	hooksecurefunc("FocusFrame_UpdateBuffsOnTop", function()
		FocusFrame.buffsOnTop = false

		TargetFrame_UpdateAuras(FocusFrame)
	end)

	-- Fixes the level text positioning on the focus frame.

	hooksecurefunc("TargetFrame_UpdateLevelTextAnchor", function(self, targetLevel)
		local function FocusOneHundredPlus()
			FocusFrame.levelText:ClearAllPoints()
			FocusFrame.levelText:SetPoint("CENTER", FocusFrame.manabar, "BOTTOMRIGHT", 52.5, -2.5)
		end

		local function FocusBelowOneHundred()
			FocusFrame.levelText:ClearAllPoints()
			FocusFrame.levelText:SetPoint("CENTER", FocusFrame.manabar, "BOTTOMRIGHT", 53.5, -2.5)
		end

		local function FocusWhoaOneHundredPlus()
			FocusFrame.levelText:ClearAllPoints()
			FocusFrame.levelText:SetPoint("CENTER", FocusFrame.manabar, "BOTTOMRIGHT", 52.5, -3.5)
		end

		local function FocusWhoaBelowOneHundred()
			FocusFrame.levelText:ClearAllPoints()
			FocusFrame.levelText:SetPoint("CENTER", FocusFrame.manabar, "BOTTOMRIGHT", 53.5, -3.5)
		end

		local function Focus()
			if UnitLevel("focus") >= 100 then
				FocusOneHundredPlus()
			else
				FocusBelowOneHundred()
			end
		end

		local function FocusWhoa()
			if UnitLevel("focus") >= 100 then
				FocusWhoaOneHundredPlus()
			else
				FocusWhoaBelowOneHundred()
			end
		end

		if eufCharacterDB.enabled then
			if eufCharacterDB.bigFocusFrame or eufCharacterDB.defaultFocusFrame then
				Focus()
			elseif eufCharacterDB.whoaFocusFrame then
				FocusWhoa()
			end
		else
			if eufDB.bigFocusFrame or eufDB.defaultFocusFrame then
				Focus()
			elseif eufDB.whoaFocusFrame then
				FocusWhoa()
			end
		end
	end)

	-- Fixes the focus frame target of target background.

	hooksecurefunc("TargetofTarget_Update", function(self, elapsed)
		FocusFrameToTBackground:ClearAllPoints()
		FocusFrameToTBackground:SetPoint("CENTER", FocusFrameToT, 21, 0)
		FocusFrameToTBackground:SetSize(46, 15)
		FocusFrameToTTextureFrameDeadText:SetAlpha(0)
	end)
end
