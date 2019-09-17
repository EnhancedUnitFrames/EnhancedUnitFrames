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

	if eufCfgCharacter.bigPlayerHealthBar == nil then
		eufCfgCharacter.bigPlayerHealthBar = false
	end

	if eufCfgCharacter.bigTargetHealthBar == nil then
		eufCfgCharacter.bigTargetHealthBar = false
	end

	if eufCfgCharacter.classHealthBarColor == nil then
		eufCfgCharacter.classHealthBarColor = true
	end

	if eufCfgCharacter.classIconPortraits == nil then
		eufCfgCharacter.classIconPortraits = false
	end

	if eufCfgCharacter.elitePlayerFrame == nil then
		eufCfgCharacter.elitePlayerFrame = false
	end

	if eufCfgCharacter.hideHitIndicators == nil then
		eufCfgCharacter.hideHitIndicators = false
	end

	if eufCfgCharacter.hidePowerAnimation == nil then
		eufCfgCharacter.hidePowerAnimation = false
	end

	if eufCfgCharacter.mirroredPositioning == nil then
		eufCfgCharacter.mirroredPositioning = false
	end

	if eufCfgCharacter.hidePetStatusText == nil then
		eufCfgCharacter.hidePetStatusText = false
	end

	if eufCfgCharacter.hideRestingIcon == nil then
		eufCfgCharacter.hideRestingIcon = false
	end

	if eufCfgCharacter.largeAuraIconSize == nil then
		eufCfgCharacter.largeAuraIconSize = 25
	end

	if eufCfgCharacter.rarePlayerFrame == nil then
		eufCfgCharacter.rarePlayerFrame = false
	end

	if eufCfgCharacter.rareElitePlayerFrame == nil then
		eufCfgCharacter.rareElitePlayerFrame = false
	end

	if eufCfgCharacter.reactionHealthBarColor == nil then
		eufCfgCharacter.reactionHealthBarColor = true
	end

	if isClassic() then
		if eufCfgCharacter.shamanClassColorFix == nil then
			eufCfgCharacter.shamanClassColorFix = true
		end
	end

	if eufCfgCharacter.smallAuraIconSize == nil then
		eufCfgCharacter.smallAuraIconSize = 20
	end

	if eufCfgCharacter.upperCaseAbbreviation == nil then
		eufCfgCharacter.upperCaseAbbreviation = true
	end

	if eufCfgCharacter.wideTargetFrame == nil then
		eufCfgCharacter.wideTargetFrame = true
	end

	if eufCfgCharacter.wideTargetFrameWidth == nil then
		eufCfgCharacter.wideTargetFrameWidth = 280
	end
end
