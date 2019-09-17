-- Changes the Shaman class color to reflect live.

function ShamanClassColorFix()
	local function Color()
		RAID_CLASS_COLORS['SHAMAN']["r"] = 0
		RAID_CLASS_COLORS['SHAMAN']["g"] = 0.44
		RAID_CLASS_COLORS['SHAMAN']["b"] = 0.87
		RAID_CLASS_COLORS['SHAMAN']["colorStr"] = "ff0070de"
	end

	if eufCfgCharacter.enabled then
		if eufCfgCharacter.shamanClassColorFix then
			Color()
		end
	else
		if eufCfg.shamanClassColorFix then
			Color()
		end
	end
end
