-- Loads the addon's components and initializes the option panel.

local euf = CreateFrame("Frame")

euf:RegisterEvent("ADDON_LOADED")

local function IsAddOnLoaded(self, event, addon)
	if event == "ADDON_LOADED" then
		SetDefaults()
		AuraStyling()
		BossFrameStyling()
		ClassIconPortraits()
		MirroredPositioning()
		PlayerFrameStyling()
		ShamanClassColorFix()
		StatusBarStyling()
		StatusTextStyling()
		TargetFrameStyling()

		euf:UnregisterEvent("ADDON_LOADED")
	end
end

euf:SetScript("OnEvent", IsAddOnLoaded)

-- Creates the addon's slash command.

SlashCmdList.euf = function()
	InterfaceOptionsFrame_OpenToCategory(eufOptions)
	InterfaceOptionsFrame_OpenToCategory(eufOptions)
	PlaySound(852)
end

SLASH_euf1 = "/euf"
