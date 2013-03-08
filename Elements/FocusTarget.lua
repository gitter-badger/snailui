-- FocusTarget.lua
-- Written by Snail

function HandleFocusTarget(Self)
	if GetConfiguration().FocusTarget then
		local FocusTarget = Self:Spawn("FocusTarget")
		
		FocusTarget:SetPoint(GetConfiguration().FocusTarget.Anchor, GetConfiguration().FocusTarget.X, GetConfiguration().FocusTarget.Y)
	end
end
