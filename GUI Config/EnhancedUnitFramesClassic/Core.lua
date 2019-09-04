local f = CreateFrame("Frame")
     
local function IsAddOnLoaded(self, event, arg1, ...)
	if event == "ADDON_LOADED" then
		AuraStyling()
		BossFrameStyling()
		ShamanClassColorFix()
		PlayerFrameStyling()
		ClassIconPortraits()
		StatusBarStyling()
		StatusTextStyling()
		TargetFrameStyling()
		f:UnregisterEvent("ADDON_LOADED")
	end
end
     
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", IsAddOnLoaded)
