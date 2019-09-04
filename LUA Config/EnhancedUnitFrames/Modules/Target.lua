local _, cfg = ...

-- Source: Wide Target by Gello.
-- Makes the target frame wider.

if cfg.wideTargetFrames and cfg.wideTargetFramesWidth >= 231 then
	local cx = 232
	local cy = 100
	local frame = TargetFrame.textureFrame
	local left = frame:CreateTexture(nil, "BACKGROUND")
	local mid = frame:CreateTexture(nil, "BACKGROUND")
	local targetWidth = cfg.wideTargetFramesWidth
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

	TargetFrame:SetWidth(targetWidth)
end

-- Styles the focus and target frames.

hooksecurefunc("TargetFrame_CheckClassification", function(self, forceNormalTexture)
	local classification = UnitClassification(self.unit)

	if classification == "minus" then
		if cfg.bigTargetHealthBars then
			self.manabar:SetHeight(12)
			self.manabar:ClearAllPoints()
			self.manabar:SetPoint("TOPLEFT", self, 7, -52)
		else
			self.manabar:SetHeight(17)
			self.manabar:ClearAllPoints()
			self.manabar:SetPoint("TOPLEFT", self, 7, -45)
		end

		if cfg.wideTargetFrames and cfg.wideTargetFramesWidth >= 231 then
			self.Background:SetSize(cfg.wideTargetFramesWidth - 115, 8)
			self.healthbar:SetSize(cfg.wideTargetFramesWidth - 115, 12)
			self.manabar:SetWidth(cfg.wideTargetFramesWidth - 115)
		else
			self.Background:SetSize(117, 8)
			self.healthbar:SetSize(117, 12)
			self.manabar:SetWidth(117)
		end

		self.Background:ClearAllPoints()
		self.Background:SetPoint("LEFT", self, 7, 3)
		self.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Minus")
		self.deadText:ClearAllPoints()
		self.deadText:SetPoint("CENTER", self.healthbar, 0, 0)
		self.healthbar:ClearAllPoints()
		self.healthbar:SetPoint("LEFT", 7, 3)
		self.healthbar.TextString:ClearAllPoints()
		self.healthbar.TextString:SetPoint("CENTER", self.healthbar, 0, 0)
		self.healthbar.LeftText:ClearAllPoints()
		self.healthbar.LeftText:SetPoint("LEFT", self.healthbar, 1, 0)
		self.healthbar.RightText:ClearAllPoints()
		self.healthbar.RightText:SetPoint("RIGHT", self.healthbar, 0, 0)
		self.name:ClearAllPoints()
		self.name:SetPoint("TOPLEFT", self, "TOPLEFT", 8, -24.5)
		self.name:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", -110, -37.5)
	else
		if cfg.bigTargetHealthBars then
			if classification == "worldboss" or classification == "elite" then
				self.borderTexture:SetTexture("Interface\\TargetingFrame\\TargetFrameElite")
			elseif classification == "rareelite" then
				self.borderTexture:SetTexture("Interface\\TargetingFrame\\TargetFrameRareElite")
			elseif classification == "rare" then
				self.borderTexture:SetTexture("Interface\\TargetingFrame\\TargetFrameRare")
			else
				self.borderTexture:SetTexture("Interface\\TargetingFrame\\TargetFrame")
			end

			self.Background:SetHeight(38)
			self.healthbar:SetHeight(27)
			self.highLevelTexture:ClearAllPoints()
			self.highLevelTexture:SetPoint("CENTER", self.manabar, "BOTTOMRIGHT", 53.5, -2.5)
			self.manabar:SetHeight(12)
			self.manabar:ClearAllPoints()
			self.manabar:SetPoint("TOPLEFT", self, 7, -52)
		else
			if classification == "worldboss" or classification == "elite" then
				self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameElite")
			elseif classification == "rareelite" then
				self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRareElite")
			elseif classification == "rare" then
				self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRare")
			else
				self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrame")
			end

			self.Background:SetHeight(38)
			self.healthbar:SetHeight(18)
			self.highLevelTexture:ClearAllPoints()
			self.highLevelTexture:SetPoint("CENTER", self.manabar, "BOTTOMRIGHT", 53.5, -4.5)
			self.manabar:SetHeight(17)
			self.manabar:ClearAllPoints()
			self.manabar:SetPoint("TOPLEFT", self, 7, -45)
		end

		if cfg.wideTargetFrames and cfg.wideTargetFramesWidth >= 231 then
			self.Background:SetWidth(cfg.wideTargetFramesWidth - 115)
			self.healthbar:SetWidth(cfg.wideTargetFramesWidth - 115)
			self.manabar:SetWidth(cfg.wideTargetFramesWidth - 115)
		else
			self.Background:SetWidth(117)
			self.healthbar:SetWidth(117)
			self.manabar:SetWidth(117)
		end

		self.Background:ClearAllPoints()
		self.Background:SetPoint("BOTTOMRIGHT", self, -108, 38)
		self.healthbar:ClearAllPoints()
		self.healthbar:SetPoint("TOPLEFT", self, 7, -24)
		self.nameBackground:Hide()
		self.nameBackground:SetAlpha(0)
		self.deadText:ClearAllPoints()
		self.deadText:SetPoint("CENTER", self.healthbar, 0, 0)
		self.healthbar.TextString:ClearAllPoints()
		self.healthbar.TextString:SetPoint("CENTER", self.healthbar, 0, 0)
		self.healthbar.LeftText:ClearAllPoints()
		self.healthbar.LeftText:SetPoint("LEFT", self.healthbar, 1, 0)
		self.healthbar.RightText:ClearAllPoints()
		self.healthbar.RightText:SetPoint("RIGHT", self.healthbar, 0, 0)
		self.manabar.LeftText:ClearAllPoints()
		self.manabar.LeftText:SetPoint("LEFT", self.manabar, 1, 0)
		self.manabar.RightText:ClearAllPoints()
		self.manabar.RightText:SetPoint("RIGHT", self.manabar, 0, 0)
		self.manabar.TextString:ClearAllPoints()
		self.manabar.TextString:SetPoint("CENTER", self.manabar, 0, 0)
		self.name:ClearAllPoints()
		self.name:SetPoint("TOPLEFT", self, 8, -7.5)
		self.name:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", -110, -19.5)
	end

	FocusFrameNumericalThreat:SetAlpha(0)
	TargetFrameNumericalThreat:SetPoint("BOTTOM", PlayerFrame, "TOP", 72, -21)
end)

-- Disables the buffs on top option.

hooksecurefunc("FocusFrame_UpdateBuffsOnTop", function()
	FocusFrame.buffsOnTop = false

	TargetFrame_UpdateAuras(FocusFrame)
end)

hooksecurefunc("TargetFrame_UpdateBuffsOnTop", function()
	TargetFrame.buffsOnTop = false

	TargetFrame_UpdateAuras(TargetFrame)
end)

-- Fixes the level text positioning on the focus and target frames.

hooksecurefunc("TargetFrame_UpdateLevelTextAnchor", function(self, targetLevel)
	local focusLevel = UnitLevel("focus")
	local targetLevel = UnitLevel("target")

	if cfg.bigTargetHealthBars then
		if focusLevel < 10 then
			FocusFrameTextureFrameLevelText:ClearAllPoints()
			FocusFrameTextureFrameLevelText:SetPoint("CENTER", FocusFrameManaBar, "BOTTOMRIGHT", 53.5, -2.5)
		elseif focusLevel < 100 then
			FocusFrameTextureFrameLevelText:ClearAllPoints()
			FocusFrameTextureFrameLevelText:SetPoint("CENTER", FocusFrameManaBar, "BOTTOMRIGHT", 54.5, -2.5)
		else
			FocusFrameTextureFrameLevelText:ClearAllPoints()
			FocusFrameTextureFrameLevelText:SetPoint("CENTER", FocusFrameManaBar, "BOTTOMRIGHT", 53.5, -2.5)
		end

		if targetLevel < 10 then
			TargetFrameTextureFrameLevelText:ClearAllPoints()
			TargetFrameTextureFrameLevelText:SetPoint("CENTER", TargetFrameManaBar, "BOTTOMRIGHT", 53.5, -2.5)
		elseif targetLevel < 100 then
			TargetFrameTextureFrameLevelText:ClearAllPoints()
			TargetFrameTextureFrameLevelText:SetPoint("CENTER", TargetFrameManaBar, "BOTTOMRIGHT", 54.5, -2.5)
		else
			TargetFrameTextureFrameLevelText:ClearAllPoints()
			TargetFrameTextureFrameLevelText:SetPoint("CENTER", TargetFrameManaBar, "BOTTOMRIGHT", 53.5, -2.5)
		end
	else
		if focusLevel < 10 then
			FocusFrameTextureFrameLevelText:ClearAllPoints()
			FocusFrameTextureFrameLevelText:SetPoint("CENTER", FocusFrameManaBar, "BOTTOMRIGHT", 53.5, -4.5)
		elseif focusLevel < 100 then
			FocusFrameTextureFrameLevelText:ClearAllPoints()
			FocusFrameTextureFrameLevelText:SetPoint("CENTER", FocusFrameManaBar, "BOTTOMRIGHT", 54.5, -4.5)
		else
			FocusFrameTextureFrameLevelText:ClearAllPoints()
			FocusFrameTextureFrameLevelText:SetPoint("CENTER", FocusFrameManaBar, "BOTTOMRIGHT", 53.5, -4.5)
		end

		if targetLevel < 10 then
			TargetFrameTextureFrameLevelText:ClearAllPoints()
			TargetFrameTextureFrameLevelText:SetPoint("CENTER", TargetFrameManaBar, "BOTTOMRIGHT", 53.5, -4.5)
		elseif targetLevel < 100 then
			TargetFrameTextureFrameLevelText:ClearAllPoints()
			TargetFrameTextureFrameLevelText:SetPoint("CENTER", TargetFrameManaBar, "BOTTOMRIGHT", 54.5, -4.5)
		else
			TargetFrameTextureFrameLevelText:ClearAllPoints()
			TargetFrameTextureFrameLevelText:SetPoint("CENTER", TargetFrameManaBar, "BOTTOMRIGHT", 53.5, -4.5)
		end
	end
end)

-- Fixes the target of target background.

hooksecurefunc("TargetofTarget_Update", function(self, elapsed)
	TargetFrameToTBackground:ClearAllPoints()
	TargetFrameToTBackground:SetPoint("CENTER", TargetFrameToT, 22, -1)
	TargetFrameToTBackground:SetSize(46, 14)
end)
