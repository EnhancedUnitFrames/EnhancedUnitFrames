if not cfg.classHealthBarColor and not cfg.reactionHealthBarColor then
	return
end

-- Source: whoa UnitFrames by whoarrior & delabarra.
-- Colors the unit frame health bars based on class or reaction color.

function HealthBarColor(self, unit)
	if cfg.classHealthBarColor then
		if UnitIsPlayer(unit) and UnitIsConnected(unit) and UnitClass(unit) then
			local classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2, UnitClass(self.unit))]

			if classColor then
				self:SetStatusBarColor(classColor.r, classColor.g, classColor.b)
			end
		elseif UnitIsPlayer(unit) and not UnitIsConnected(unit) then
			self:SetStatusBarColor(0.5, 0.5, 0.5)
		else
			self:SetStatusBarColor(0, 0.9, 0)
		end
	end

	if cfg.reactionHealthBarColor then
		if UnitExists(unit) and not UnitIsPlayer(unit) then
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
	end
end

hooksecurefunc("HealthBar_OnValueChanged", function(self)
	HealthBarColor(self, self.unit)
end)

hooksecurefunc("UnitFrameHealthBar_Update", HealthBarColor)
