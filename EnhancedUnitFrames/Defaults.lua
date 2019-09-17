-- Sets configuration defaults if this is first-run.

eufCfg = {}
eufCfgCharacter = {}

function SetDefaults()
	if eufCfg.bigPlayerHealthBar == nil then
		eufCfg.bigPlayerHealthBar = false
	end

	if eufCfg.bigTargetHealthBar == nil then
		eufCfg.bigTargetHealthBar = false
	end

	if eufCfg.classHealthBarColor == nil then
		eufCfg.classHealthBarColor = true
	end

	if eufCfg.classIconPortraits == nil then
		eufCfg.classIconPortraits = false
	end

	if eufCfg.elitePlayerFrame == nil then
		eufCfg.elitePlayerFrame = false
	end

	if eufCfg.hideHitIndicators == nil then
		eufCfg.hideHitIndicators = false
	end

	if eufCfg.hidePowerAnimation == nil then
		eufCfg.hidePowerAnimation = false
	end

	if eufCfg.mirroredPositioning == nil then
		eufCfg.mirroredPositioning = false
	end

	if eufCfg.hidePetStatusText == nil then
		eufCfg.hidePetStatusText = false
	end

	if eufCfg.hideRestingIcon == nil then
		eufCfg.hideRestingIcon = false
	end

	if eufCfg.largeAuraIconSize == nil then
		eufCfg.largeAuraIconSize = 25
	end

	if eufCfg.rarePlayerFrame == nil then
		eufCfg.rarePlayerFrame = false
	end

	if eufCfg.rareElitePlayerFrame == nil then
		eufCfg.rareElitePlayerFrame = false
	end

	if eufCfg.reactionHealthBarColor == nil then
		eufCfg.reactionHealthBarColor = true
	end

	if isClassic() then
		if eufCfg.shamanClassColorFix == nil then
			eufCfg.shamanClassColorFix = true
		end
	end

	if eufCfg.smallAuraIconSize == nil then
		eufCfg.smallAuraIconSize = 20
	end

	if eufCfg.upperCaseAbbreviation == nil then
		eufCfg.upperCaseAbbreviation = true
	end

	if eufCfg.wideTargetFrame == nil then
		eufCfg.wideTargetFrame = true
	end

	if eufCfg.wideTargetFrameWidth == nil then
		eufCfg.wideTargetFrameWidth = 280
	end

	if eufCfgCharacter.enabled == nil then
		eufCfgCharacter.enabled = false
	end

	if eufCfgCharacter.enabled then
		if eufCfgCharacter.bigPlayerHealthBar == nil then
			eufCfgCharacter.bigPlayerHealthBar = eufCfg.bigPlayerHealthBar
		end

		if eufCfgCharacter.bigTargetHealthBar == nil then
			eufCfgCharacter.bigTargetHealthBar = eufCfg.bigTargetHealthBar
		end

		if eufCfgCharacter.classHealthBarColor == nil then
			eufCfgCharacter.classHealthBarColor = eufCfg.classHealthBarColor
		end

		if eufCfgCharacter.classIconPortraits == nil then
			eufCfgCharacter.classIconPortraits = eufCfg.classIconPortraits
		end

		if eufCfgCharacter.elitePlayerFrame == nil then
			eufCfgCharacter.elitePlayerFrame = eufCfg.elitePlayerFrame
		end

		if eufCfgCharacter.hideHitIndicators == nil then
			eufCfgCharacter.hideHitIndicators = eufCfg.hideHitIndicators
		end

		if eufCfgCharacter.hidePowerAnimation == nil then
			eufCfgCharacter.hidePowerAnimation = eufCfg.hidePowerAnimation
		end

		if eufCfgCharacter.mirroredPositioning == nil then
			eufCfgCharacter.mirroredPositioning = eufCfg.mirroredPositioning
		end

		if eufCfgCharacter.hidePetStatusText == nil then
			eufCfgCharacter.hidePetStatusText = eufCfg.hidePetStatusText
		end

		if eufCfgCharacter.hideRestingIcon == nil then
			eufCfgCharacter.hideRestingIcon = eufCfg.hideRestingIcon
		end

		if eufCfgCharacter.largeAuraIconSize == nil then
			eufCfgCharacter.largeAuraIconSize = eufCfg.largeAuraIconSize
		end

		if eufCfgCharacter.rarePlayerFrame == nil then
			eufCfgCharacter.rarePlayerFrame = eufCfg.rarePlayerFrame
		end

		if eufCfgCharacter.rareElitePlayerFrame == nil then
			eufCfgCharacter.rareElitePlayerFrame = eufCfg.rareElitePlayerFrame
		end

		if eufCfgCharacter.reactionHealthBarColor == nil then
			eufCfgCharacter.reactionHealthBarColor = eufCfg.reactionHealthBarColor
		end

		if isClassic() then
			if eufCfgCharacter.shamanClassColorFix == nil then
				eufCfgCharacter.shamanClassColorFix = eufCfg.shamanClassColorFix
			end
		end

		if eufCfgCharacter.smallAuraIconSize == nil then
			eufCfgCharacter.smallAuraIconSize = eufCfg.smallAuraIconSize
		end

		if eufCfgCharacter.upperCaseAbbreviation == nil then
			eufCfgCharacter.upperCaseAbbreviation = eufCfg.upperCaseAbbreviation
		end

		if eufCfgCharacter.wideTargetFrame == nil then
			eufCfgCharacter.wideTargetFrame = eufCfg.wideTargetFrame
		end

		if eufCfgCharacter.wideTargetFrameWidth == nil then
			eufCfgCharacter.wideTargetFrameWidth = eufCfg.wideTargetFrameWidth
		end
	end
end
