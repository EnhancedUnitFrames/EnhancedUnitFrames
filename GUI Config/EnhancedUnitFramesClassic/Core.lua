local f = CreateFrame("Frame")

f:RegisterEvent("ADDON_LOADED")

local function IsAddOnLoaded(self, event, addon)
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

f:SetScript("OnEvent", IsAddOnLoaded)
