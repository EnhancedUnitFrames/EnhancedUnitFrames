local _, cfg = ...

-- Source: whoa UnitFrames by whoarrior & delabarra.
-- Makes the focus and target auras bigger.

if cfg.wideTargetFrames and cfg.wideTargetFramesWidth >= 231 then
	wideTargetFramesWidth = cfg.wideTargetFramesWidth
else
	wideTargetFramesWidth = 230
end

local LARGE_AURA_SIZE = cfg.largeAuraIconSize
local SMALL_AURA_SIZE = cfg.smallAuraIconSize
local AURA_OFFSET_Y = 3
local AURA_ROW_WIDTH = 140
local AURA_ROW_WIDTH = 90 + (wideTargetFramesWidth - 230)
local NUM_TOT_AURA_ROWS = 2

hooksecurefunc("TargetFrame_UpdateAuraPositions", function(self, auraName, numAuras, numOppositeAuras, largeAuraList, updateFunc, maxRowWidth, offsetX, mirrorAurasVertically)
	local size
	local offsetY = AURA_OFFSET_Y
	local rowWidth = 0
	local firstBuffOnRow = 1
	local maxRowWidth = 90 + (wideTargetFramesWidth - 230)

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
