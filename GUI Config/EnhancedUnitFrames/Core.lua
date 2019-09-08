function isClassic()
	return WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
end

-- Loads the addon's components and initializes the option panel.

local euf = CreateFrame("Frame")

euf:RegisterEvent("ADDON_LOADED")
euf:RegisterEvent("PLAYER_ENTERING_WORLD")

local function isAddOnLoaded(self, event, addon)
	if event == "ADDON_LOADED" then
		SetDefaults()
		AuraStyling()
		BossFrameStyling()
		ClassIconPortraits()
		MirroredPositioning()
		PlayerFrameStyling()
		StatusBarStyling()
		StatusTextStyling()
		TargetFrameStyling()

		if isClassic() then
			DruidPowerBar()
			ShamanClassColorFix()
		else
			FocusFrameStyling()
		end

		euf:UnregisterEvent("ADDON_LOADED")
	elseif event == "PLAYER_ENTERING_WORLD" then
		hooksecurefunc("TextStatusBar_OnEvent", function(self, event, ...)
			TextStatusBar_UpdateTextString(self)
		end)

		euf:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
end

euf:SetScript("OnEvent", isAddOnLoaded)

-- Creates the addon's slash command.

SlashCmdList.euf = function()
	InterfaceOptionsFrame_OpenToCategory(eufOptions)
	InterfaceOptionsFrame_OpenToCategory(eufOptions)
	PlaySound(852)
end

SLASH_euf1 = "/euf"
