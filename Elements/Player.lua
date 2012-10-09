-- Player.lua
-- Written by Snail

function HandlePlayer()
    if GetConfiguration().Player then
        local Player = Self:Spawn("Player")
        Player:SetPoint(GetConfiguration().Player.Anchor, GetConfiguration().Player.X, GetConfiguration().Player.Y)
    end
end
