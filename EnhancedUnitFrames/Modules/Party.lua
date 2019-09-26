-- Styles the party frame.

function PartyFrameStyling()
	for i = 1, 4 do
		_G["PartyMemberFrame" .. i .. "HealthBarText"]:ClearAllPoints()
		_G["PartyMemberFrame" .. i .. "HealthBarText"]:SetPoint("CENTER", _G["PartyMemberFrame" .. i .. "HealthBar"], 0, -0.5)
		_G["PartyMemberFrame" .. i .. "ManaBarText"]:ClearAllPoints()
		_G["PartyMemberFrame" .. i .. "ManaBarText"]:SetPoint("CENTER", _G["PartyMemberFrame" .. i .. "ManaBar"], 0, -0.5)
	end
end
