-- Changes the Shaman class color to reflect live.

function ShamanClassColorFix()
	local function Color()
		RAID_CLASS_COLORS['SHAMAN']["r"] = 0
		RAID_CLASS_COLORS['SHAMAN']["g"] = 0.44
		RAID_CLASS_COLORS['SHAMAN']["b"] = 0.87
		RAID_CLASS_COLORS['SHAMAN']["colorStr"] = "ff0070de"
	end

	if eufCharacterDB.enabled then
		if eufCharacterDB.shamanClassColorFix then
			Color()
		end
	else
		if eufDB.shamanClassColorFix then
			Color()
		end
	end
end
