-- Changes the aura icon sizes and automatically changes their row's width based on the width of the target frame.

function AuraStyling()
	local function Styling()
		local AURA_OFFSET_Y = 3
		local AURA_ROW_WIDTH = 90 + (wideTargetFrameWidth - 230)
		local NUM_TOT_AURA_ROWS = 2

		hooksecurefunc("TargetFrame_UpdateAuraPositions", function(self, auraName, numAuras, numOppositeAuras, largeAuraList, updateFunc, maxRowWidth, offsetX, mirrorAurasVertically)
			local size
			local offsetY = AURA_OFFSET_Y
			local rowWidth = 0
			local firstBuffOnRow = 1
			local maxRowWidth = 90 + (wideTargetFrameWidth - 230)

			for i = 1, numAuras do
				if largeAuraList[i] then
					size = LARGE_AURA_SIZE
					offsetY = AURA_OFFSET_Y + AURA_OFFSET_Y
				else
					size = SMALL_AURA_SIZE
				end

				if i == 1 then
					rowWidth = size
					self.auraRows = self.auraRows + 1
				else
					rowWidth = rowWidth + size + offsetX
				end

				if rowWidth > maxRowWidth then
					updateFunc(self, auraName, i, numOppositeAuras, firstBuffOnRow, size, offsetX, offsetY, mirrorAurasVertically)

					rowWidth = size
					self.auraRows = self.auraRows + 1
					firstBuffOnRow = i
					offsetY = AURA_OFFSET_Y

					if self.auraRows > NUM_TOT_AURA_ROWS then
						maxRowWidth = AURA_ROW_WIDTH
					end
				else
					updateFunc(self, auraName, i, numOppositeAuras, i - 1, size, offsetX, offsetY, mirrorAurasVertically)
				end
			end
		end)
	end

	if cfgCharacter.enabled then
		local LARGE_AURA_SIZE = cfgCharacter.largeAuraIconSize
		local SMALL_AURA_SIZE = cfgCharacter.smallAuraIconSize

		if cfgCharacter.wideTargetFrame and cfgCharacter.wideTargetFrameWidth >= 231 then
			wideTargetFrameWidth = cfgCharacter.wideTargetFrameWidth
		else
			wideTargetFrameWidth = 230
		end

		Styling()
	else
		local LARGE_AURA_SIZE = cfg.largeAuraIconSize
		local SMALL_AURA_SIZE = cfg.smallAuraIconSize

		if cfg.wideTargetFrame and cfg.wideTargetFrameWidth >= 231 then
			wideTargetFrameWidth = cfg.wideTargetFrameWidth
		else
			wideTargetFrameWidth = 230
		end

		Styling()
	end
end
