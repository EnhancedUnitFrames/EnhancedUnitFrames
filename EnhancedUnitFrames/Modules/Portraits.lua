-- Changes the unit frame portraits to the unit's class icon.

function ClassIconPortraits()
	local function Portraits()
		hooksecurefunc("UnitFramePortrait_Update", function(self)
			if self.portrait then
				if UnitIsPlayer(self.unit) then
					local coords = CLASS_ICON_TCOORDS[select(2, UnitClass(self.unit))]

					if coords then
						self.portrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
						self.portrait:SetTexCoord(unpack(coords))
					end
				else
					self.portrait:SetTexCoord(0, 1, 0, 1)
				end
			end
		end)
	end

	if eufCfgCharacter.enabled then
		if eufCfgCharacter.classIconPortraits then
			Portraits()
		end
	else
		if eufCfg.classIconPortraits then
			Portraits()
		end
	end
end
