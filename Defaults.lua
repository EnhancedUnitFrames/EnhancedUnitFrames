-- Sets configuration defaults if this is first-run.

cfg = {}
cfgCharacter = {}

function SetDefaults()
	if cfg.bigPlayerHealthBar == nil then
		cfg.bigPlayerHealthBar = false
	end

	if cfg.bigTargetHealthBar == nil then
		cfg.bigTargetHealthBar = false
	end

	if cfg.classHealthBarColor == nil then
		cfg.classHealthBarColor = true
	end

	if cfg.classIconPortraits == nil then
		cfg.classIconPortraits = false
	end

	if cfg.elitePlayerFrame == nil then
		cfg.elitePlayerFrame = false
	end

	if cfg.hideHitIndicators == nil then
		cfg.hideHitIndicators = false
	end

	if cfg.hidePowerAnimation == nil then
		cfg.hidePowerAnimation = false
	end

	if cfg.mirroredPositioning == nil then
		cfg.mirroredPositioning = false
	end

	if cfg.hidePetStatusText == nil then
		cfg.hidePetStatusText = false
	end

	if cfg.hideRestingIcon == nil then
		cfg.hideRestingIcon = false
	end

	if cfg.largeAuraIconSize == nil then
		cfg.largeAuraIconSize = 25
	end

	if cfg.rarePlayerFrame == nil then
		cfg.rarePlayerFrame = false
	end

	if cfg.rareElitePlayerFrame == nil then
		cfg.rareElitePlayerFrame = false
	end

	if cfg.reactionHealthBarColor == nil then
		cfg.reactionHealthBarColor = true
	end

	if isClassic() then
		if cfg.shamanClassColorFix == nil then
			cfg.shamanClassColorFix = true
		end
	end

	if cfg.smallAuraIconSize == nil then
		cfg.smallAuraIconSize = 20
	end

	if cfg.upperCaseAbbreviation == nil then
		cfg.upperCaseAbbreviation = true
	end

	if cfg.wideTargetFrame == nil then
		cfg.wideTargetFrame = true
	end

	if cfg.wideTargetFrameWidth == nil then
		cfg.wideTargetFrameWidth = 280
	end

	if cfgCharacter.enabled == nil then
		cfgCharacter.enabled = false
	end

	if cfgCharacter.bigPlayerHealthBar == nil then
		cfgCharacter.bigPlayerHealthBar = false
	end

	if cfgCharacter.bigTargetHealthBar == nil then
		cfgCharacter.bigTargetHealthBar = false
	end

	if cfgCharacter.classHealthBarColor == nil then
		cfgCharacter.classHealthBarColor = true
	end

	if cfgCharacter.classIconPortraits == nil then
		cfgCharacter.classIconPortraits = false
	end

	if cfgCharacter.elitePlayerFrame == nil then
		cfgCharacter.elitePlayerFrame = false
	end

	if cfgCharacter.hideHitIndicators == nil then
		cfgCharacter.hideHitIndicators = false
	end

	if cfgCharacter.hidePowerAnimation == nil then
		cfgCharacter.hidePowerAnimation = false
	end

	if cfgCharacter.mirroredPositioning == nil then
		cfgCharacter.mirroredPositioning = false
	end

	if cfgCharacter.hidePetStatusText == nil then
		cfgCharacter.hidePetStatusText = false
	end

	if cfgCharacter.hideRestingIcon == nil then
		cfgCharacter.hideRestingIcon = false
	end

	if cfgCharacter.largeAuraIconSize == nil then
		cfgCharacter.largeAuraIconSize = 25
	end

	if cfgCharacter.rarePlayerFrame == nil then
		cfgCharacter.rarePlayerFrame = false
	end

	if cfgCharacter.rareElitePlayerFrame == nil then
		cfgCharacter.rareElitePlayerFrame = false
	end

	if cfgCharacter.reactionHealthBarColor == nil then
		cfgCharacter.reactionHealthBarColor = true
	end

	if isClassic() then
		if cfgCharacter.shamanClassColorFix == nil then
			cfgCharacter.shamanClassColorFix = true
		end
	end

	if cfgCharacter.smallAuraIconSize == nil then
		cfgCharacter.smallAuraIconSize = 20
	end

	if cfgCharacter.upperCaseAbbreviation == nil then
		cfgCharacter.upperCaseAbbreviation = true
	end

	if cfgCharacter.wideTargetFrame == nil then
		cfgCharacter.wideTargetFrame = true
	end

	if cfgCharacter.wideTargetFrameWidth == nil then
		cfgCharacter.wideTargetFrameWidth = 280
	end
end
