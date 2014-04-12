-- Focus.lua
-- Written by Snail

function HandleFocus(Self)
	if GetConfiguration().Focus then
		Focus = Self:Spawn("Focus")		
		Focus:SetPoint(GetConfiguration().Focus.Anchor, GetConfiguration().Focus.X, GetConfiguration().Focus.Y)
	end
end
