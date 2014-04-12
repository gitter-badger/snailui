-- Pet.lua
-- Written by Snail

function HandlePet(Self)
	if GetConfiguration().Pet then
		local Pet = Self:Spawn("Pet")
		
		Pet:SetPoint(GetConfiguration().Pet.Anchor, GetConfiguration().Pet.X, GetConfiguration().Pet.Y)
	end
end
