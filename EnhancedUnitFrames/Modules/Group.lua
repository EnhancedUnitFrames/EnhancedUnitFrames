function GroupStyling()
	-- Styles the party frame.

	for i = 1, 4 do
		_G["PartyMemberFrame" .. i .. "HealthBarText"]:ClearAllPoints()
		_G["PartyMemberFrame" .. i .. "HealthBarText"]:SetPoint("CENTER", _G["PartyMemberFrame" .. i .. "HealthBar"], 0, -0.5)
		_G["PartyMemberFrame" .. i .. "ManaBarText"]:ClearAllPoints()
		_G["PartyMemberFrame" .. i .. "ManaBarText"]:SetPoint("CENTER", _G["PartyMemberFrame" .. i .. "ManaBar"], 0, -0.5)
	end

	-- Hides unit frame realm names and labels.

	hooksecurefunc("CompactUnitFrame_UpdateName", function(self)
		local function Name()
			if self and not self:IsForbidden() then
				local selfName = self:GetName()

				if selfName and selfName:match("^CompactRaidFrame%d") and self.unit and self.name then
					local unitName = GetUnitName(self.unit, true)

					if unitName then
						self.name:SetText(unitName:match("[^-]+"))
					end
				end
			end
		end

		if eufCharacterDB.enabled then
			if eufCharacterDB.hideRealmName then
				Name()
			end
		else
			if eufDB.hideRealmName then
				Name()
			end
		end	
	end)

	hooksecurefunc("UnitFrame_Update", function(self)
		local unitName = GetUnitName(self.unit, true)

		if eufCharacterDB.enabled then
			if eufCharacterDB.hideRealmName then
				if unitName then
					self.name:SetText(unitName:match("[^-]+"))
				end
			end
		else
			if eufDB.hideRealmName then
				if unitName then
					self.name:SetText(unitName:match("[^-]+"))
				end
			end
		end
	end)
end
