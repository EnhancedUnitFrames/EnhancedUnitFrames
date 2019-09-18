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
