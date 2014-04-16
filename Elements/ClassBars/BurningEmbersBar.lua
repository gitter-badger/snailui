-- BurningEmbersBar.lua
-- Written by Snail

function HandleBurningEmbersBar(Self)
	local Class = select(2, UnitClass(Self.Frame))
	local Specialization = GetSpecialization()

	if Specialization then
		Specialization = select(2, GetSpecializationInfo(Specialization))
		Specialization = Specialization:gsub("(.)", string.upper)
	end

	if GetConfiguration()[Self.Frame].BurningEmbersBar and (Self.Frame == "Player") and (Class == "WARLOCK") and (Specialization == "DESTRUCTION") then
		Self.WarlockSpecBars = CreateFrame("Frame", nil, Self)
		Self.WarlockSpecBars:SetSize(GetConfiguration()[Self.Frame].BurningEmbersBar.Width - 2, GetConfiguration()[Self.Frame].BurningEmbersBar.Height - 2)

		if GetConfiguration()[Self.Frame].BurningEmbersBar.Parent then
			Self.WarlockSpecBars:SetPoint(GetConfiguration()[Self.Frame].BurningEmbersBar.Anchor, GetConfiguration()[Self.Frame].BurningEmbersBar.Parent, GetConfiguration()[Self.Frame].BurningEmbersBar.X, GetConfiguration()[Self.Frame].BurningEmbersBar.Y)
		else
			Self.WarlockSpecBars:SetPoint(GetConfiguration()[Self.Frame].BurningEmbersBar.Anchor, GetConfiguration()[Self.Frame].BurningEmbersBar.X, GetConfiguration()[Self.Frame].BurningEmbersBar.Y)
		end

		Self.warlockSpecBarsBackground = Self:CreateTexture(nil, "BACKGROUND")
		Self.warlockSpecBarsBackground:SetPoint("TOPLEFT", Self.WarlockSpecBars)
		Self.warlockSpecBarsBackground:SetSize(GetConfiguration()[Self.Frame].BurningEmbersBar.Width - 2, GetConfiguration()[Self.Frame].BurningEmbersBar.Height - 2)

		Self.warlockSpecBarsBorder = Self:CreateTexture(nil, "BACKGROUND")
		Self.warlockSpecBarsBorder:SetPoint("TOPLEFT", Self.WarlockSpecBars, -1, 1)
		Self.warlockSpecBarsBorder:SetSize(GetConfiguration()[Self.Frame].BurningEmbersBar.Width, GetConfiguration()[Self.Frame].BurningEmbersBar.Height)
		Self.warlockSpecBarsBorder:SetTexture(0, 0, 0)

		for I = 1, #GetConfiguration()[Self.Frame].BurningEmbersBar do
			Self.WarlockSpecBars[I] = CreateFrame("StatusBar", nil, Self)
			Self.WarlockSpecBars[I]:SetPoint(GetConfiguration()[Self.Frame].BurningEmbersBar[I].Anchor, Self.WarlockSpecBars, GetConfiguration()[Self.Frame].BurningEmbersBar[I].X, GetConfiguration()[Self.Frame].BurningEmbersBar[I].Y)
			Self.WarlockSpecBars[I]:SetSize(GetConfiguration()[Self.Frame].BurningEmbersBar[I].Width - 2, GetConfiguration()[Self.Frame].BurningEmbersBar[I].Height - 2)
			Self.WarlockSpecBars[I]:SetStatusBarTexture(Configuration.Texture)

			Self.warlockSpecBarsBorder[I] = Self:CreateTexture(nil, "LOW")
			Self.warlockSpecBarsBorder[I]:SetPoint("TOPLEFT", Self.WarlockSpecBars[I], -1, 1)
			Self.warlockSpecBarsBorder[I]:SetSize(GetConfiguration()[Self.Frame].BurningEmbersBar[I].Width, GetConfiguration()[Self.Frame].BurningEmbersBar[I].Height)
			Self.warlockSpecBarsBorder[I]:SetTexture(0, 0, 0)
		end
	end
end
