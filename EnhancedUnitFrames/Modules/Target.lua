function TargetFrameStyling()
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
	-- Makes the target and focus frame wider.

	local function WideFocus()
		local frame = FocusFrame.textureFrame
		local tex = FocusFrame.borderTexture
		local cx = 232
		local cy = 100

		tex:ClearAllPoints()
		tex:SetPoint("TOPRIGHT", frame)
		tex:SetSize(cx / 2, cy)
		tex:SetTexCoord(0.546875, 1, 0, 0.78125)

		local left = frame:CreateTexture(nil, "BACKGROUND")

		left:SetSize(cx / 4, cy)
		left:SetPoint("TOPLEFT")
		left:SetTexCoord(0.09375, 0.3203125, 0, 0.78125)

		local mid = frame:CreateTexture(nil, "BACKGROUND")

		mid:SetPoint("TOPLEFT", left, "TOPRIGHT")
		mid:SetPoint("BOTTOMRIGHT", tex, "BOTTOMLEFT")
		mid:SetTexCoord(0.3203125, 0.546875, 0, 0.78125)

		hooksecurefunc(tex, "SetTexture", function(self, texture)
			left:SetTexture(texture)
			mid:SetTexture(texture)
		end)

		hooksecurefunc(tex, "SetVertexColor", function(self, ...)
			left:SetVertexColor(...)
			mid:SetVertexColor(...)
		end)

		hooksecurefunc(tex, "SetGradientAlpha", function(self, ...)
			left:SetGradientAlpha(...)
			mid:SetGradientAlpha(...)
		end)

		local r, g, b, a = tex:GetVertexColor()

		left:SetVertexColor(r, g, b, a)
		mid:SetVertexColor(r, g, b, a)

		local flash = FocusFrameFlash

		flash.rightFlash = FocusFrame:CreateTexture(nil, "BACKGROUND")
		flash.midFlash = FocusFrame:CreateTexture(nil, "BACKGROUND")

		hooksecurefunc(flash, "SetTexture", function(self, texture)
			flash.rightFlash:SetTexture(texture)
			flash.midFlash:SetTexture(texture)
		end)

		hooksecurefunc(flash, "SetPoint", function(self, anchorPoint, relativeTo, relativePoint, xoff, yoff)
			local cx = self:GetWidth()
			local cy = self:GetHeight()
			local specificXoff

			self:SetWidth(cx / 2)
			self.rightFlash:SetWidth(cx / 2)
			self.rightFlash:SetHeight(cy)
			self.midFlash:SetHeight(cy)

			if cy < 100 then
				self:SetTexCoord(0, 0.47265625, 0, 0.181640625)
				self.rightFlash:SetTexCoord(0.47265625, 0.9453125, 0, 0.181640625)
				self.midFlash:SetTexCoord(0.25, 0.5, 0, 0.181640625)

				specificXoff = -38
			elseif cx > 255 then
				self:SetTexCoord(0, .5, 0, 1)
				self.rightFlash:SetTexCoord(.5, 1, 0, 1)
				self.midFlash:SetTexCoord(0.25, 0.5, 0, 1)

				specificXoff = -24
			elseif cy > 100 then
				self:SetTexCoord(0, 0.47265625, 0.181640625, 0.400390625)
				self.rightFlash:SetTexCoord(0.47265625, 0.9453125, 0.181640625, 0.400390625)
				self.midFlash:SetTexCoord(0.19, 0.39, 0.181640625, 0.400390625)

				specificXoff = -34
			end

			self.rightFlash:SetPoint("TOPRIGHT", FocusFrame, "TOPRIGHT", specificXoff - xoff, yoff)
			self.midFlash:SetPoint("TOPLEFT", self,	"TOPRIGHT")
			self.midFlash:SetPoint("BOTTOMRIGHT", self.rightFlash, "BOTTOMLEFT")
		end)

		hooksecurefunc(flash, "Show", function(self)
			self.rightFlash:Show()
			self.midFlash:Show()
		end)

		hooksecurefunc(flash, "Hide", function(self)
			self.rightFlash:Hide()
			self.midFlash:Hide()
		end)

		hooksecurefunc(flash, "SetVertexColor", function(self, ...)
			self.rightFlash:SetVertexColor(...)
			self.midFlash:SetVertexColor(...)
		end)

		FocusFrame:SetWidth(focusWidth)
	end

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
		focusWidth = eufCharacterDB.wideTargetFrameWidth
		targetWidth = eufCharacterDB.wideTargetFrameWidth

		if eufCharacterDB.wideTargetFrame and eufCharacterDB.wideTargetFrameWidth >= 231 then
			if not isClassic() then
				WideFocus()
			end

			WideTarget()
		end
	else
		focusWidth = eufDB.wideTargetFrameWidth
		targetWidth = eufDB.wideTargetFrameWidth

		if eufDB.wideTargetFrame and eufDB.wideTargetFrameWidth >= 231 then
			if not isClassic() then
				WideFocus()
			end

			WideTarget()
		end
	end

	-- Styles the focus and target frames.

	hooksecurefunc("TargetFrame_CheckClassification", function(self, forceNormalTexture)
		local classification = UnitClassification(self.unit)

		local function Styling()
			local function BigStyling()
				self.healthbar:SetHeight(29)
				self.highLevelTexture:ClearAllPoints()
				self.highLevelTexture:SetPoint("CENTER", self.manabar, "BOTTOMRIGHT", 52.5, -1.5)
				self.manabar:SetHeight(12)
				self.manabar:ClearAllPoints()
				self.manabar:SetPoint("TOPRIGHT", -107, -52)
			end

			local function WhoaStyling()
				self.healthbar:SetHeight(20)
				self.highLevelTexture:ClearAllPoints()
				self.highLevelTexture:SetPoint("CENTER", self.manabar, "BOTTOMRIGHT", 52.5, -2.5)
				self.manabar:SetHeight(19)
				self.manabar:ClearAllPoints()
				self.manabar:SetPoint("TOPRIGHT", -107, -44)
			end

			local function WideStyling()
				if eufCharacterDB.enabled then
					TargetFrameBackground:SetSize(eufCharacterDB.wideTargetFrameWidth - 113, 40)
					self.Background:SetSize(eufCharacterDB.wideTargetFrameWidth - 113, 40)
					self.healthbar:SetWidth(eufCharacterDB.wideTargetFrameWidth - 113)
					self.manabar:SetWidth(eufCharacterDB.wideTargetFrameWidth - 113)
				else
					TargetFrameBackground:SetSize(eufDB.wideTargetFrameWidth - 113, 40)
					self.Background:SetSize(eufDB.wideTargetFrameWidth - 113, 40)
					self.healthbar:SetWidth(eufDB.wideTargetFrameWidth - 113)
					self.manabar:SetWidth(eufDB.wideTargetFrameWidth - 113)
				end
			end

			local function DefaultStyling()
				TargetFrameBackground:SetSize(119, 40)
				self.Background:SetSize(119, 40)
				self.healthbar:SetWidth(119)
				self.manabar:SetWidth(119)
			end

			if eufCharacterDB.enabled then
				if eufCharacterDB.bigTargetHealthBar then
					BigStyling()
				else
					WhoaStyling()
				end

				if eufCharacterDB.wideTargetFrame and eufCharacterDB.wideTargetFrameWidth >= 231 then
					WideStyling()
				else
					DefaultStyling()
				end
			else
				if eufDB.bigTargetHealthBar then
					BigStyling()
				else
					WhoaStyling()
				end

				if eufDB.wideTargetFrame and eufDB.wideTargetFrameWidth >= 231 then
					WideStyling()
				else
					DefaultStyling()
				end
			end

			if isClassic() then
				TargetFrameHealthBar.LeftText:SetJustifyH("RIGHT")
				TargetFrameHealthBar.LeftText:SetWidth(40)
				TargetFrameHealthBar.LeftText:ClearAllPoints()
				TargetFrameHealthBar.LeftText:SetPoint("LEFT", self.healthbar, -1.5, -0.5)
				TargetFrameHealthBar.RightText:SetJustifyH("RIGHT")
				TargetFrameHealthBar.RightText:SetWidth(75)
				TargetFrameHealthBar.RightText:ClearAllPoints()
				TargetFrameHealthBar.RightText:SetPoint("RIGHT", self.healthbar, -3.5, -0.5)
				TargetFrameHealthBarText:ClearAllPoints()
				TargetFrameHealthBarText:SetPoint("CENTER", self.healthbar, 0, -0.5)
				TargetFrameManaBar.LeftText:SetJustifyH("RIGHT")
				TargetFrameManaBar.LeftText:SetWidth(40)
				TargetFrameManaBar.LeftText:ClearAllPoints()
				TargetFrameManaBar.LeftText:SetPoint("LEFT", self.manabar, -1.5, 0)
				TargetFrameManaBar.RightText:SetJustifyH("RIGHT")
				TargetFrameManaBar.RightText:SetWidth(75)
				TargetFrameManaBar.RightText:ClearAllPoints()
				TargetFrameManaBar.RightText:SetPoint("RIGHT", self.manabar, -3.5, 0)
				TargetFrameManaBarText:ClearAllPoints()
				TargetFrameManaBarText:SetPoint("CENTER", self.manabar, 0, 0)
			else
				self.healthbar.LeftText:SetJustifyH("RIGHT")
				self.healthbar.LeftText:SetWidth(40)
				self.healthbar.LeftText:ClearAllPoints()
				self.healthbar.LeftText:SetPoint("LEFT", self.healthbar, -1.5, -0.5)
				self.healthbar.RightText:SetJustifyH("RIGHT")
				self.healthbar.RightText:SetWidth(75)
				self.healthbar.RightText:ClearAllPoints()
				self.healthbar.RightText:SetPoint("RIGHT", self.healthbar, -3.5, -0.5)
				self.healthbar.TextString:ClearAllPoints()
				self.healthbar.TextString:SetPoint("CENTER", self.healthbar, 0, -0.5)
				self.manabar.LeftText:SetJustifyH("RIGHT")
				self.manabar.LeftText:SetWidth(40)
				self.manabar.LeftText:ClearAllPoints()
				self.manabar.LeftText:SetPoint("LEFT", self.manabar, -1.5, 0)
				self.manabar.RightText:SetJustifyH("RIGHT")
				self.manabar.RightText:SetWidth(75)
				self.manabar.RightText:ClearAllPoints()
				self.manabar.RightText:SetPoint("RIGHT", self.manabar, -3.5, 0)
				self.manabar.TextString:ClearAllPoints()
				self.manabar.TextString:SetPoint("CENTER", self.manabar, 0, 0)
			end

			self.Background:ClearAllPoints()
			self.Background:SetPoint("TOPRIGHT", -107, -23)
			self.healthbar:ClearAllPoints()
			self.healthbar:SetPoint("TOPRIGHT", -107, -23)
			self.nameBackground:Hide()
			self.nameBackground:SetAlpha(0)
			self.deadText:SetAlpha(0)
			self.name:ClearAllPoints()
			self.name:SetPoint("TOPLEFT", 8, -7.5)
			self.name:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", -110, -19.5)
		end

		if eufCharacterDB.enabled then
			if forceNormalTexture then
				if eufCharacterDB.bigTargetHealthBar then
					self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrame")
				else
					self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameWhoa")
				end
			elseif classification == "minus" then
				forceNormalTexture = true

				self.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Minus")
			elseif classification == "worldboss" or classification == "elite" then
				if eufCharacterDB.bigTargetHealthBar then
					self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameElite")
				else
					self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameEliteWhoa")
				end
			elseif classification == "rareelite" then
				if eufCharacterDB.bigTargetHealthBar then
					self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRareElite")
				else
					self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRareEliteWhoa")
				end
			elseif classification == "rare" then
				if eufCharacterDB.bigTargetHealthBar then
					self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRare")
				else
					self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRareWhoa")
				end
			else
				forceNormalTexture = true

				if eufCharacterDB.bigTargetHealthBar then
					self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrame")
				else
					self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameWhoa")
				end
			end
		else
			if forceNormalTexture then
				if eufDB.bigTargetHealthBar then
					self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrame")
				else
					self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameWhoa")
				end
			elseif classification == "minus" then
				forceNormalTexture = true

				self.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Minus")
			elseif classification == "worldboss" or classification == "elite" then
				if eufDB.bigTargetHealthBar then
					self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameElite")
				else
					self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameEliteWhoa")
				end
			elseif classification == "rareelite" then
				if eufDB.bigTargetHealthBar then
					self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRareElite")
				else
					self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRareEliteWhoa")
				end
			elseif classification == "rare" then
				if eufDB.bigTargetHealthBar then
					self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRare")
				else
					self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRareWhoa")
				end
			else
				forceNormalTexture = true

				if eufDB.bigTargetHealthBar then
					self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrame")
				else
					self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameWhoa")
				end
			end
		end

		if forceNormalTexture then
			self.haveElite = nil

			if classification == "minus" then
				local function MinusBigStyling()
					self.highLevelTexture:SetPoint("CENTER", self.manabar, "BOTTOMRIGHT", 52.5, -1.5)
					self.manabar:SetHeight(12)
					self.manabar:ClearAllPoints()
					self.manabar:SetPoint("TOPRIGHT", -107, -52)
				end

				local function MinusWhoaStyling()
					self.highLevelTexture:SetPoint("CENTER", self.manabar, "BOTTOMRIGHT", 52.5, -2.5)
					self.manabar:SetHeight(19)
					self.manabar:ClearAllPoints()
					self.manabar:SetPoint("TOPRIGHT", -107, -44)
				end

				local function MinusWideStyling()
					if eufCharacterDB.enabled then
						self.Background:SetSize(eufCharacterDB.wideTargetFrameWidth - 113, 10)
						self.healthbar:SetSize(eufCharacterDB.wideTargetFrameWidth - 113, 12)
						self.manabar:SetWidth(eufCharacterDB.wideTargetFrameWidth - 113)
					else
						self.Background:SetSize(eufDB.wideTargetFrameWidth - 113, 10)
						self.healthbar:SetSize(eufDB.wideTargetFrameWidth - 113, 12)
						self.manabar:SetWidth(eufDB.wideTargetFrameWidth - 113)
					end
				end

				local function MinusDefaultStyling()
					self.Background:SetSize(119, 10)
					self.healthbar:SetSize(119, 12)
					self.manabar:SetWidth(119)
				end

				if eufCharacterDB.enabled then
					if eufCharacterDB.bigTargetHealthBar then
						MinusBigStyling()
					else
						MinusWhoaStyling()
					end

					if eufCharacterDB.wideTargetFrame and eufCharacterDB.wideTargetFrameWidth >= 231 then
						MinusWideStyling()
					else
						MinusDefaultStyling()
					end
				else
					if eufDB.bigTargetHealthBar then
						MinusBigStyling()
					else
						MinusWhoaStyling()
					end

					if eufDB.wideTargetFrame and eufDB.wideTargetFrameWidth >= 231 then
						MinusWideStyling()
					else
						MinusDefaultStyling()
					end
				end

				if isClassic() then
					TargetFrameHealthBar.LeftText:SetJustifyH("RIGHT")
					TargetFrameHealthBar.LeftText:SetWidth(40)
					TargetFrameHealthBar.LeftText:ClearAllPoints()
					TargetFrameHealthBar.LeftText:SetPoint("LEFT", self.healthbar, -1.5, -0.5)
					TargetFrameHealthBar.RightText:SetJustifyH("RIGHT")
					TargetFrameHealthBar.RightText:SetWidth(75)
					TargetFrameHealthBar.RightText:ClearAllPoints()
					TargetFrameHealthBar.RightText:SetPoint("RIGHT", self.healthbar, -3.5, -0.5)
					TargetFrameHealthBarText:ClearAllPoints()
					TargetFrameHealthBarText:SetPoint("CENTER", self.healthbar, 0, -0.5)
				else
					self.healthbar.LeftText:SetJustifyH("RIGHT")
					self.healthbar.LeftText:SetWidth(40)
					self.healthbar.LeftText:ClearAllPoints()
					self.healthbar.LeftText:SetPoint("LEFT", self.healthbar, -1.5, -0.5)
					self.healthbar.RightText:SetJustifyH("RIGHT")
					self.healthbar.RightText:SetWidth(75)
					self.healthbar.RightText:ClearAllPoints()
					self.healthbar.RightText:SetPoint("RIGHT", self.healthbar, -3.5, -0.5)
					self.healthbar.TextString:ClearAllPoints()
					self.healthbar.TextString:SetPoint("CENTER", self.healthbar, 0, -0.5)
				end

				self.Background:ClearAllPoints()
				self.Background:SetPoint("TOPRIGHT", -107, -42)
				self.deadText:SetAlpha(0)
				self.healthbar:ClearAllPoints()
				self.healthbar:SetPoint("TOPRIGHT", -107, -41)
				self.name:ClearAllPoints()
				self.name:SetPoint("TOPLEFT", self, "TOPLEFT", 8, -24.5)
				self.name:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", -110, -37.5)
			else
				Styling()
			end
		else
			self.haveElite = true

			Styling()
		end

		if not isClassic() then
			if C_CVar.GetCVar("threatShowNumeric") == "1" then
				FocusFrame.threatNumericIndicator:SetAlpha(0)
				TargetFrame.threatNumericIndicator:SetPoint("BOTTOM", PlayerFrame, "TOP", 72, -21)
			end

			self.questIcon:ClearAllPoints()
			self.questIcon:SetPoint("TOPLEFT", self, "TOPRIGHT", -117, -12)
		end
	end)

	-- Disables the buffs on top option.

	if not isClassic() then
		hooksecurefunc("FocusFrame_UpdateBuffsOnTop", function()
			FocusFrame.buffsOnTop = false

			TargetFrame_UpdateAuras(FocusFrame)
		end)
	end

	hooksecurefunc("TargetFrame_UpdateBuffsOnTop", function()
		TargetFrame.buffsOnTop = false

		TargetFrame_UpdateAuras(TargetFrame)
	end)

	-- Fixes the level text positioning on the focus and target frames.

	hooksecurefunc("TargetFrame_UpdateLevelTextAnchor", function(self, targetLevel)
		local function FocusBigOneHundredPlus()
			FocusFrameTextureFrameLevelText:ClearAllPoints()
			FocusFrameTextureFrameLevelText:SetPoint("CENTER", FocusFrameManaBar, "BOTTOMRIGHT", 52.5, -2.5)
		end

		local function FocusBigBelowOneHundred()
			FocusFrameTextureFrameLevelText:ClearAllPoints()
			FocusFrameTextureFrameLevelText:SetPoint("CENTER", FocusFrameManaBar, "BOTTOMRIGHT", 53.5, -2.5)
		end

		local function FocusWhoaOneHundredPlus()
			FocusFrameTextureFrameLevelText:ClearAllPoints()
			FocusFrameTextureFrameLevelText:SetPoint("CENTER", FocusFrameManaBar, "BOTTOMRIGHT", 52.5, -3.5)
		end

		local function FocusWhoaBelowOneHundred()
			FocusFrameTextureFrameLevelText:ClearAllPoints()
			FocusFrameTextureFrameLevelText:SetPoint("CENTER", FocusFrameManaBar, "BOTTOMRIGHT", 53.5, -3.5)
		end

		local function TargetBigOneHundredPlus()
			TargetFrameTextureFrameLevelText:ClearAllPoints()
			TargetFrameTextureFrameLevelText:SetPoint("CENTER", TargetFrameManaBar, "BOTTOMRIGHT", 52.5, -2.5)
		end

		local function TargetBigBelowOneHundred()
			TargetFrameTextureFrameLevelText:ClearAllPoints()
			TargetFrameTextureFrameLevelText:SetPoint("CENTER", TargetFrameManaBar, "BOTTOMRIGHT", 53.5, -2.5)
		end

		local function TargetWhoaOneHundredPlus()
			TargetFrameTextureFrameLevelText:ClearAllPoints()
			TargetFrameTextureFrameLevelText:SetPoint("CENTER", TargetFrameManaBar, "BOTTOMRIGHT", 52.5, -3.5)
		end

		local function TargetWhoaBelowOneHundred()
			TargetFrameTextureFrameLevelText:ClearAllPoints()
			TargetFrameTextureFrameLevelText:SetPoint("CENTER", TargetFrameManaBar, "BOTTOMRIGHT", 53.5, -3.5)
		end

		local function FocusBig()
			if UnitLevel("focus") >= 100 then
				FocusBigOneHundredPlus()
			else
				FocusBigBelowOneHundred()
			end
		end

		local function FocusWhoa()
			if UnitLevel("focus") >= 100 then
				FocusWhoaOneHundredPlus()
			else
				FocusWhoaBelowOneHundred()
			end
		end

		local function TargetBig()
			if UnitLevel("target") >= 100 then
				TargetBigOneHundredPlus()
			else
				TargetBigBelowOneHundred()
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
			if eufCharacterDB.bigTargetHealthBar then
				if not isClassic() then
					FocusBig()
				end

				TargetBig()
			else
				if not isClassic() then
					FocusWhoa()
				end

				TargetWhoa()
			end
		else
			if eufDB.bigTargetHealthBar then
				if not isClassic() then
					FocusBig()
				end

				TargetBig()
			else
				if not isClassic() then
					FocusWhoa()
				end

				TargetWhoa()
			end
		end
	end)

	-- Fixes the target of target background.

	hooksecurefunc("TargetofTarget_Update", function(self, elapsed)
		TargetFrameToTBackground:ClearAllPoints()
		TargetFrameToTBackground:SetPoint("CENTER", TargetFrameToT, 22, -1)
		TargetFrameToTBackground:SetSize(46, 14)
	end)
end
