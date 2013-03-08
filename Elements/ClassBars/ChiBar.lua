-- ChiBar.lua
-- Written by Snail

function HandleChiBar(Self)
	local Class = select(2, UnitClass(Self.Frame))

	if GetConfiguration()[Self.Frame].ChiBar and (Self.Frame == "Player") and (Class == "MONK") then
		Self.ClassIcons = Self:CreateTexture(Self, "BACKGROUND")
		Self.ClassIcons:SetPoint(GetConfiguration()[Self.Frame].ChiBar.Anchor, GetConfiguration()[Self.Frame].ChiBar.X, GetConfiguration()[Self.Frame].ChiBar.Y)
		Self.ClassIcons:SetSize(GetConfiguration()[Self.Frame].ChiBar.Width, GetConfiguration()[Self.Frame].ChiBar.Height)
		Self.ClassIcons:SetTexture(0, 0, 0)

		Self.ClassIcons.Background = Self:CreateTexture(nil, "BACKGROUND")
		Self.ClassIcons.Background:SetPoint("TOPLEFT", Self.ClassIcons, 1, -1)
		Self.ClassIcons.Background:SetSize(GetConfiguration()[Self.Frame].ChiBar.Width - 2, GetConfiguration()[Self.Frame].ChiBar.Height - 2)

		for I = 1, 5 do
			Self.ClassIcons[I] = Self:CreateTexture(Self, "LOW")

			if I <= #GetConfiguration()[Self.Frame].ChiBar then
				Self.ClassIcons[I]:SetPoint(GetConfiguration()[Self.Frame].ChiBar[I].Anchor, Self.ClassIcons, GetConfiguration()[Self.Frame].ChiBar[I].X, GetConfiguration()[Self.Frame].ChiBar[I].Y)
				Self.ClassIcons[I]:SetSize(GetConfiguration()[Self.Frame].ChiBar[I].Width - 2, GetConfiguration()[Self.Frame].ChiBar[I].Height - 2)
				Self.ClassIcons[I]:SetTexture(Configuration.Texture)

				Self.ClassIcons[I].Border = Self:CreateTexture(nil, "LOW")
				Self.ClassIcons[I].Border:SetPoint("TOPLEFT", Self.ClassIcons[I], -1, 1)
				Self.ClassIcons[I].Border:SetSize(GetConfiguration()[Self.Frame].ChiBar[I].Width, GetConfiguration()[Self.Frame].ChiBar[I].Height)
				Self.ClassIcons[I].Border:SetTexture(0, 0, 0)
			end
		end
	end
end
