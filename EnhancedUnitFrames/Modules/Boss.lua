-- Makes the boss frame health bar bigger.

function BossFrameStyling()
	for i = 1, 4 do
		_G["Boss" .. i .. "TargetFrameHealthBar"]:SetSize(117, 27)
		_G["Boss" .. i .. "TargetFrameHealthBar"]:ClearAllPoints()
		_G["Boss" .. i .. "TargetFrameHealthBar"]:SetPoint("LEFT", _G["Boss" .. i .. "TargetFrame"], 7, 12)
		_G["Boss" .. i .. "TargetFrameNameBackground"]:Hide()
		_G["Boss" .. i .. "TargetFrameTextureFrameTexture"]:SetTexture("Interface\\AddOns\\EnhancedUnitFrames\\Media\\Boss")
	end
end
