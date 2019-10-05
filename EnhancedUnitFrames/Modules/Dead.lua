-- Function that changes various elements if the unit is dead or a ghost.

function isDeadOrGhost()
	if not isClassic() then
		-- Changes the boss dead text and hides the boss unit frame health and mana bars when the unit is dead or a ghost.

		if UnitExists("boss1") and UnitIsDead("boss1") then
			if eufCharacterDB.enabled then
				if eufCharacterDB.statusTextBoth then
					Boss1TargetFrameTextureFrameHealthBarText:Show()
				end
			else
				if eufDB.statusTextBoth then
					Boss1TargetFrameTextureFrameHealthBarText:Show()
				end
			end

			if UnitIsDead("boss1") then
				Boss1TargetFrameTextureFrameHealthBarText:SetText("Dead")
			elseif UnitIsGhost("focus") then
				Boss1TargetFrameTextureFrameHealthBarText:SetText("Ghost")
			end

			Boss1TargetFrameHealthBar:SetAlpha(0)
			Boss1TargetFrameManaBar:SetAlpha(0)
			Boss1TargetFrameTextureFrameHealthBarText:SetFontObject(GameFontNormalSmall)
			Boss1TargetFrameTextureFrameHealthBarText:SetShadowOffset(1, -1)
			Boss1TargetFrameTextureFrameHealthBarTextLeft:SetAlpha(0)
			Boss1TargetFrameTextureFrameHealthBarTextRight:SetAlpha(0)
			Boss1TargetFrameTextureFrameManaBarText:SetAlpha(0)
			Boss1TargetFrameTextureFrameManaBarTextLeft:SetAlpha(0)
			Boss1TargetFrameTextureFrameManaBarTextRight:SetAlpha(0)

			Boss1DeadTextColor()
		elseif UnitExists("boss1") and not UnitIsDead("boss1") then
			if eufCharacterDB.enabled then
				if eufCharacterDB.hideFocusStatusText then
					HideBossStatusText()
				else
					ShowBossStatusText()
				end
			else
				if eufDB.hideFocusStatusText then
					HideBossStatusText()
				else
					ShowBossStatusText()
				end
			end

			Boss1TargetFrameHealthBar:SetAlpha(1)
			Boss1TargetFrameManaBar:SetAlpha(1)
			Boss1TargetFrameTextureFrameHealthBarText:SetFontObject(TextStatusBarText)
			Boss1TargetFrameTextureFrameHealthBarText:SetShadowOffset(0, 999999)
			Boss1TargetFrameTextureFrameHealthBarText:SetTextColor(1, 1, 1)
		end

		if UnitExists("boss2") and UnitIsDead("boss2") then
			if eufCharacterDB.enabled then
				if eufCharacterDB.statusTextBoth then
					Boss2TargetFrameTextureFrameHealthBarText:Show()
				end
			else
				if eufDB.statusTextBoth then
					Boss2TargetFrameTextureFrameHealthBarText:Show()
				end
			end

			if UnitIsDead("boss2") then
				Boss2TargetFrameTextureFrameHealthBarText:SetText("Dead")
			elseif UnitIsGhost("focus") then
				Boss2TargetFrameTextureFrameHealthBarText:SetText("Ghost")
			end

			Boss2TargetFrameHealthBar:SetAlpha(0)
			Boss2TargetFrameManaBar:SetAlpha(0)
			Boss2TargetFrameTextureFrameHealthBarText:SetFontObject(GameFontNormalSmall)
			Boss2TargetFrameTextureFrameHealthBarText:SetShadowOffset(1, -1)
			Boss2TargetFrameTextureFrameHealthBarTextLeft:SetAlpha(0)
			Boss2TargetFrameTextureFrameHealthBarTextRight:SetAlpha(0)
			Boss2TargetFrameTextureFrameManaBarText:SetAlpha(0)
			Boss2TargetFrameTextureFrameManaBarTextLeft:SetAlpha(0)
			Boss2TargetFrameTextureFrameManaBarTextRight:SetAlpha(0)

			Boss2DeadTextColor()
		elseif UnitExists("boss2") and not UnitIsDead("boss2") then
			if eufCharacterDB.enabled then
				if eufCharacterDB.hideFocusStatusText then
					HideBossStatusText()
				else
					ShowBossStatusText()
				end
			else
				if eufDB.hideFocusStatusText then
					HideBossStatusText()
				else
					ShowBossStatusText()
				end
			end

			Boss2TargetFrameHealthBar:SetAlpha(1)
			Boss2TargetFrameManaBar:SetAlpha(1)
			Boss2TargetFrameTextureFrameHealthBarText:SetFontObject(TextStatusBarText)
			Boss2TargetFrameTextureFrameHealthBarText:SetShadowOffset(0, 999999)
			Boss2TargetFrameTextureFrameHealthBarText:SetTextColor(1, 1, 1)
		end

		if UnitExists("boss3") and UnitIsDead("boss3") then
			if eufCharacterDB.enabled then
				if eufCharacterDB.statusTextBoth then
					Boss3TargetFrameTextureFrameHealthBarText:Show()
				end
			else
				if eufDB.statusTextBoth then
					Boss3TargetFrameTextureFrameHealthBarText:Show()
				end
			end

			if UnitIsDead("boss3") then
				Boss3TargetFrameTextureFrameHealthBarText:SetText("Dead")
			elseif UnitIsGhost("focus") then
				Boss3TargetFrameTextureFrameHealthBarText:SetText("Ghost")
			end

			Boss3TargetFrameHealthBar:SetAlpha(0)
			Boss3TargetFrameManaBar:SetAlpha(0)
			Boss3TargetFrameTextureFrameHealthBarText:SetFontObject(GameFontNormalSmall)
			Boss3TargetFrameTextureFrameHealthBarText:SetShadowOffset(1, -1)
			Boss3TargetFrameTextureFrameHealthBarTextLeft:SetAlpha(0)
			Boss3TargetFrameTextureFrameHealthBarTextRight:SetAlpha(0)
			Boss3TargetFrameTextureFrameManaBarText:SetAlpha(0)
			Boss3TargetFrameTextureFrameManaBarTextLeft:SetAlpha(0)
			Boss3TargetFrameTextureFrameManaBarTextRight:SetAlpha(0)

			Boss3DeadTextColor()
		elseif UnitExists("boss3") and not UnitIsDead("boss3") then
			if eufCharacterDB.enabled then
				if eufCharacterDB.hideFocusStatusText then
					HideBossStatusText()
				else
					ShowBossStatusText()
				end
			else
				if eufDB.hideFocusStatusText then
					HideBossStatusText()
				else
					ShowBossStatusText()
				end
			end

			Boss3TargetFrameHealthBar:SetAlpha(1)
			Boss3TargetFrameManaBar:SetAlpha(1)
			Boss3TargetFrameTextureFrameHealthBarText:SetFontObject(TextStatusBarText)
			Boss3TargetFrameTextureFrameHealthBarText:SetShadowOffset(0, 999999)
			Boss3TargetFrameTextureFrameHealthBarText:SetTextColor(1, 1, 1)
		end

		if UnitExists("boss4") and UnitIsDead("boss4") then
			if eufCharacterDB.enabled then
				if eufCharacterDB.statusTextBoth then
					Boss4TargetFrameTextureFrameHealthBarText:Show()
				end
			else
				if eufDB.statusTextBoth then
					Boss4TargetFrameTextureFrameHealthBarText:Show()
				end
			end

			if UnitIsDead("boss4") then
				Boss4TargetFrameTextureFrameHealthBarText:SetText("Dead")
			elseif UnitIsGhost("focus") then
				Boss4TargetFrameTextureFrameHealthBarText:SetText("Ghost")
			end

			Boss4TargetFrameHealthBar:SetAlpha(0)
			Boss4TargetFrameManaBar:SetAlpha(0)
			Boss4TargetFrameTextureFrameHealthBarText:SetFontObject(GameFontNormalSmall)
			Boss4TargetFrameTextureFrameHealthBarText:SetShadowOffset(1, -1)
			Boss4TargetFrameTextureFrameHealthBarTextLeft:SetAlpha(0)
			Boss4TargetFrameTextureFrameHealthBarTextRight:SetAlpha(0)
			Boss4TargetFrameTextureFrameManaBarText:SetAlpha(0)
			Boss4TargetFrameTextureFrameManaBarTextLeft:SetAlpha(0)
			Boss4TargetFrameTextureFrameManaBarTextRight:SetAlpha(0)

			Boss4DeadTextColor()
		elseif UnitExists("boss4") and not UnitIsDead("boss4") then
			if eufCharacterDB.enabled then
				if eufCharacterDB.hideFocusStatusText then
					HideBossStatusText()
				else
					ShowBossStatusText()
				end
			else
				if eufDB.hideFocusStatusText then
					HideBossStatusText()
				else
					ShowBossStatusText()
				end
			end

			Boss4TargetFrameHealthBar:SetAlpha(1)
			Boss4TargetFrameManaBar:SetAlpha(1)
			Boss4TargetFrameTextureFrameHealthBarText:SetFontObject(TextStatusBarText)
			Boss4TargetFrameTextureFrameHealthBarText:SetShadowOffset(0, 999999)
			Boss4TargetFrameTextureFrameHealthBarText:SetTextColor(1, 1, 1)
		end

		if UnitExists("boss5") and UnitIsDead("boss5") then
			if eufCharacterDB.enabled then
				if eufCharacterDB.statusTextBoth then
					Boss5TargetFrameTextureFrameHealthBarText:Show()
				end
			else
				if eufDB.statusTextBoth then
					Boss5TargetFrameTextureFrameHealthBarText:Show()
				end
			end

			if UnitIsDead("boss5") then
				Boss5TargetFrameTextureFrameHealthBarText:SetText("Dead")
			elseif UnitIsGhost("focus") then
				Boss5TargetFrameTextureFrameHealthBarText:SetText("Ghost")
			end

			Boss5TargetFrameHealthBar:SetAlpha(0)
			Boss5TargetFrameManaBar:SetAlpha(0)
			Boss5TargetFrameTextureFrameHealthBarText:SetFontObject(GameFontNormalSmall)
			Boss5TargetFrameTextureFrameHealthBarText:SetShadowOffset(1, -1)
			Boss5TargetFrameTextureFrameHealthBarTextLeft:SetAlpha(0)
			Boss5TargetFrameTextureFrameHealthBarTextRight:SetAlpha(0)
			Boss5TargetFrameTextureFrameManaBarText:SetAlpha(0)
			Boss5TargetFrameTextureFrameManaBarTextLeft:SetAlpha(0)
			Boss5TargetFrameTextureFrameManaBarTextRight:SetAlpha(0)

			Boss5DeadTextColor()
		elseif UnitExists("boss5") and not UnitIsDead("boss5") then
			if eufCharacterDB.enabled then
				if eufCharacterDB.hideFocusStatusText then
					HideBossStatusText()
				else
					ShowBossStatusText()
				end
			else
				if eufDB.hideFocusStatusText then
					HideBossStatusText()
				else
					ShowBossStatusText()
				end
			end

			Boss5TargetFrameHealthBar:SetAlpha(1)
			Boss5TargetFrameManaBar:SetAlpha(1)
			Boss5TargetFrameTextureFrameHealthBarText:SetFontObject(TextStatusBarText)
			Boss5TargetFrameTextureFrameHealthBarText:SetShadowOffset(0, 999999)
			Boss5TargetFrameTextureFrameHealthBarText:SetTextColor(1, 1, 1)
		end

		-- Changes the focus dead text and hides the focus unit frame health and mana bar when the unit is dead or a ghost.

		if UnitIsDead("focus") or UnitIsGhost("focus") then
			if eufCharacterDB.enabled then
				if eufCharacterDB.statusTextBoth then
					FocusFrameHealthBar.TextString:Show()
				end
			else
				if eufDB.statusTextBoth then
					FocusFrameHealthBar.TextString:Show()
				end
			end

			if UnitIsDead("focus") then
				FocusFrameHealthBar.TextString:SetText("Dead")
			elseif UnitIsGhost("focus") then
				FocusFrameHealthBar.TextString:SetText("Ghost")
			end

			FocusFrameHealthBar:SetAlpha(0)
			FocusFrameHealthBar.LeftText:SetAlpha(0)
			FocusFrameHealthBar.RightText:SetAlpha(0)
			FocusFrameHealthBar.TextString:SetAlpha(1)
			FocusFrameHealthBar.TextString:SetFontObject(GameFontNormalSmall)
			FocusFrameHealthBar.TextString:SetShadowOffset(1, -1)
			FocusFrameManaBar:SetAlpha(0)
			FocusFrameManaBar.LeftText:SetAlpha(0)
			FocusFrameManaBar.RightText:SetAlpha(0)
			FocusFrameManaBar.TextString:SetAlpha(0)

			FocusDeadTextColor()
		elseif not UnitIsDead("focus") or not UnitIsGhost("focus") then
			if eufCharacterDB.enabled then
				if eufCharacterDB.hideFocusStatusText then
					HideFocusStatusText()
				else
					ShowFocusStatusText()
				end
			else
				if eufDB.hideFocusStatusText then
					HideFocusStatusText()
				else
					ShowFocusStatusText()
				end
			end

			FocusFrameHealthBar:SetAlpha(1)
			FocusFrameHealthBar.TextString:SetFontObject(TextStatusBarText)
			FocusFrameHealthBar.TextString:SetShadowOffset(0, 999999)
			FocusFrameHealthBar.TextString:SetTextColor(1, 1, 1)
			FocusFrameManaBar:SetAlpha(1)
		end
	end

	-- Hides the party unit frame health and mana bars when the unit is dead or a ghost.

	if UnitIsDead("party1") or UnitIsGhost("party1") then
		if not isClassic() then
			PartyMemberFrame1HealthBarText:SetAlpha(0)
			PartyMemberFrame1ManaBarText:SetAlpha(0)
		end

		PartyMemberFrame1HealthBar:SetAlpha(0)
		PartyMemberFrame1ManaBar:SetAlpha(0)
	elseif not UnitIsDead("party1") or not UnitIsGhost("party1") then
		if not isClassic() then
			PartyMemberFrame1HealthBarText:SetAlpha(1)
			PartyMemberFrame1ManaBarText:SetAlpha(1)
		end

		PartyMemberFrame1HealthBar:SetAlpha(1)
		PartyMemberFrame1ManaBar:SetAlpha(1)
	end

	if UnitIsDead("party2") or UnitIsGhost("party2") then
		if not isClassic() then
			PartyMemberFrame2HealthBarText:SetAlpha(0)
			PartyMemberFrame2ManaBarText:SetAlpha(0)
		end

		PartyMemberFrame2HealthBar:SetAlpha(0)
		PartyMemberFrame2ManaBar:SetAlpha(0)
	elseif not UnitIsDead("party2") or not UnitIsGhost("party2") then
		if not isClassic() then
			PartyMemberFrame2HealthBarText:SetAlpha(1)
			PartyMemberFrame2ManaBarText:SetAlpha(1)
		end

		PartyMemberFrame2HealthBar:SetAlpha(1)
		PartyMemberFrame2ManaBar:SetAlpha(1)
	end

	if UnitIsDead("party3") or UnitIsGhost("party3") then
		if not isClassic() then
			PartyMemberFrame3HealthBarText:SetAlpha(0)
			PartyMemberFrame3ManaBarText:SetAlpha(0)
		end

		PartyMemberFrame3HealthBar:SetAlpha(0)
		PartyMemberFrame3ManaBar:SetAlpha(0)
	elseif not UnitIsDead("party3") or not UnitIsGhost("party3") then
		if not isClassic() then
			PartyMemberFrame3HealthBarText:SetAlpha(1)
			PartyMemberFrame3ManaBarText:SetAlpha(1)
		end

		PartyMemberFrame3HealthBar:SetAlpha(1)
		PartyMemberFrame3ManaBar:SetAlpha(1)
	end

	if UnitIsDead("party4") or UnitIsGhost("party4") then
		if not isClassic() then
			PartyMemberFrame4HealthBarText:SetAlpha(0)
			PartyMemberFrame4ManaBarText:SetAlpha(0)
		end

		PartyMemberFrame4HealthBar:SetAlpha(0)
		PartyMemberFrame4ManaBar:SetAlpha(0)
	elseif not UnitIsDead("party4") or not UnitIsGhost("party4") then
		if not isClassic() then
			PartyMemberFrame4HealthBarText:SetAlpha(1)
			PartyMemberFrame4ManaBarText:SetAlpha(1)
		end

		PartyMemberFrame4HealthBar:SetAlpha(1)
		PartyMemberFrame4ManaBar:SetAlpha(1)
	end

	-- Adds player dead text and hides the player unit frame health and mana bar when the player is dead or a ghost.

	if UnitIsDead("player") or UnitIsGhost("player") then
		if eufCharacterDB.enabled then
			if eufCharacterDB.statusTextBoth then
				PlayerFrameHealthBar.TextString:Show()
			end
		else
			if eufDB.statusTextBoth then
				PlayerFrameHealthBar.TextString:Show()
			end
		end

		if UnitIsDead("player") then
			PlayerFrameHealthBar.TextString:SetText("Dead")
		elseif UnitIsGhost("player") then
			PlayerFrameHealthBar.TextString:SetText("Ghost")
		end

		if isClassic() then
			PlayerFrameAlternatePowerBar:SetAlpha(0)
		else
			PlayerFrameAlternateManaBar:SetAlpha(0)
		end

		PlayerFrameHealthBar:SetAlpha(0)
		PlayerFrameHealthBar.LeftText:SetAlpha(0)
		PlayerFrameHealthBar.RightText:SetAlpha(0)
		PlayerFrameHealthBar.TextString:SetAlpha(1)
		PlayerFrameHealthBar.TextString:SetFontObject(GameFontNormalSmall)
		PlayerFrameHealthBar.TextString:SetShadowOffset(1, -1)

		if isClassic() then
			if eufCharacterDB.enabled then
				if eufCharacterDB.classDeadTextColor or eufCharacterDB.reactionDeadTextColor then
					PlayerDeadTextColor()
				else
					PlayerFrameHealthBar.TextString:SetTextColor(1, 0.82, 0)
				end
			else
				if eufDB.classDeadTextColor or eufDB.reactionDeadTextColor then
					PlayerDeadTextColor()
				else
					PlayerFrameHealthBar.TextString:SetTextColor(1, 0.82, 0)
				end
			end
		else
			PlayerDeadTextColor()
		end

		PlayerFrameManaBar:SetAlpha(0)
		PlayerFrameManaBar.LeftText:SetAlpha(0)
		PlayerFrameManaBar.RightText:SetAlpha(0)
		PlayerFrameManaBar.TextString:SetAlpha(0)
	elseif not UnitIsDead("player") or not UnitIsGhost("player") then
		if eufCharacterDB.enabled then
			if eufCharacterDB.hidePlayerStatusText then
				HidePlayerStatusText()
			else
				ShowPlayerStatusText()
			end
		else
			if eufDB.hidePlayerStatusText then
				HidePlayerStatusText()
			else
				ShowPlayerStatusText()
			end
		end

		if isClassic() then
			PlayerFrameAlternatePowerBar:SetAlpha(1)
			PlayerFrameHealthBar.TextString:SetFontObject(SystemFont_Outline_Small)
		else
			PlayerFrameAlternateManaBar:SetAlpha(1)
			PlayerFrameHealthBar.TextString:SetFontObject(TextStatusBarText)
		end

		PlayerFrameHealthBar:SetAlpha(1)
		PlayerFrameHealthBar.TextString:SetShadowOffset(0, 999999)
		PlayerFrameHealthBar.TextString:SetTextColor(1, 1, 1)
		PlayerFrameManaBar:SetAlpha(1)
	end

	-- Changes the target dead text and hides the target unit frame health and mana bar when the unit is dead or a ghost.

	if UnitIsDead("target") or UnitIsGhost("target") then
		if eufCharacterDB.enabled then
			if eufCharacterDB.statusTextBoth then
				TargetFrameHealthBar.TextString:Show()
			end
		else
			if eufDB.statusTextBoth then
				TargetFrameHealthBar.TextString:Show()
			end
		end

		if UnitIsDead("target") then
			TargetFrameHealthBar.TextString:SetText("Dead")
		elseif UnitIsGhost("target") then
			TargetFrameHealthBar.TextString:SetText("Ghost")
		end

		TargetFrameHealthBar:SetAlpha(0)
		TargetFrameHealthBar.LeftText:SetAlpha(0)
		TargetFrameHealthBar.RightText:SetAlpha(0)
		TargetFrameHealthBar.TextString:SetAlpha(1)
		TargetFrameHealthBar.TextString:SetFontObject(GameFontNormalSmall)
		TargetFrameHealthBar.TextString:SetShadowOffset(1, -1)

		if isClassic() then
			if eufCharacterDB.enabled then
				if eufCharacterDB.classDeadTextColor or eufCharacterDB.reactionDeadTextColor then
					TargetDeadTextColor()
				else
					TargetFrameHealthBar.TextString:SetTextColor(1, 0.82, 0)
				end
			else
				if eufDB.classDeadTextColor or eufDB.reactionDeadTextColor then
					TargetDeadTextColor()
				else
					TargetFrameHealthBar.TextString:SetTextColor(1, 0.82, 0)
				end
			end
		else
			TargetDeadTextColor()
		end

		TargetFrameManaBar:SetAlpha(0)
		TargetFrameManaBar.LeftText:SetAlpha(0)
		TargetFrameManaBar.RightText:SetAlpha(0)
		TargetFrameManaBar.TextString:SetAlpha(0)
	elseif not UnitIsDead("target") or not UnitIsGhost("target") then
		if eufCharacterDB.enabled then
			if eufCharacterDB.hideTargetStatusText then
				HideTargetStatusText()
			else
				ShowTargetStatusText()
			end
		else
			if eufDB.hideTargetStatusText then
				HideTargetStatusText()
			else
				ShowTargetStatusText()
			end
		end

		if isClassic() then
			TargetFrameHealthBar.TextString:SetFontObject(SystemFont_Outline_Small)
		else
			TargetFrameHealthBar.TextString:SetFontObject(TextStatusBarText)
		end

		TargetFrameHealthBar:SetAlpha(1)
		TargetFrameHealthBar.TextString:SetShadowOffset(0, 999999)
		TargetFrameHealthBar.TextString:SetTextColor(1, 1, 1)
		TargetFrameManaBar:SetAlpha(1)
	end

	if not isClassic() then
		if UnitIsDead("focustarget") or UnitIsGhost("focustarget") then
			FocusFrameToT.healthbar:SetAlpha(0)
			FocusFrameToT.manabar:SetAlpha(0)
		elseif not UnitIsDead("focustarget") or not UnitIsGhost("focustarget") then
			FocusFrameToT.healthbar:SetAlpha(1)
			FocusFrameToT.manabar:SetAlpha(1)
		end
	end

	if UnitIsDead("targettarget") or UnitIsGhost("targettarget") then
		TargetFrameToT.healthbar:SetAlpha(0)
		TargetFrameToT.manabar:SetAlpha(0)
	elseif not UnitIsDead("targettarget") or not UnitIsGhost("targettarget") then
		TargetFrameToT.healthbar:SetAlpha(1)
		TargetFrameToT.manabar:SetAlpha(1)
	end
end
