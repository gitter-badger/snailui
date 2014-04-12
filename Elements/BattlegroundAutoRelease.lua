-- BattlegroundAutoRelease.lua
-- Written by Snail

function HandleBattlegroundAutoRelease()
	local BattlegroundAutoRelease = CreateFrame("Frame", nil, UIParent)
	
	BattlegroundAutoRelease:RegisterEvent("PLAYER_DEAD")
	BattlegroundAutoRelease:RegisterEvent("PLAYER_ENTERING_WORLD")
	BattlegroundAutoRelease:SetScript("OnEvent",
		function(Self, Event)
			if Event == "PLAYER_DEAD" then
				local InInstance, InstanceType = IsInInstance()

				if InInstance then
					if InstanceType == "pvp" then
						RepopMe()
					end
				end
			else
				if StaticPopup1:IsShown() and ((not UnitIsDead("Player")) or (UnitIsDead("Player") and UnitIsGhost("Player"))) then
					StaticPopup_OnClick(StaticPopup1, StaticPopup1Button1:GetID())
				end
			end
		end
	)
end
