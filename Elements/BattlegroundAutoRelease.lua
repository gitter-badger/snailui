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
	end
end
