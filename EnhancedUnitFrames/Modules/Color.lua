function ColorStyling()
	-- Changes the unit frame dead text color to the unit's class or reaction color.

	function PlayerDeadTextColor()
		if eufCharacterDB.enabled then
			if eufCharacterDB.fontOutline then
				local font, size, style  = PlayerFrameHealthBar.TextString:GetFont()
		
				PlayerFrameHealthBar.TextString:SetFont(font, size, "OUTLINE")
				PlayerFrameHealthBar.TextString:SetShadowOffset(0, 999999)
			end
		else
			if eufDB.fontOutline then
				local font, size, style = PlayerFrameHealthBar.TextString:GetFont()
		
				PlayerFrameHealthBar.TextString:SetFont(font, size, "OUTLINE")
				PlayerFrameHealthBar.TextString:SetShadowOffset(0, 999999)
			end
		end

		local function ClassColor()
			if UnitClass("player") then
				local classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2, UnitClass("player"))]

				if classColor then
					PlayerFrameHealthBar.TextString:SetTextColor(classColor.r, classColor.g, classColor.b)
				end
			else
				PlayerFrameHealthBar.TextString:SetTextColor(1, 0.82, 0)
			end
		end

		local function ReactionColor()
			local function Color()
				local reactionColor = FACTION_BAR_COLORS[UnitReaction("player", "player")]

				if reactionColor then
					PlayerFrameHealthBar.TextString:SetTextColor(reactionColor.r, reactionColor.g, reactionColor.b)
				else
					PlayerFrameHealthBar.TextString:SetTextColor(1, 0.82, 0)
				end
			end

			if eufCharacterDB.enabled then
				if eufCharacterDB.reactionLevelTextColor and not eufCharacterDB.classLevelTextColor then
					Color()
				end
			else
				if eufDB.reactionLevelTextColor and not eufDB.classLevelTextColor then
					Color()
				end
			end
		end

		if eufCharacterDB.enabled then
			if eufCharacterDB.classDeadTextColor then
				ClassColor()
			end

			if eufCharacterDB.reactionDeadTextColor then
				ReactionColor()
			end
		else
			if eufDB.classDeadTextColor then
				ClassColor()
			end

			if eufDB.reactionDeadTextColor then
				ReactionColor()
			end
		end
	end

	function FocusDeadTextColor()
		if eufCharacterDB.enabled then
			if eufCharacterDB.fontOutline then
				local font, size, style = FocusFrameHealthBar.TextString:GetFont()
		
				FocusFrameHealthBar.TextString:SetFont(font, size, "OUTLINE")
				FocusFrameHealthBar.TextString:SetShadowOffset(0, 999999)
			end
		else
			if eufDB.fontOutline then
				local font, size, style = FocusFrameHealthBar.TextString:GetFont()
		
				FocusFrameHealthBar.TextString:SetFont(font, size, "OUTLINE")
				FocusFrameHealthBar.TextString:SetShadowOffset(0, 999999)
			end
		end

		local function ClassColor()
			if UnitIsPlayer("focus") and UnitIsConnected("focus") and UnitClass("focus") then
				local classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2, UnitClass("focus"))]

				if classColor then
					FocusFrameHealthBar.TextString:SetTextColor(classColor.r, classColor.g, classColor.b)
				end
			elseif UnitIsPlayer("focus") and not UnitIsConnected("focus") then
				FocusFrameHealthBar.TextString:SetTextColor(0.5, 0.5, 0.5)
			else
				FocusFrameHealthBar.TextString:SetTextColor(1, 0.82, 0)
			end
		end

		local function ReactionColor()
			local function Color()
				if UnitIsTapDenied("focus") and not UnitPlayerControlled("focus") then
					FocusFrameHealthBar.TextString:SetTextColor(0.5, 0.5, 0.5)
				elseif not UnitIsTapDenied("focus") then
					local reactionColor = FACTION_BAR_COLORS[UnitReaction("focus", "player")]

					if reactionColor then
						FocusFrameHealthBar.TextString:SetTextColor(reactionColor.r, reactionColor.g, reactionColor.b)
					else
						FocusFrameHealthBar.TextString:SetTextColor(1, 0.82, 0)
					end
				end
			end

			if eufCharacterDB.enabled then
				if eufCharacterDB.reactionLevelTextColor and not eufCharacterDB.classLevelTextColor then
					if UnitExists("focus") then
						Color()
					end
				else
					if UnitExists("focus") and not UnitIsPlayer("focus") then
						Color()
					end
				end
			else
				if eufDB.reactionDeadTextColor and not eufDB.classDeadTextColor then
					if UnitExists("focus") then
						Color()
					end
				else
					if UnitExists("focus") and not UnitIsPlayer("focus") then
						Color()
					end
				end
			end
		end

		if eufCharacterDB.enabled then
			if eufCharacterDB.classDeadTextColor then
				ClassColor()
			end

			if eufCharacterDB.reactionDeadTextColor then
				ReactionColor()
			end
		else
			if eufDB.classDeadTextColor then
				ClassColor()
			end

			if eufDB.reactionDeadTextColor then
				ReactionColor()
			end
		end
	end

	function TargetDeadTextColor()
		if eufCharacterDB.enabled then
			if eufCharacterDB.fontOutline then
				local font, size, style = TargetFrameHealthBar.TextString:GetFont()
		
				TargetFrameHealthBar.TextString:SetFont(font, size, "OUTLINE")
				TargetFrameHealthBar.TextString:SetShadowOffset(0, 999999)
			end
		else
			if eufDB.fontOutline then
				local font, size, style = TargetFrameHealthBar.TextString:GetFont()
		
				TargetFrameHealthBar.TextString:SetFont(font, size, "OUTLINE")
				TargetFrameHealthBar.TextString:SetShadowOffset(0, 999999)
			end
		end

		local function ClassColor()
			if UnitIsPlayer("target") and UnitIsConnected("target") and UnitClass("target") then
				local classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2, UnitClass("target"))]

				if classColor then
					TargetFrameHealthBar.TextString:SetTextColor(classColor.r, classColor.g, classColor.b)
				end
			elseif UnitIsPlayer("target") and not UnitIsConnected("target") then
				TargetFrameHealthBar.TextString:SetTextColor(0.5, 0.5, 0.5)
			else
				TargetFrameHealthBar.TextString:SetTextColor(1, 0.82, 0)
			end
		end

		local function ReactionColor()
			local function Color()
				if UnitIsTapDenied("target") and not UnitPlayerControlled("target") then
					TargetFrameHealthBar.TextString:SetTextColor(0.5, 0.5, 0.5)
				elseif not UnitIsTapDenied("target") then
					local reactionColor = FACTION_BAR_COLORS[UnitReaction("target", "player")]

					if reactionColor then
						TargetFrameHealthBar.TextString:SetTextColor(reactionColor.r, reactionColor.g, reactionColor.b)
					else
						TargetFrameHealthBar.TextString:SetTextColor(1, 0.82, 0)
					end
				end
			end

			if eufCharacterDB.enabled then
				if eufCharacterDB.reactionLevelTextColor and not eufCharacterDB.classLevelTextColor then
					if UnitExists("target") then
						Color()
					end
				else
					if UnitExists("target") and not UnitIsPlayer("target") then
						Color()
					end
				end
			else
				if eufDB.reactionDeadTextColor and not eufDB.classDeadTextColor then
					if UnitExists("target") then
						Color()
					end
				else
					if UnitExists("target") and not UnitIsPlayer("target") then
						Color()
					end
				end
			end
		end

		if eufCharacterDB.enabled then
			if eufCharacterDB.classDeadTextColor then
				ClassColor()
			end

			if eufCharacterDB.reactionDeadTextColor then
				ReactionColor()
			end
		else
			if eufDB.classDeadTextColor then
				ClassColor()
			end

			if eufDB.reactionDeadTextColor then
				ReactionColor()
			end
		end
	end

	-- Source: whoa UnitFrames by whoarrior & smokked_.
	-- Changes the unit frame health bar colors to the unit's class or reaction color.

	function HealthBarColor(self, unit)
		local function ClassColor()
			if UnitIsPlayer(unit) and UnitIsConnected(unit) and UnitClass(unit) then
				local classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2, UnitClass(unit))]

				if classColor then
					self:SetStatusBarColor(classColor.r, classColor.g, classColor.b)
				end
			elseif UnitIsPlayer(unit) and not UnitIsConnected(unit) then
				self:SetStatusBarColor(0.5, 0.5, 0.5)
			else
				self:SetStatusBarColor(0, 0.9, 0)
			end
		end

		local function ReactionColor()
			local function Color()
				if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
					self:SetStatusBarColor(0.5, 0.5, 0.5)
				elseif not UnitIsTapDenied(unit) then
					local reactionColor = FACTION_BAR_COLORS[UnitReaction(unit, "player")]

					if reactionColor then
						self:SetStatusBarColor(reactionColor.r, reactionColor.g, reactionColor.b)
					else
						self:SetStatusBarColor(0, 0.9, 0)
					end
				end
			end

			if eufCharacterDB.enabled then
				if eufCharacterDB.reactionHealthBarColor and not eufCharacterDB.classHealthBarColor then
					if UnitExists(unit) then
						Color()
					end
				else
					if UnitExists(unit) and not UnitIsPlayer(unit) then
						Color()
					end
				end
			else
				if eufDB.reactionHealthBarColor and not eufDB.classHealthBarColor then
					if UnitExists(unit) then
						Color()
					end
				else
					if UnitExists(unit) and not UnitIsPlayer(unit) then
						Color()
					end
				end
			end
		end

		if eufCharacterDB.enabled then
			if eufCharacterDB.classHealthBarColor then
				ClassColor()
			end

			if eufCharacterDB.reactionHealthBarColor then
				ReactionColor()
			end
		else
			if eufDB.classHealthBarColor then
				ClassColor()
			end

			if eufDB.reactionHealthBarColor then
				ReactionColor()
			end
		end
	end

	hooksecurefunc("HealthBar_OnValueChanged", function(self)
		HealthBarColor(self, self.unit)
	end)

	hooksecurefunc("UnitFrameHealthBar_Update", HealthBarColor)

	-- Changes the unit frame level text color to the unit's class or reaction color.

	function PlayerLevelTextColor()
		if eufCharacterDB.enabled then
			if eufCharacterDB.fontOutline then
				local font, size, style = PlayerLevelText:GetFont()
		
				PlayerLevelText:SetFont(font, size, "OUTLINE")
				PlayerLevelText:SetShadowOffset(0, 999999)
			end
		else
			if eufDB.fontOutline then
				local font, size, style = PlayerLevelText:GetFont()
		
				PlayerLevelText:SetFont(font, size, "OUTLINE")
				PlayerLevelText:SetShadowOffset(0, 999999)
			end
		end

		local function ClassColor()
			if UnitClass("player") then
				local classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2, UnitClass("player"))]

				if classColor then
					PlayerLevelText:SetTextColor(classColor.r, classColor.g, classColor.b)
				end
			else
				PlayerLevelText:SetTextColor(1, 0.82, 0)
			end
		end

		local function ReactionColor()
			local function Color()
				local reactionColor = FACTION_BAR_COLORS[UnitReaction("player", "player")]

				if reactionColor then
					PlayerLevelText:SetTextColor(reactionColor.r, reactionColor.g, reactionColor.b)
				else
					PlayerLevelText:SetTextColor(1, 0.82, 0)
				end
			end

			if eufCharacterDB.enabled then
				if eufCharacterDB.reactionLevelTextColor and not eufCharacterDB.classLevelTextColor then
					Color()
				end
			else
				if eufDB.reactionLevelTextColor and not eufDB.classLevelTextColor then
					Color()
				end
			end
		end

		if eufCharacterDB.enabled then
			if eufCharacterDB.classLevelTextColor then
				ClassColor()
			end

			if eufCharacterDB.reactionLevelTextColor then
				ReactionColor()
			end
		else
			if eufDB.classLevelTextColor then
				ClassColor()
			end

			if eufDB.reactionLevelTextColor then
				ReactionColor()
			end
		end
	end

	function LevelTextColor(self, unit)
		if eufCharacterDB.enabled then
			if eufCharacterDB.fontOutline then
				local font, size, style = self.levelText:GetFont()
		
				self.levelText:SetFont(font, size, "OUTLINE")
				self.levelText:SetShadowOffset(0, 999999)
			end
		else
			if eufDB.fontOutline then
				local font, size, style = self.levelText:GetFont()
		
				self.levelText:SetFont(font, size, "OUTLINE")
				self.levelText:SetShadowOffset(0, 999999)
			end
		end

		local function ClassColor()
			if UnitIsPlayer(unit) and UnitIsConnected(unit) and UnitClass(unit) then
				local classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2, UnitClass(unit))]

				if classColor then
					self.levelText:SetTextColor(classColor.r, classColor.g, classColor.b)
				end
			elseif UnitIsPlayer(unit) and not UnitIsConnected(unit) then
				self.levelText:SetTextColor(0.5, 0.5, 0.5)
			else
				self.levelText:SetTextColor(1, 0.82, 0)
			end
		end

		local function ReactionColor()
			local function Color()
				if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
					self.levelText:SetTextColor(0.5, 0.5, 0.5)
				elseif not UnitIsTapDenied(unit) then
					local reactionColor = FACTION_BAR_COLORS[UnitReaction(unit, "player")]

					if reactionColor then
						self.levelText:SetTextColor(reactionColor.r, reactionColor.g, reactionColor.b)
					else
						self.levelText:SetTextColor(1, 0.82, 0)
					end
				end
			end

			if eufCharacterDB.enabled then
				if eufCharacterDB.reactionLevelTextColor and not eufCharacterDB.classLevelTextColor then
					if UnitExists(unit) then
						Color()
					end
				else
					if UnitExists(unit) and not UnitIsPlayer(unit) then
						Color()
					end
				end
			else
				if eufDB.reactionLevelTextColor and not eufDB.classLevelTextColor then
					if UnitExists(unit) then
						Color()
					end
				else
					if UnitExists(unit) and not UnitIsPlayer(unit) then
						Color()
					end
				end
			end
		end

		if eufCharacterDB.enabled then
			if eufCharacterDB.classLevelTextColor then
				ClassColor()
			end

			if eufCharacterDB.reactionLevelTextColor then
				ReactionColor()
			end
		else
			if eufDB.classLevelTextColor then
				ClassColor()
			end

			if eufDB.reactionLevelTextColor then
				ReactionColor()
			end
		end
	end

	if isClassic() then
		hooksecurefunc("PlayerFrame_Update", function()
			PlayerLevelTextColor()
		end)
	else
		hooksecurefunc("PlayerFrame_UpdateLevel", function()
			PlayerLevelTextColor()
		end)	
	end

	hooksecurefunc("TargetFrame_CheckLevel", function(self)
		LevelTextColor(self, self.unit)
	end)

	-- Changes the unit frame name color to the unit's class or reaction color.

	function NameColor(self, unit)
		if eufCharacterDB.enabled then
			if eufCharacterDB.fontOutline then
				local font, size, style = self.name:GetFont()
				local playerFont, playerSize, playerStyle  = PlayerName:GetFont()

				PlayerName:SetFont(playerFont, playerSize, "OUTLINE")
				PlayerName:SetShadowOffset(0, 999999)
				self.name:SetFont(font, size, "OUTLINE")
				self.name:SetShadowOffset(0, 999999)
			end
		else
			if eufDB.fontOutline then
				local font, size, style  = self.name:GetFont()
				local playerFont, playerSize, playerStyle  = PlayerName:GetFont()

				PlayerName:SetFont(playerFont, playerSize, "OUTLINE")
				PlayerName:SetShadowOffset(0, 999999)
				self.name:SetFont(font, size, "OUTLINE")
				self.name:SetShadowOffset(0, 999999)
			end
		end

		local function ClassColor()
			if UnitIsPlayer(unit) and UnitIsConnected(unit) and UnitClass(unit) then
				local classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2, UnitClass(unit))]

				if classColor then
					self.name:SetTextColor(classColor.r, classColor.g, classColor.b)
				end
			elseif UnitIsPlayer(unit) and not UnitIsConnected(unit) then
				self.name:SetTextColor(0.5, 0.5, 0.5)
			else
				self.name:SetTextColor(1, 0.82, 0)
			end
		end

		local function ReactionColor()
			local function Color()
				if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
					self.name:SetTextColor(0.5, 0.5, 0.5)
				elseif not UnitIsTapDenied(unit) then
					local reactionColor = FACTION_BAR_COLORS[UnitReaction(unit, "player")]

					if reactionColor then
						self.name:SetTextColor(reactionColor.r, reactionColor.g, reactionColor.b)
					else
						self.name:SetTextColor(1, 0.82, 0)
					end
				end
			end

			if eufCharacterDB.enabled then
				if eufCharacterDB.reactionNameColor and not eufCharacterDB.classNameColor then
					if UnitExists(unit) then
						Color()
					end
				else
					if UnitExists(unit) and not UnitIsPlayer(unit) then
						Color()
					end
				end
			else
				if eufDB.reactionNameColor and not eufDB.classNameColor then
					if UnitExists(unit) then
						Color()
					end
				else
					if UnitExists(unit) and not UnitIsPlayer(unit) then
						Color()
					end
				end
			end
		end

		if eufCharacterDB.enabled then
			if eufCharacterDB.classNameColor then
				ClassColor()
			end

			if eufCharacterDB.reactionNameColor then
				ReactionColor()
			end
		else
			if eufDB.classNameColor then
				ClassColor()
			end

			if eufDB.reactionNameColor then
				ReactionColor()
			end
		end
	end

	hooksecurefunc("UnitFrame_Update", function(self, isParty)
		if self and not self:IsForbidden() then
			NameColor(self, self.unit)
		end
	end)

	-- Changes the unit frame name background color to the unit's class or reaction color.

	function NameBackgroundColor(self, unit)
		local function ClassColor()
			if UnitIsPlayer(unit) and UnitIsConnected(unit) and UnitClass(unit) then
				local classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2, UnitClass(unit))]

				if classColor then
					self.nameBackground:SetVertexColor(classColor.r, classColor.g, classColor.b, 1)
				end
			elseif UnitIsPlayer(unit) and not UnitIsConnected(unit) then
				self.nameBackground:SetVertexColor(0.5, 0.5, 0.5, 1)
			else
				self.nameBackground:SetVertexColor(0, 0, 0, 0)
			end
		end

		local function ReactionColor()
			local function Color()
				if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
					self.nameBackground:SetVertexColor(0.5, 0.5, 0.5, 1)
				elseif not UnitIsTapDenied(unit) then
					local reactionColor = FACTION_BAR_COLORS[UnitReaction(unit, "player")]

					if reactionColor then
						self.nameBackground:SetVertexColor(reactionColor.r, reactionColor.g, reactionColor.b, 1)
					else
						self.nameBackground:SetVertexColor(0, 0, 0, 0)
					end
				end
			end

			if eufCharacterDB.enabled then
				if eufCharacterDB.reactionNameBackgroundColor and not eufCharacterDB.classNameBackgroundColor then
					if UnitExists(unit) then
						Color()
					end
				else
					if UnitExists(unit) and not UnitIsPlayer(unit) then
						Color()
					end
				end
			else
				if eufDB.reactionNameBackgroundColor and not eufDB.classNameBackgroundColor then
					if UnitExists(unit) then
						Color()
					end
				else
					if UnitExists(unit) and not UnitIsPlayer(unit) then
						Color()
					end
				end
			end
		end

		if eufCharacterDB.enabled then
			if eufCharacterDB.classNameBackgroundColor then
				ClassColor()
			end

			if eufCharacterDB.reactionNameBackgroundColor then
				ReactionColor()
			end
		else
			if eufDB.classNameBackgroundColor then
				ClassColor()
			end

			if eufDB.reactionNameBackgroundColor then
				ReactionColor()
			end
		end
	end

	hooksecurefunc("TargetFrame_CheckClassification", function(self, forceNormalTexture)
		NameBackgroundColor(self, self.unit)

		-- Hides the unit frame name background.

		if eufCharacterDB.enabled then
			if eufCharacterDB.hideNameBackground then
				self.nameBackground:SetAlpha(0)
			end
		else
			if eufDB.hideNameBackground then
				self.nameBackground:SetAlpha(0)
			end
		end
	end)

	-- Changes the Shaman class color to reflect live.

	if isClassic() then
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
end
