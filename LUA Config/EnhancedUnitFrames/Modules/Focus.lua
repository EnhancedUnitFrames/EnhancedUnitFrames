local _, cfg = ...

if not cfg.wideTargetFrames then
	return
end

-- Source: Wide Target by Gello.
-- Makes the focus frame wider.

if cfg.wideTargetFrames and cfg.wideTargetFramesWidth >= 231 then
	local FocusWidth = cfg.wideTargetFramesWidth
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

	FocusFrame:SetWidth(FocusWidth)
end
