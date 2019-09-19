-- Sets configuration defaults if this is first-run.

eufDB = {}
eufCharacterDB = {}

function SetDefaults()
	if eufDB.bigPlayerHealthBar == nil then
		eufDB.bigPlayerHealthBar = false
	end

	if eufDB.bigTargetHealthBar == nil then
		eufDB.bigTargetHealthBar = false
	end

	if eufDB.classHealthBarColor == nil then
		eufDB.classHealthBarColor = true
	end

	if eufDB.classIconPortraits == nil then
		eufDB.classIconPortraits = false
	end

	if eufDB.elitePlayerFrame == nil then
		eufDB.elitePlayerFrame = false
	end

	if eufDB.hideHitIndicators == nil then
		eufDB.hideHitIndicators = false
	end

	if eufDB.hidePowerAnimation == nil then
		eufDB.hidePowerAnimation = false
	end

	if eufDB.mirroredPositioning == nil then
		eufDB.mirroredPositioning = false
	end

	if eufDB.hidePetStatusText == nil then
		eufDB.hidePetStatusText = false
	end

	if eufDB.hideRestingIcon == nil then
		eufDB.hideRestingIcon = false
	end

	if eufDB.largeAuraIconSize == nil then
		eufDB.largeAuraIconSize = 25
	end

	if eufDB.rarePlayerFrame == nil then
		eufDB.rarePlayerFrame = false
	end

	if eufDB.rareElitePlayerFrame == nil then
		eufDB.rareElitePlayerFrame = false
	end

	if eufDB.reactionHealthBarColor == nil then
		eufDB.reactionHealthBarColor = true
	end

	if isClassic() then
		if eufDB.shamanClassColorFix == nil then
			eufDB.shamanClassColorFix = true
		end
	end

	if eufDB.smallAuraIconSize == nil then
		eufDB.smallAuraIconSize = 20
	end

	if eufDB.statusTextBoth == nil then
		if GetCVar("statusTextDisplay") == "BOTH" then
			eufDB.statusTextBoth = true
		end
	end

	if eufDB.statusTextBothCondensed == nil then
		eufDB.statusTextBothCondensed = false
	end

	if eufDB.statusTextBothCondensedBar == nil then
		eufDB.statusTextBothCondensedBar = false
	end

	if eufDB.statusTextBothCondensedBrackets == nil then
		eufDB.statusTextBothCondensedBrackets = false
	end

	if eufDB.statusTextBothCondensedDash == nil then
		eufDB.statusTextBothCondensedDash = true
	end

	if eufDB.statusTextBothCondensedParentheses == nil then
		eufDB.statusTextBothCondensedParentheses = false
	end

	if eufDB.statusTextBothCondensedSlash == nil then
		eufDB.statusTextBothCondensedSlash = false
	end

	if eufDB.statusTextNone == nil then
		if GetCVar("statusTextDisplay") == "NONE" then
			eufDB.statusTextNone = true
		end
	end

	if eufDB.statusTextNumeric == nil then
		if GetCVar("statusTextDisplay") == "NUMERIC" then
			eufDB.statusTextNumeric = true
		end
	end

	if eufDB.statusTextPercent == nil then
		if GetCVar("statusTextDisplay") == "PERCENT" then
			eufDB.statusTextPercent = true
		end
	end

	if eufDB.upperCaseAbbreviation == nil then
		eufDB.upperCaseAbbreviation = true
	end

	if eufDB.wideTargetFrame == nil then
		eufDB.wideTargetFrame = true
	end

	if eufDB.wideTargetFrameWidth == nil then
		eufDB.wideTargetFrameWidth = 280
	end

	if eufCharacterDB.enabled == nil then
		eufCharacterDB.enabled = false
	end

	if eufCharacterDB.enabled then
		if eufCharacterDB.bigPlayerHealthBar == nil then
			eufCharacterDB.bigPlayerHealthBar = eufDB.bigPlayerHealthBar
		end

		if eufCharacterDB.bigTargetHealthBar == nil then
			eufCharacterDB.bigTargetHealthBar = eufDB.bigTargetHealthBar
		end

		if eufCharacterDB.classHealthBarColor == nil then
			eufCharacterDB.classHealthBarColor = eufDB.classHealthBarColor
		end

		if eufCharacterDB.classIconPortraits == nil then
			eufCharacterDB.classIconPortraits = eufDB.classIconPortraits
		end

		if eufCharacterDB.elitePlayerFrame == nil then
			eufCharacterDB.elitePlayerFrame = eufDB.elitePlayerFrame
		end

		if eufCharacterDB.hideHitIndicators == nil then
			eufCharacterDB.hideHitIndicators = eufDB.hideHitIndicators
		end

		if eufCharacterDB.hidePowerAnimation == nil then
			eufCharacterDB.hidePowerAnimation = eufDB.hidePowerAnimation
		end

		if eufCharacterDB.mirroredPositioning == nil then
			eufCharacterDB.mirroredPositioning = eufDB.mirroredPositioning
		end

		if eufCharacterDB.hidePetStatusText == nil then
			eufCharacterDB.hidePetStatusText = eufDB.hidePetStatusText
		end

		if eufCharacterDB.hideRestingIcon == nil then
			eufCharacterDB.hideRestingIcon = eufDB.hideRestingIcon
		end

		if eufCharacterDB.largeAuraIconSize == nil then
			eufCharacterDB.largeAuraIconSize = eufDB.largeAuraIconSize
		end

		if eufCharacterDB.rarePlayerFrame == nil then
			eufCharacterDB.rarePlayerFrame = eufDB.rarePlayerFrame
		end

		if eufCharacterDB.rareElitePlayerFrame == nil then
			eufCharacterDB.rareElitePlayerFrame = eufDB.rareElitePlayerFrame
		end

		if eufCharacterDB.reactionHealthBarColor == nil then
			eufCharacterDB.reactionHealthBarColor = eufDB.reactionHealthBarColor
		end

		if isClassic() then
			if eufCharacterDB.shamanClassColorFix == nil then
				eufCharacterDB.shamanClassColorFix = eufDB.shamanClassColorFix
			end
		end

		if eufCharacterDB.smallAuraIconSize == nil then
			eufCharacterDB.smallAuraIconSize = eufDB.smallAuraIconSize
		end

		if eufCharacterDB.statusTextBoth == nil then
			eufCharacterDB.statusTextBoth = eufDB.statusTextBoth
		end

		if eufDB.statusTextBothCondensed == nil then
			eufCharacterDB.statusTextBothCondensed = eufDB.statusTextBothCondensed
		end

		if eufCharacterDB.statusTextBothCondensedBar == nil then
			eufCharacterDB.statusTextBothCondensedBar = eufDB.statusTextBothCondensedBar
		end

		if eufCharacterDB.statusTextBothCondensedBrackets == nil then
			eufCharacterDB.statusTextBothCondensedBrackets = eufDB.statusTextBothCondensedBrackets
		end

		if eufCharacterDB.statusTextBothCondensedDash == nil then
			eufCharacterDB.statusTextBothCondensedDash = eufDB.statusTextBothCondensedDash
		end

		if eufCharacterDB.statusTextBothCondensedParentheses == nil then
			eufCharacterDB.statusTextBothCondensedParentheses = eufDB.statusTextBothCondensedParentheses
		end

		if eufCharacterDB.statusTextBothCondensedSlash == nil then
			eufCharacterDB.statusTextBothCondensedSlash = eufDB.statusTextBothCondensedSlash
		end

		if eufCharacterDB.statusTextNone == nil then
			eufCharacterDB.statusTextNone = eufDB.statusTextNone
		end

		if eufCharacterDB.statusTextNumeric == nil then
			eufCharacterDB.statusTextNumeric = eufDB.statusTextNumeric
		end

		if eufCharacterDB.statusTextPercent == nil then
			eufCharacterDB.statusTextPercent = eufDB.statusTextPercent
		end

		if eufCharacterDB.upperCaseAbbreviation == nil then
			eufCharacterDB.upperCaseAbbreviation = eufDB.upperCaseAbbreviation
		end

		if eufCharacterDB.wideTargetFrame == nil then
			eufCharacterDB.wideTargetFrame = eufDB.wideTargetFrame
		end

		if eufCharacterDB.wideTargetFrameWidth == nil then
			eufCharacterDB.wideTargetFrameWidth = eufDB.wideTargetFrameWidth
		end
	end
end
