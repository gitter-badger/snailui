-- HolyPowerBar.lua
-- Written by Snail

function HandleHolyPowerBar(Self)
	local Class = select(2, UnitClass(Self.Frame))

	if GetConfiguration()[Self.Frame].HolyPowerBar and (Self.Frame == "Player") and (Class == "PALADIN") then
		Self.ClassIcons = Self:CreateTexture(Self, "BACKGROUND")
		Self.ClassIcons:SetSize(GetConfiguration()[Self.Frame].HolyPowerBar.Width, GetConfiguration()[Self.Frame].HolyPowerBar.Height)
		Self.ClassIcons:SetTexture(0, 0, 0)

		if GetConfiguration()[Self.Frame].HolyPowerBar.Parent then
			Self.ClassIcons:SetPoint(GetConfiguration()[Self.Frame].HolyPowerBar.Anchor, GetConfiguration()[Self.Frame].HolyPowerBar.Parent, GetConfiguration()[Self.Frame].HolyPowerBar.X, GetConfiguration()[Self.Frame].HolyPowerBar.Y)
		else
			Self.ClassIcons:SetPoint(GetConfiguration()[Self.Frame].HolyPowerBar.Anchor, GetConfiguration()[Self.Frame].HolyPowerBar.X, GetConfiguration()[Self.Frame].HolyPowerBar.Y)
		end

		Self.ClassIcons.Background = Self:CreateTexture(nil, "BACKGROUND")
		Self.ClassIcons.Background:SetPoint("TOPLEFT", Self.ClassIcons, 1, -1)
		Self.ClassIcons.Background:SetSize(GetConfiguration()[Self.Frame].HolyPowerBar.Width - 2, GetConfiguration()[Self.Frame].HolyPowerBar.Height - 2)

		for I = 1, 5 do
			Self.ClassIcons[I] = Self:CreateTexture(Self, "LOW")

			if I <= #GetConfiguration()[Self.Frame].HolyPowerBar then
				Self.ClassIcons[I]:SetPoint(GetConfiguration()[Self.Frame].HolyPowerBar[I].Anchor, Self.ClassIcons, GetConfiguration()[Self.Frame].HolyPowerBar[I].X, GetConfiguration()[Self.Frame].HolyPowerBar[I].Y)
				Self.ClassIcons[I]:SetSize(GetConfiguration()[Self.Frame].HolyPowerBar[I].Width - 2, GetConfiguration()[Self.Frame].HolyPowerBar[I].Height - 2)
				Self.ClassIcons[I]:SetTexture(Configuration.Texture)

				Self.ClassIcons[I].Border = Self:CreateTexture(nil, "LOW")
				Self.ClassIcons[I].Border:SetPoint("TOPLEFT", Self.ClassIcons[I], -1, 1)
				Self.ClassIcons[I].Border:SetSize(GetConfiguration()[Self.Frame].HolyPowerBar[I].Width, GetConfiguration()[Self.Frame].HolyPowerBar[I].Height)
				Self.ClassIcons[I].Border:SetTexture(0, 0, 0)
			end
		end
	end
end
