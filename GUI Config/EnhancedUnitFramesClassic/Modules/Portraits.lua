function ClassIconPortraits()
	if cfg.classIconPortraits then
		-- Changes player portraits to their respective class icons.

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
end
