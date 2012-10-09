-- BattlegroundAutoRelease.lua
-- Written by Snail

function HandleBattlegroundAutoRelease(Self)
    if self.Frame == "Player" then
        Self:RegisterEvent("PLAYER_DEAD",
            local function()
                local InInstance, InstanceType = IsInInstance()

                if InInstance then
                    if InstanceType == "PVP" then
                        RepopMe()
                    end
                end
            end
        )
    end
end
