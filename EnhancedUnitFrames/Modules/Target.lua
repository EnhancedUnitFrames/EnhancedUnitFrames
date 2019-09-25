function TargetFrameStyling()
	-- Changes the aura icon sizes and automatically changes their row's width based on the width of the target frame.

	local function AuraStyling()
		hooksecurefunc("TargetFrame_UpdateAuraPositions", function(TargetFrame, auraName, numAuras, numOppositeAuras, largeAuraList, updateFunc, maxRowWidth, offsetX, mirrorAurasVertically)
			local AURA_OFFSET_Y = 3
			local AURA_ROW_WIDTH = 90 + (wideTargetFrameWidth - 230)
			local NUM_TOT_AURA_ROWS = 2
			local size
			local offsetY = AURA_OFFSET_Y
			local rowWidth = 0
			local firstBuffOnRow = 1
			local maxRowWidth = 90 + (wideTargetFrameWidth - 230)

			for i = 1, numAuras do
				if largeAuraList[i] then
					size = LARGE_AURA_SIZE
					offsetY = AURA_OFFSET_Y + AURA_OFFSET_Y
				else
					size = SMALL_AURA_SIZE
				end

				if i == 1 then
					rowWidth = size
					TargetFrame.auraRows = TargetFrame.auraRows + 1
				else
					rowWidth = rowWidth + size + offsetX
				end

				if rowWidth > maxRowWidth then
					updateFunc(TargetFrame, auraName, i, numOppositeAuras, firstBuffOnRow, size, offsetX, offsetY, mirrorAurasVertically)

					rowWidth = size
					TargetFrame.auraRows = TargetFrame.auraRows + 1
					firstBuffOnRow = i
					offsetY = AURA_OFFSET_Y

					if TargetFrame.auraRows > NUM_TOT_AURA_ROWS then
						maxRowWidth = AURA_ROW_WIDTH
					end
				else
					updateFunc(TargetFrame, auraName, i, numOppositeAuras, i - 1, size, offsetX, offsetY, mirrorAurasVertically)
				end
			end
		end)
	end

	if eufCharacterDB.enabled then
		LARGE_AURA_SIZE = eufCharacterDB.largeAuraIconSize
		SMALL_AURA_SIZE = eufCharacterDB.smallAuraIconSize

		if eufCharacterDB.wideTargetFrame and eufCharacterDB.wideTargetFrameWidth >= 231 then
			wideTargetFrameWidth = eufCharacterDB.wideTargetFrameWidth
		else
			wideTargetFrameWidth = 230
		end

		AuraStyling()
	else
		LARGE_AURA_SIZE = eufDB.largeAuraIconSize
		SMALL_AURA_SIZE = eufDB.smallAuraIconSize

		if eufDB.wideTargetFrame and eufDB.wideTargetFrameWidth >= 231 then
			wideTargetFrameWidth = eufDB.wideTargetFrameWidth
		else
			wideTargetFrameWidth = 230
		end

		AuraStyling()
	end

	-- Source: UnitFramesImproved by KawF.
	-- Adds status bar text to the target frame.

	if isClassic() then
		function createStatusBarText(name, parentName, parent, point, x, y)
			local fontString = parent:CreateFontString(parentName .. name, nil, "SystemFont_Outline_Small")

			fontString:SetPoint(point, parent, point, x, y)

			return fontString
		end

		TargetFrameHealthBar.LeftText = createStatusBarText("TextLeft", "TargetFrameHealthBar", TargetFrameTextureFrame, "LEFT", 8, 3)
		TargetFrameHealthBar.RightText = createStatusBarText("TextRight", "TargetFrameHealthBar", TargetFrameTextureFrame, "RIGHT", -110, 3)
		TargetFrameHealthBar.TextString = createStatusBarText("Text", "TargetFrameHealthBar", TargetFrameTextureFrame, "CENTER", -50, 40)
		TargetFrameManaBar.LeftText = createStatusBarText("TextLeft", "TargetFrameManaBar", TargetFrameTextureFrame, "LEFT", 8, -8)
		TargetFrameManaBar.RightText = createStatusBarText("TextRight", "TargetFrameManaBar", TargetFrameTextureFrame, "RIGHT", -110, -8)		
		TargetFrameManaBar.TextString = createStatusBarText("Text", "TargetFrameManaBar", TargetFrameTextureFrame, "CENTER", -50, -8)
	end

	-- Source: Wide Target by Gello.
	-- Makes the target frame wider.

	local function WideTarget()
		local cx = 232
		local cy = 100
		local frame = TargetFrame.textureFrame
		local left = frame:CreateTexture(nil, "BACKGROUND")
		local mid = frame:CreateTexture(nil, "BACKGROUND")
		local tex = TargetFrame.borderTexture

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

		if not isClassic() then
			local flash = TargetFrameFlash
			flash.midFlash = TargetFrame:CreateTexture(nil, "BACKGROUND")
			flash.rightFlash = TargetFrame:CreateTexture(nil, "BACKGROUND")

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

				self.rightFlash:SetPoint("TOPRIGHT", TargetFrame, "TOPRIGHT", specificXoff - xoff, yoff)
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
		end

		TargetFrame:SetWidth(targetWidth)
	end

	if eufCharacterDB.enabled then
		targetWidth = eufCharacterDB.wideTargetFrameWidth

		if eufCharacterDB.wideTargetFrame and eufCharacterDB.wideTargetFrameWidth >= 231 then
			WideTarget()
		end
	else
		targetWidth = eufDB.wideTargetFrameWidth

		if eufDB.wideTargetFrame and eufDB.wideTargetFrameWidth >= 231 then
			WideTarget()
		end
	end

	-- Styles the target frame.

	hooksecurefunc("TargetFrame_CheckClassification", function(self, forceNormalTexture)
		local classification = UnitClassification(TargetFrame.unit)

		local function TargetStyling()
			local function BigStyling()
				TargetFrame.healthbar:SetHeight(29)
				TargetFrame.healthbar:ClearAllPoints()
				TargetFrame.healthbar:SetPoint("TOPRIGHT", -107, -23)
				TargetFrame.highLevelTexture:ClearAllPoints()
				TargetFrame.highLevelTexture:SetPoint("CENTER", TargetFrame.manabar, "BOTTOMRIGHT", 52.5, -1.5)
				TargetFrame.manabar:SetHeight(12)
				TargetFrame.manabar:ClearAllPoints()
				TargetFrame.manabar:SetPoint("TOPRIGHT", -107, -52)
				TargetFrame.name:ClearAllPoints()
				TargetFrame.name:SetPoint("TOPLEFT", 8, -7.5)
				TargetFrame.name:SetPoint("BOTTOMRIGHT", TargetFrame, "TOPRIGHT", -110, -19.5)
				TargetFrame.nameBackground:Hide()
				TargetFrame.nameBackground:SetAlpha(0)
			end

			local function DefaultStyling()
				TargetFrame.highLevelTexture:ClearAllPoints()
				TargetFrame.highLevelTexture:SetPoint("CENTER", TargetFrame.manabar, "BOTTOMRIGHT", 52.5, -1.5)
				TargetFrame.healthbar:ClearAllPoints()
				TargetFrame.healthbar:SetPoint("TOPRIGHT", -107, -41)
				TargetFrame.manabar:SetHeight(12)
				TargetFrame.manabar:ClearAllPoints()
				TargetFrame.manabar:SetPoint("TOPRIGHT", -107, -52)
				TargetFrame.name:ClearAllPoints()
				TargetFrame.name:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", 8, -24.5)
				TargetFrame.name:SetPoint("BOTTOMRIGHT", TargetFrame, "TOPRIGHT", -110, -37.5)
				TargetFrame.nameBackground:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", 6, -22)
			end

			local function WhoaStyling()
				TargetFrame.healthbar:SetHeight(20)
				TargetFrame.healthbar:ClearAllPoints()
				TargetFrame.healthbar:SetPoint("TOPRIGHT", -107, -23)
				TargetFrame.highLevelTexture:ClearAllPoints()
				TargetFrame.highLevelTexture:SetPoint("CENTER", TargetFrame.manabar, "BOTTOMRIGHT", 52.5, -2.5)
				TargetFrame.manabar:SetHeight(19)
				TargetFrame.manabar:ClearAllPoints()
				TargetFrame.manabar:SetPoint("TOPRIGHT", -107, -44)
				TargetFrame.name:ClearAllPoints()
				TargetFrame.name:SetPoint("TOPLEFT", 8, -7.5)
				TargetFrame.name:SetPoint("BOTTOMRIGHT", TargetFrame, "TOPRIGHT", -110, -19.5)
				TargetFrame.nameBackground:Hide()
				TargetFrame.nameBackground:SetAlpha(0)
			end

			local function WideStyling()
				if eufCharacterDB.enabled then
					TargetFrameBackground:SetSize(eufCharacterDB.wideTargetFrameWidth - 113, 40)
					TargetFrame.Background:SetSize(eufCharacterDB.wideTargetFrameWidth - 113, 40)
					TargetFrame.healthbar:SetWidth(eufCharacterDB.wideTargetFrameWidth - 113)
					TargetFrame.manabar:SetWidth(eufCharacterDB.wideTargetFrameWidth - 113)
				else
					TargetFrameBackground:SetSize(eufDB.wideTargetFrameWidth - 113, 40)
					TargetFrame.Background:SetSize(eufDB.wideTargetFrameWidth - 113, 40)
					TargetFrame.healthbar:SetWidth(eufDB.wideTargetFrameWidth - 113)
					TargetFrame.manabar:SetWidth(eufDB.wideTargetFrameWidth - 113)
				end
			end

			local function NarrowStyling()
				TargetFrameBackground:SetSize(119, 40)
				TargetFrame.Background:SetSize(119, 40)
				TargetFrame.healthbar:SetWidth(119)
				TargetFrame.manabar:SetWidth(119)
			end

			if eufCharacterDB.enabled then
				if eufCharacterDB.bigTargetFrame then
					BigStyling()
				elseif eufCharacterDB.defaultTargetFrame then
					DefaultStyling()
				elseif eufCharacterDB.whoaTargetFrame then
					WhoaStyling()
				end

				if eufCharacterDB.wideTargetFrame and eufCharacterDB.wideTargetFrameWidth >= 231 then
					WideStyling()
				else
					NarrowStyling()
				end
			else
				if eufDB.bigTargetFrame then
					BigStyling()
				elseif eufDB.defaultTargetFrame then
					DefaultStyling()
				elseif eufDB.whoaTargetFrame then
					WhoaStyling()
				end

				if eufDB.wideTargetFrame and eufDB.wideTargetFrameWidth >= 231 then
					WideStyling()
				else
					NarrowStyling()
				end
			end

			TargetFrame.Background:ClearAllPoints()
			TargetFrame.Background:SetPoint("TOPRIGHT", -107, -23)
			TargetFrame.deadText:SetAlpha(0)
			TargetFrameHealthBar.LeftText:SetJustifyH("RIGHT")
			TargetFrameHealthBar.LeftText:SetWidth(40)
			TargetFrameHealthBar.LeftText:ClearAllPoints()
			TargetFrameHealthBar.LeftText:SetPoint("LEFT", TargetFrame.healthbar, -1.5, -0.5)
			TargetFrameHealthBar.RightText:SetJustifyH("RIGHT")
			TargetFrameHealthBar.RightText:SetWidth(75)
			TargetFrameHealthBar.RightText:ClearAllPoints()
			TargetFrameHealthBar.RightText:SetPoint("RIGHT", TargetFrame.healthbar, -3.5, -0.5)
			TargetFrameHealthBar.TextString:ClearAllPoints()
			TargetFrameHealthBar.TextString:SetPoint("CENTER", TargetFrame.healthbar, 0, -0.5)
			TargetFrameManaBar.LeftText:SetJustifyH("RIGHT")
			TargetFrameManaBar.LeftText:SetWidth(40)
			TargetFrameManaBar.LeftText:ClearAllPoints()
			TargetFrameManaBar.LeftText:SetPoint("LEFT", TargetFrame.manabar, -1.5, 0)
			TargetFrameManaBar.RightText:SetJustifyH("RIGHT")
			TargetFrameManaBar.RightText:SetWidth(75)
			TargetFrameManaBar.RightText:ClearAllPoints()
			TargetFrameManaBar.RightText:SetPoint("RIGHT", TargetFrame.manabar, -3.5, 0)
			TargetFrameManaBar.TextString:ClearAllPoints()
			TargetFrameManaBar.TextString:SetPoint("CENTER", TargetFrame.manabar, 0, 0)
		end

		if eufCharacterDB.enabled then
			if forceNormalTexture then
				if eufCharacterDB.bigTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Big")
				elseif eufCharacterDB.defaultTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Default")					
				elseif eufCharacterDB.whoaTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Whoa")
				end
			elseif classification == "minus" then
				forceNormalTexture = true

				TargetFrame.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Minus")
			elseif classification == "worldboss" or classification == "elite" then
				if eufCharacterDB.bigTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\BigElite")
				elseif eufCharacterDB.defaultTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\DefaultElite")
				elseif eufCharacterDB.whoaTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\WhoaElite")
				end
			elseif classification == "rareelite" then
				if eufCharacterDB.bigTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\BigRareElite")
				elseif eufCharacterDB.defaultTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\DefaultRareElite")	
				elseif eufCharacterDB.whoaTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\WhoaRareElite")
				end
			elseif classification == "rare" then
				if eufCharacterDB.bigTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\BigRare")
				elseif eufCharacterDB.defaultTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\DefaultRare")	
				elseif eufCharacterDB.whoaTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\WhoaRare")
				end
			else
				forceNormalTexture = true

				if eufCharacterDB.bigTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Big")
				elseif eufCharacterDB.defaultTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Default")					
				elseif eufCharacterDB.whoaTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Whoa")
				end
			end
		else
			if forceNormalTexture then
				if eufDB.bigTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Big")
				elseif eufDB.defaultTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Default")
				elseif eufDB.whoaTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Whoa")
				end
			elseif classification == "minus" then
				forceNormalTexture = true

				TargetFrame.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Minus")
			elseif classification == "worldboss" or classification == "elite" then
				if eufDB.bigTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\BigElite")
				elseif eufDB.defaultTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\DefaultElite")
				elseif eufDB.whoaTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\WhoaElite")
				end
			elseif classification == "rareelite" then
				if eufDB.bigTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\BigRareElite")
				elseif eufDB.defaultTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\DefaultRareElite")
				elseif eufDB.whoaTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\WhoaRareElite")
				end
			elseif classification == "rare" then
				if eufDB.bigTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\BigRare")
				elseif eufDB.defaultTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\DefaultRare")
				elseif eufDB.whoaTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\WhoaRare")
				end
			else
				forceNormalTexture = true

				if eufDB.bigTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Big")
				elseif eufDB.defaultTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Default")
				elseif eufDB.whoaTargetFrame then
					TargetFrame.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Whoa")
				end
			end
		end

		if forceNormalTexture then
			TargetFrame.haveElite = nil

			if classification == "minus" then
				local function MinusStyling()
					TargetFrame.highLevelTexture:SetPoint("CENTER", TargetFrame.manabar, "BOTTOMRIGHT", 52.5, -1.5)
					TargetFrame.manabar:SetHeight(12)
					TargetFrame.manabar:ClearAllPoints()
					TargetFrame.manabar:SetPoint("TOPRIGHT", -107, -52)
				end

				local function MinusWhoaStyling()
					TargetFrame.highLevelTexture:SetPoint("CENTER", TargetFrame.manabar, "BOTTOMRIGHT", 52.5, -2.5)
					TargetFrame.manabar:SetHeight(19)
					TargetFrame.manabar:ClearAllPoints()
					TargetFrame.manabar:SetPoint("TOPRIGHT", -107, -44)
				end

				local function MinusNarrowStyling()
					TargetFrame.Background:SetSize(119, 10)
					TargetFrame.healthbar:SetSize(119, 12)
					TargetFrame.manabar:SetWidth(119)
				end

				local function MinusWideStyling()
					if eufCharacterDB.enabled then
						TargetFrame.Background:SetSize(eufCharacterDB.wideTargetFrameWidth - 113, 10)
						TargetFrame.healthbar:SetSize(eufCharacterDB.wideTargetFrameWidth - 113, 12)
						TargetFrame.manabar:SetWidth(eufCharacterDB.wideTargetFrameWidth - 113)
					else
						TargetFrame.Background:SetSize(eufDB.wideTargetFrameWidth - 113, 10)
						TargetFrame.healthbar:SetSize(eufDB.wideTargetFrameWidth - 113, 12)
						TargetFrame.manabar:SetWidth(eufDB.wideTargetFrameWidth - 113)
					end
				end

				if eufCharacterDB.enabled then
					if eufCharacterDB.bigTargetFrame or eufCharacterDB.defaultTargetFrame then
						MinusStyling()
					elseif eufCharacterDB.whoaTargetFrame then
						MinusWhoaStyling()
					end

					if eufCharacterDB.wideTargetFrame and eufCharacterDB.wideTargetFrameWidth >= 231 then
						MinusWideStyling()
					else
						MinusNarrowStyling()
					end
				else
					if eufDB.bigTargetFrame or eufDB.defaultTargetFrame then
						MinusStyling()
					elseif eufDB.whoaTargetFrame then
						MinusWhoaStyling()
					end

					if eufDB.wideTargetFrame and eufDB.wideTargetFrameWidth >= 231 then
						MinusWideStyling()
					else
						MinusNarrowStyling()
					end
				end

				TargetFrame.Background:ClearAllPoints()
				TargetFrame.Background:SetPoint("TOPRIGHT", -107, -42)
				TargetFrame.deadText:SetAlpha(0)
				TargetFrame.healthbar:ClearAllPoints()
				TargetFrame.healthbar:SetPoint("TOPRIGHT", -107, -41)
				TargetFrame.name:ClearAllPoints()
				TargetFrame.name:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", 8, -24.5)
				TargetFrame.name:SetPoint("BOTTOMRIGHT", TargetFrame, "TOPRIGHT", -110, -37.5)
				TargetFrameHealthBar.LeftText:SetJustifyH("RIGHT")
				TargetFrameHealthBar.LeftText:SetWidth(40)
				TargetFrameHealthBar.LeftText:ClearAllPoints()
				TargetFrameHealthBar.LeftText:SetPoint("LEFT", TargetFrame.healthbar, -1.5, -0.5)
				TargetFrameHealthBar.RightText:SetJustifyH("RIGHT")
				TargetFrameHealthBar.RightText:SetWidth(75)
				TargetFrameHealthBar.RightText:ClearAllPoints()
				TargetFrameHealthBar.RightText:SetPoint("RIGHT", TargetFrame.healthbar, -3.5, -0.5)
				TargetFrameHealthBar.TextString:ClearAllPoints()
				TargetFrameHealthBar.TextString:SetPoint("CENTER", TargetFrame.healthbar, 0, -0.5)
			else
				TargetStyling()
			end
		else
			TargetFrame.haveElite = true

			TargetStyling()
		end

		if not isClassic() then
			if C_CVar.GetCVar("threatShowNumeric") == "1" then
				if eufCharacterDB.enabled then
					if eufCharacterDB.bigTargetFrame or eufCharacterDB.whoaTargetFrame then
						TargetFrame.threatNumericIndicator:SetPoint("BOTTOM", PlayerFrame, "TOP", 72, -21)
					end
				else
					if eufDB.bigTargetFrame or eufDB.whoaTargetFrame then
						TargetFrame.threatNumericIndicator:SetPoint("BOTTOM", PlayerFrame, "TOP", 72, -21)
					end
				end
			end

			TargetFrame.questIcon:ClearAllPoints()
			TargetFrame.questIcon:SetPoint("TOPLEFT", TargetFrame, "TOPRIGHT", -117, -12)
		end
	end)

	-- Disables the buffs on top option.

	hooksecurefunc("TargetFrame_UpdateBuffsOnTop", function()
		TargetFrame.buffsOnTop = false

		TargetFrame_UpdateAuras(TargetFrame)
	end)

	-- Fixes the level text positioning on the target frame.

	hooksecurefunc("TargetFrame_UpdateLevelTextAnchor", function(self, targetLevel)
		local function TargetOneHundredPlus()
			TargetFrame.levelText:ClearAllPoints()
			TargetFrame.levelText:SetPoint("CENTER", TargetFrame.manabar, "BOTTOMRIGHT", 52.5, -2.5)
		end

		local function TargetBelowOneHundred()
			TargetFrame.levelText:ClearAllPoints()
			TargetFrame.levelText:SetPoint("CENTER", TargetFrame.manabar, "BOTTOMRIGHT", 53.5, -2.5)
		end

		local function TargetWhoaOneHundredPlus()
			TargetFrame.levelText:ClearAllPoints()
			TargetFrame.levelText:SetPoint("CENTER", TargetFrame.manabar, "BOTTOMRIGHT", 52.5, -3.5)
		end

		local function TargetWhoaBelowOneHundred()
			TargetFrame.levelText:ClearAllPoints()
			TargetFrame.levelText:SetPoint("CENTER", TargetFrame.manabar, "BOTTOMRIGHT", 53.5, -3.5)
		end

		local function Target()
			if UnitLevel("target") >= 100 then
				TargetOneHundredPlus()
			else
				TargetBelowOneHundred()
			end
		end

		local function TargetWhoa()
			if UnitLevel("target") >= 100 then
				TargetWhoaOneHundredPlus()
			else
				TargetWhoaBelowOneHundred()
			end
		end

		if eufCharacterDB.enabled then
			if eufCharacterDB.bigTargetFrame or eufCharacterDB.defaultTargetFrame then
				Target()
			elseif eufCharacterDB.whoaTargetFrame then
				TargetWhoa()
			end
		else
			if eufDB.bigTargetFrame or eufDB.defaultTargetFrame then
				Target()
			elseif eufDB.whoaTargetFrame then
				TargetWhoa()
			end
		end
	end)

	-- Fixes the target frame target of target background.

	hooksecurefunc("TargetofTarget_Update", function(self, elapsed)
		TargetFrameToTBackground:ClearAllPoints()
		TargetFrameToTBackground:SetPoint("CENTER", TargetFrameToT, 21, 0)
		TargetFrameToTBackground:SetSize(46, 15)
		TargetFrameToTTextureFrameDeadText:SetAlpha(0)
	end)
end
