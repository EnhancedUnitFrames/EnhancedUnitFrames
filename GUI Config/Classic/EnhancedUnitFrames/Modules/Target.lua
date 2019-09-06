function TargetFrameStyling()
	-- Source: UnitFramesImproved by KawF.
	-- Adds status bar text to the target frame.

	function createStatusBarText(name, parentName, parent, point, x, y)
		local fontString = parent:CreateFontString(parentName .. name, nil, "TextStatusBarText")

		fontString:SetPoint(point, parent, point, x, y)

		return fontString
	end

	TargetFrameHealthBar.LeftText = createStatusBarText("TextLeft", "TargetFrameHealthBar", TargetFrameTextureFrame, "LEFT", 8, 3)
	TargetFrameHealthBar.RightText = createStatusBarText("TextRight", "TargetFrameHealthBar", TargetFrameTextureFrame, "RIGHT", -110, 3)
	TargetFrameHealthBar.TextString = createStatusBarText("Text", "TargetFrameHealthBar", TargetFrameTextureFrame, "CENTER", -50, 40)
	TargetFrameManaBar.LeftText = createStatusBarText("TextLeft", "TargetFrameManaBar", TargetFrameTextureFrame, "LEFT", 8, -8)
	TargetFrameManaBar.RightText = createStatusBarText("TextRight", "TargetFrameManaBar", TargetFrameTextureFrame, "RIGHT", -110, -8)		
	TargetFrameManaBar.TextString = createStatusBarText("Text", "TargetFrameManaBar", TargetFrameTextureFrame, "CENTER", -50, -8)

	if cfg.wideTargetFrame and cfg.wideTargetFrameWidth >= 231 then
		-- Source: Wide Target by Gello.
		-- Makes the target frame wider.

		local cx = 232
		local cy = 100
		local frame = TargetFrame.textureFrame
		local left = frame:CreateTexture(nil, "BACKGROUND")
		local mid = frame:CreateTexture(nil, "BACKGROUND")
		local targetWidth = cfg.wideTargetFrameWidth
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

		TargetFrame:SetWidth(targetWidth)
	end

	-- Styles the focus and target frames.

	hooksecurefunc("TargetFrame_CheckClassification", function(self, forceNormalTexture)
		local classification = UnitClassification(self.unit)

		if cfg.bigTargetHealthBar then
			if classification == "worldboss" or classification == "elite" then
				self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameElite")
			elseif classification == "rareelite" then
				self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRareElite")
			elseif classification == "rare" then
				self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRare")
			else
				self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrame")
			end

			TargetFrameBackground:SetHeight(38)
			TargetFrameHealthBar:SetHeight(27)
			TargetFrameTextureFrameHighLevelTexture:ClearAllPoints()
			TargetFrameTextureFrameHighLevelTexture:SetPoint("CENTER", TargetFrameManaBar, "BOTTOMRIGHT", 53.5, -2.5)
			TargetFrameManaBar:SetHeight(12)
			TargetFrameManaBar:ClearAllPoints()
			TargetFrameManaBar:SetPoint("TOPLEFT", self, 7, -52)
		else
			if classification == "worldboss" or classification == "elite" then
				self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameEliteWhoa")
			elseif classification == "rareelite" then
				self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRareEliteWhoa")
			elseif classification == "rare" then
				self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameRareWhoa")
			else
				self.borderTexture:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\TargetFrameWhoa")
			end

			TargetFrameBackground:SetHeight(38)
			TargetFrameHealthBar:SetHeight(18)
			TargetFrameTextureFrameHighLevelTexture:ClearAllPoints()
			TargetFrameTextureFrameHighLevelTexture:SetPoint("CENTER", TargetFrameManaBar, "BOTTOMRIGHT", 53.5, -4.5)
			TargetFrameManaBar:SetHeight(17)
			TargetFrameManaBar:ClearAllPoints()
			TargetFrameManaBar:SetPoint("TOPLEFT", TargetFrame, 7, -45)
		end

		if cfg.wideTargetFrame and cfg.wideTargetFrameWidth >= 231 then
			TargetFrameBackground:SetWidth(cfg.wideTargetFrameWidth - 115)
			TargetFrameHealthBar:SetWidth(cfg.wideTargetFrameWidth - 115)
			TargetFrameManaBar:SetWidth(cfg.wideTargetFrameWidth - 115)
		else
			TargetFrameBackground:SetWidth(117)
			TargetFrameHealthBar:SetWidth(117)
			TargetFrameManaBar:SetWidth(117)
		end

		TargetFrameBackground:ClearAllPoints()
		TargetFrameBackground:SetPoint("BOTTOMRIGHT", TargetFrame, -108, 38)
		TargetFrameNameBackground:Hide()
		TargetFrameNameBackground:SetAlpha(0)
		TargetFrameHealthBar:ClearAllPoints()
		TargetFrameHealthBar:SetPoint("TOPLEFT", TargetFrame, 7, -24)
		TargetFrameHealthBar.LeftText:ClearAllPoints()
		TargetFrameHealthBar.LeftText:SetPoint("LEFT", TargetFrameHealthBar, 1, 0)
		TargetFrameHealthBar.RightText:ClearAllPoints()
		TargetFrameHealthBar.RightText:SetPoint("RIGHT", TargetFrameHealthBar, 0, 0)
		TargetFrameHealthBarText:ClearAllPoints()
		TargetFrameHealthBarText:SetPoint("CENTER", TargetFrameHealthBar, 0, 0)
		TargetFrameManaBar.LeftText:ClearAllPoints()
		TargetFrameManaBar.LeftText:SetPoint("LEFT", TargetFrameManaBar, 1, 0)
		TargetFrameManaBar.RightText:ClearAllPoints()
		TargetFrameManaBar.RightText:SetPoint("RIGHT", TargetFrameManaBar, 0, 0)
		TargetFrameManaBarText:ClearAllPoints()
		TargetFrameManaBarText:SetPoint("CENTER", TargetFrameManaBar, 0, 0)
		TargetFrameTextureFrameDeadText:ClearAllPoints()
		TargetFrameTextureFrameDeadText:SetPoint("CENTER", TargetFrameHealthBar, 0, 0)
		TargetFrameTextureFrameName:ClearAllPoints()
		TargetFrameTextureFrameName:SetPoint("TOPLEFT", TargetFrame, 8, -7.5)
		TargetFrameTextureFrameName:SetPoint("BOTTOMRIGHT", TargetFrame, "TOPRIGHT", -110, -19.5)
	end)

	-- Changes the status bar text to reflect live.

	TargetFrameHealthBarText:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
	TargetFrameHealthBar.LeftText:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
	TargetFrameHealthBar.RightText:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
	TargetFrameManaBarText:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
	TargetFrameManaBar.LeftText:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
	TargetFrameManaBar.RightText:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")

	-- Disables the buffs on top option.

	hooksecurefunc("TargetFrame_UpdateBuffsOnTop", function()
		TargetFrame.buffsOnTop = false

		TargetFrame_UpdateAuras(TargetFrame)
	end)

	-- Fixes the level text positioning on the focus and target frames.

	hooksecurefunc("TargetFrame_UpdateLevelTextAnchor", function(self, targetLevel)
		local targetLevel = UnitLevel("target")

		if cfg.bigTargetHealthBar then
			TargetFrameTextureFrameLevelText:ClearAllPoints()
			TargetFrameTextureFrameLevelText:SetPoint("CENTER", TargetFrameManaBar, "BOTTOMRIGHT", 53.5, -2.5)
		else
			TargetFrameTextureFrameLevelText:ClearAllPoints()
			TargetFrameTextureFrameLevelText:SetPoint("CENTER", TargetFrameManaBar, "BOTTOMRIGHT", 53.5, -4.5)
		end
	end)

	-- Fixes the target of target background.

	hooksecurefunc("TargetofTarget_Update", function(self, elapsed)
		TargetFrameToTBackground:ClearAllPoints()
		TargetFrameToTBackground:SetPoint("CENTER", TargetFrameToT, 22, -1)
		TargetFrameToTBackground:SetSize(46, 14)
	end)
end