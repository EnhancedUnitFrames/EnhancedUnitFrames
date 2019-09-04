function ShamanClassColorFix()
	if cfg.shamanClassColorFix then
		RAID_CLASS_COLORS['SHAMAN']["r"] = 0
		RAID_CLASS_COLORS['SHAMAN']["g"] = 0.44
		RAID_CLASS_COLORS['SHAMAN']["b"] = 0.87
		RAID_CLASS_COLORS['SHAMAN']["colorStr"] = "ff0070de"
	else
		RAID_CLASS_COLORS['SHAMAN']["r"] = 0.96
		RAID_CLASS_COLORS['SHAMAN']["g"] = 0.55
		RAID_CLASS_COLORS['SHAMAN']["b"] = 0.73
		RAID_CLASS_COLORS['SHAMAN']["colorStr"] = "fff58cba"
	end
end
