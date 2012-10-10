-- TargetTarget.lua
-- Written by Snail

function HandleTargetTarget(Self)
    if GetConfiguration().TargetTarget then
        local TargetTarget = Self:Spawn("TargetTarget")            
        TargetTarget:SetPoint(GetConfiguration().TargetTarget.Anchor, GetConfiguration().TargetTarget.X, GetConfiguration().TargetTarget.Y)
    end
end
