-- Target.lua
-- Written by Snail

function HandleTarget(Self)
    if GetConfiguration().Target then
        local Target = Self:Spawn("Target")
        Target:SetPoint(GetConfiguration().Target.Anchor, GetConfiguration().Target.X, GetConfiguration().Target.Y)
    end
end
