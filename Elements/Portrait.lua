-- Portrait.lua
-- Written by Snail

function HandlePortrait(Self)
	if GetConfiguration()[Self.Frame].Portrait then
		Self.Portrait = CreateFrame("PlayerModel", nil, Self)
		Self.Portrait:SetPoint(GetConfiguration()[Self.Frame].Portrait.Anchor, GetConfiguration()[Self.Frame].Portrait.X, GetConfiguration()[Self.Frame].Portrait.Y)
		Self.Portrait:SetSize(GetConfiguration()[Self.Frame].Portrait.Width - 3, GetConfiguration()[Self.Frame].Portrait.Height - 3)

		Self.Portrait.Border = Self.Portrait:CreateTexture(nil, "LOW")
		Self.Portrait.Border:SetPoint("TOPLEFT", -1, 1)
		Self.Portrait.Border:SetSize(GetConfiguration()[Self.Frame].Portrait.Width, GetConfiguration()[Self.Frame].Portrait.Height)
		Self.Portrait.Border:SetTexture(0, 0, 0)
	end
end
