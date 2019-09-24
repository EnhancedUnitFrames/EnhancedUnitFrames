-- Sets configuration defaults if this is first-run.

eufDB = {}
eufCharacterDB = {}

function SetDefaults()
	if eufDB.bigFocusFrame == nil then
		eufDB.bigFocusFrame = false
	end

	if eufDB.bigPlayerFrame == nil then
		eufDB.bigPlayerFrame = false
	end

	if eufDB.bigTargetFrame == nil then
		eufDB.bigTargetFrame = false
	end

	if eufDB.classHealthBarColor == nil then
		eufDB.classHealthBarColor = true
	end

	if eufDB.classNameColor == nil then
		eufDB.classNameColor = false
	end

	if eufDB.classNameBackgroundColor == nil then
		eufDB.classNameBackgroundColor = false
	end

	if eufDB.classIconPortraits == nil then
		eufDB.classIconPortraits = false
	end

	if eufDB.defaultFocusFrame == nil then
		eufDB.defaultFocusFrame = false
	end

	if eufDB.defaultPlayerFrame == nil then
		eufDB.defaultPlayerFrame = false
	end

	if eufDB.defaultTargetFrame == nil then
		eufDB.defaultTargetFrame = false
	end

	if eufDB.elitePlayerFrame == nil then
		eufDB.elitePlayerFrame = false
	end

	if eufDB.firstRunMessage == nil then
		eufDB.firstRunMessage = false
	end

	if not isClassic() then
		if eufDB.hideArenaStatusText == nil then
			eufDB.hideArenaStatusText = false
		end

		if eufDB.hideBossStatusText == nil then
			eufDB.hideBossStatusText = false
		end

		if eufDB.hideFocusStatusText == nil then
			eufDB.hideFocusStatusText = false
		end
	end

	if eufDB.hideHitIndicators == nil then
		eufDB.hideHitIndicators = false
	end

	if eufDB.hideNameBackground == nil then
		eufDB.hideNameBackground = false
	end

	if eufDB.hidePartyStatusText == nil then
		eufDB.hidePartyStatusText = false
	end

	if eufDB.hidePetStatusText == nil then
		eufDB.hidePetStatusText = false
	end

	if eufDB.hidePlayerStatusText == nil then
		eufDB.hidePlayerStatusText = false
	end

	if eufDB.hidePowerAnimation == nil then
		eufDB.hidePowerAnimation = false
	end

	if eufDB.hidePowerBarStatusText == nil then
		eufDB.hidePowerBarStatusText = false
	end

	if eufDB.hideRestingIcon == nil then
		eufDB.hideRestingIcon = false
	end

	if eufDB.hideTargetStatusText == nil then
		eufDB.hideTargetStatusText = false
	end

	if eufDB.largeAuraIconSize == nil then
		eufDB.largeAuraIconSize = 25
	end

	if eufDB.mirroredPositioning == nil then
		eufDB.mirroredPositioning = false
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

	if eufDB.reactionNameColor == nil then
		eufDB.reactionNameColor = false
	end

	if eufDB.reactionNameBackgroundColor == nil then
		eufDB.reactionNameBackgroundColor = true
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
		eufDB.statusTextBoth = false
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
		eufDB.statusTextNone = false
	end

	if eufDB.statusTextNumeric == nil then
		eufDB.statusTextNumeric = true
	end

	if eufDB.statusTextPercent == nil then
		eufDB.statusTextPercent = false
	end

	if eufDB.upperCaseAbbreviation == nil then
		eufDB.upperCaseAbbreviation = true
	end

	if eufDB.whoaFocusFrame == nil then
		eufDB.whoaFocusFrame = true
	end

	if eufDB.whoaPlayerFrame == nil then
		eufDB.whoaPlayerFrame = true
	end

	if eufDB.whoaTargetFrame == nil then
		eufDB.whoaTargetFrame = true
	end

	if eufDB.wideFocusFrame == nil then
		eufDB.wideFocusFrame = true
	end

	if eufDB.wideFocusFrameWidth == nil then
		eufDB.wideFocusFrameWidth = 280
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
		if eufCharacterDB.bigFocusFrame == nil then
			eufCharacterDB.bigFocusFrame = eufDB.bigFocusFrame
		end

		if eufCharacterDB.bigPlayerFrame == nil then
			eufCharacterDB.bigPlayerFrame = eufDB.bigPlayerFrame
		end

		if eufCharacterDB.bigTargetFrame == nil then
			eufCharacterDB.bigTargetFrame = eufDB.bigTargetFrame
		end

		if eufCharacterDB.classHealthBarColor == nil then
			eufCharacterDB.classHealthBarColor = eufDB.classHealthBarColor
		end

		if eufCharacterDB.classNameColor == nil then
			eufCharacterDB.classNameColor = eufDB.classNameColor
		end

		if eufCharacterDB.classNameBackgroundColor == nil then
			eufCharacterDB.classNameBackgroundColor = eufDB.classNameBackgroundColor
		end

		if eufCharacterDB.classIconPortraits == nil then
			eufCharacterDB.classIconPortraits = eufDB.classIconPortraits
		end

		if eufCharacterDB.defaultFocusFrame == nil then
			eufCharacterDB.defaultFocusFrame = eufDB.defaultFocusFrame
		end

		if eufCharacterDB.defaultPlayerFrame == nil then
			eufCharacterDB.defaultPlayerFrame = eufDB.defaultPlayerFrame
		end

		if eufCharacterDB.defaultTargetFrame == nil then
			eufCharacterDB.defaultTargetFrame = eufDB.defaultTargetFrame
		end

		if eufCharacterDB.elitePlayerFrame == nil then
			eufCharacterDB.elitePlayerFrame = eufDB.elitePlayerFrame
		end

		if not isClassic() then
			if eufCharacterDB.hideArenaStatusText == nil then
				eufCharacterDB.hideArenaStatusText = eufDB.hideArenaStatusText
			end

			if eufCharacterDB.hideBossStatusText == nil then
				eufCharacterDB.hideBossStatusText = eufDB.hideBossStatusText
			end

			if eufCharacterDB.hideFocusStatusText == nil then
				eufCharacterDB.hideFocusStatusText = eufDB.hideFocusStatusText
			end
		end

		if eufCharacterDB.hideHitIndicators == nil then
			eufCharacterDB.hideHitIndicators = eufDB.hideHitIndicators
		end

		if eufCharacterDB.hideNameBackground == nil then
			eufCharacterDB.hideNameBackground = eufDB.hideNameBackground
		end

		if eufCharacterDB.hidePartyStatusText == nil then
			eufCharacterDB.hidePartyStatusText = eufDB.hidePartyStatusText
		end

		if eufCharacterDB.hidePetStatusText == nil then
			eufCharacterDB.hidePetStatusText = eufDB.hidePetStatusText
		end

		if eufCharacterDB.hidePlayerStatusText == nil then
			eufCharacterDB.hidePlayerStatusText = eufDB.hidePlayerStatusText
		end

		if eufCharacterDB.hidePowerAnimation == nil then
			eufCharacterDB.hidePowerAnimation = eufDB.hidePowerAnimation
		end

		if eufCharacterDB.hidePowerBarStatusText == nil then
			eufCharacterDB.hidePowerBarStatusText = eufDB.hidePowerBarStatusText
		end

		if eufCharacterDB.hideRestingIcon == nil then
			eufCharacterDB.hideRestingIcon = eufDB.hideRestingIcon
		end

		if eufCharacterDB.hideTargetStatusText == nil then
			eufCharacterDB.hideTargetStatusText = eufDB.hideTargetStatusText
		end

		if eufCharacterDB.largeAuraIconSize == nil then
			eufCharacterDB.largeAuraIconSize = eufDB.largeAuraIconSize
		end

		if eufCharacterDB.mirroredPositioning == nil then
			eufCharacterDB.mirroredPositioning = eufDB.mirroredPositioning
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

		if eufCharacterDB.reactionNameColor == nil then
			eufCharacterDB.reactionNameColor = eufDB.reactionNameColor
		end

		if eufCharacterDB.reactionNameBackgroundColor == nil then
			eufCharacterDB.reactionNameBackgroundColor = eufDB.reactionNameBackgroundColor
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

		if eufCharacterDB.statusTextBothCondensed == nil then
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

		if eufCharacterDB.whoaFocusFrame == nil then
			eufCharacterDB.whoaFocusFrame = eufDB.whoaFocusFrame
		end

		if eufCharacterDB.whoaPlayerFrame == nil then
			eufCharacterDB.whoaPlayerFrame = eufDB.whoaPlayerFrame
		end

		if eufCharacterDB.whoaTargetFrame == nil then
			eufCharacterDB.whoaTargetFrame = eufDB.whoaTargetFrame
		end

		if eufCharacterDB.wideFocusFrame == nil then
			eufCharacterDB.wideFocusFrame = eufDB.wideFocusFrame
		end

		if eufCharacterDB.wideFocusFrameWidth == nil then
			eufCharacterDB.wideFocusFrameWidth = eufDB.wideFocusFrameWidth
		end		

		if eufCharacterDB.wideTargetFrame == nil then
			eufCharacterDB.wideTargetFrame = eufDB.wideTargetFrame
		end

		if eufCharacterDB.wideTargetFrameWidth == nil then
			eufCharacterDB.wideTargetFrameWidth = eufDB.wideTargetFrameWidth
		end
	end
end
