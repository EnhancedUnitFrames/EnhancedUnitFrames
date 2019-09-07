﻿function MirroredPositioning()
	-- Source: Focused by haggen.
	-- Allows the easy mirrored positioning of the player and target frames to desirable locations.

	if cfg.mirroredPositioning then

		local function SetMirroredPlayerPosition(a, b)
			local _, _, _, offsetX, offsetY = b:GetPoint(1)
			local mirroredOffsetX = GetScreenWidth() - offsetX - b:GetWidth()

			a:ClearAllPoints()
			a:SetPoint("TOPLEFT", nil, "TOPLEFT", mirroredOffsetX, offsetY)
		end

		local function SetMirroredTargetPosition(a, b)
			local _, _, _, offsetX, offsetY = b:GetPoint(1)
			local mirroredOffsetX = GetScreenWidth() - offsetX - a:GetWidth()

			a:ClearAllPoints()
			a:SetPoint("TOPLEFT", nil, "TOPLEFT", mirroredOffsetX, offsetY)
		end

		local initialPositionPoint = {
			[PlayerFrame] = "RIGHT",
			[TargetFrame] = "LEFT"
		}

		local function SetInitialPosition(frame)
			frame:SetUserPlaced(true)
			frame:ClearAllPoints()
			frame:SetPoint(initialPositionPoint[frame], UIParent, "CENTER")
		end

		hooksecurefunc("TargetFrame_ResetUserPlacedPosition", function(...)
			SetInitialPosition(TargetFrame)

			if PlayerFrame:IsUserPlaced() then
				SetInitialPosition(PlayerFrame)
			end
		end)

		hooksecurefunc("PlayerFrame_ResetUserPlacedPosition", function(...)
			SetInitialPosition(PlayerFrame)

			if TargetFrame:IsUserPlaced() then
				SetInitialPosition(TargetFrame)
			end
		end)

		if not PlayerFrame:IsUserPlaced() then
			SetInitialPosition(PlayerFrame)
		end

		if not TargetFrame:IsUserPlaced() then
			SetInitialPosition(TargetFrame)
		end

		local function FocusedFrame_OnUpdate(self, elapsed)
			if PlayerFrame:IsDragging() then
				SetMirroredPlayerPosition(TargetFrame, PlayerFrame)
			elseif TargetFrame:IsDragging() then
				SetMirroredTargetPosition(PlayerFrame, TargetFrame)
			end
		end

		local FocusedFrame = CreateFrame("Frame")

		FocusedFrame:SetScript("OnUpdate", FocusedFrame_OnUpdate)
	end
end
