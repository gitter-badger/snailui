-- BattlegroundAutoRelease.lua
-- Written by Snail

function HandleBattlegroundAutoRelease(Self)
	if Self.Frame == "Player" then
		Self:RegisterEvent("PLAYER_DEAD",
			function()
				local InInstance, InstanceType = IsInInstance()

				if InInstance then
					if InstanceType == "pvp" then
						RepopMe()
					end
				end
			end
		)

		Self:RegisterEvent("PLAYER_ENTERING_WORLD",
			function()
				if StaticPopup1:IsShown() and ((not UnitIsDead("Player")) or (UnitIsDead("Player") and UnitIsGhost("Player"))) then
					StaticPopup_OnClick(StaticPopup1, StaticPopup1Button1:GetID())
				end
			end
		)
	end
end
