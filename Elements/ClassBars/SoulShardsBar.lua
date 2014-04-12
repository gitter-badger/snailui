-- SoulShardsBar.lua
-- Written by Snail

function HandleSoulShardsBar(Self)
	local Class = select(2, UnitClass(Self.Frame))
	local Specialization = GetSpecialization()

	if Specialization then
		Specialization = select(2, GetSpecializationInfo(Specialization))
		Specialization = Specialization:gsub("(.)", string.upper)
	end

	if GetConfiguration()[Self.Frame].SoulShardsBar and (Self.Frame == "Player") and (Class == "WARLOCK") and (Specialization == "AFFLICTION") then
		Self.WarlockSpecBars = CreateFrame("Frame", nil, Self)
		Self.WarlockSpecBars:SetPoint(GetConfiguration()[Self.Frame].SoulShardsBar.Anchor, GetConfiguration()[Self.Frame].SoulShardsBar.X, GetConfiguration()[Self.Frame].SoulShardsBar.Y)
		Self.WarlockSpecBars:SetSize(GetConfiguration()[Self.Frame].SoulShardsBar.Width - 2, GetConfiguration()[Self.Frame].SoulShardsBar.Height - 2)

		Self.warlockSpecBarsBackground = Self:CreateTexture(nil, "BACKGROUND")
		Self.warlockSpecBarsBackground:SetPoint("TOPLEFT", Self.WarlockSpecBars)
		Self.warlockSpecBarsBackground:SetSize(GetConfiguration()[Self.Frame].SoulShardsBar.Width - 2, GetConfiguration()[Self.Frame].SoulShardsBar.Height - 2)

		Self.warlockSpecBarsBorder = Self:CreateTexture(nil, "BACKGROUND")
		Self.warlockSpecBarsBorder:SetPoint("TOPLEFT", Self.WarlockSpecBars, -1, 1)
		Self.warlockSpecBarsBorder:SetSize(GetConfiguration()[Self.Frame].SoulShardsBar.Width, GetConfiguration()[Self.Frame].SoulShardsBar.Height)
		Self.warlockSpecBarsBorder:SetTexture(0, 0, 0)

		for I = 1, #GetConfiguration()[Self.Frame].SoulShardsBar do
			Self.WarlockSpecBars[I] = CreateFrame("StatusBar", nil, Self)
			Self.WarlockSpecBars[I]:SetPoint(GetConfiguration()[Self.Frame].SoulShardsBar[I].Anchor, Self.WarlockSpecBars, GetConfiguration()[Self.Frame].SoulShardsBar[I].X, GetConfiguration()[Self.Frame].SoulShardsBar[I].Y)
			Self.WarlockSpecBars[I]:SetSize(GetConfiguration()[Self.Frame].SoulShardsBar[I].Width - 2, GetConfiguration()[Self.Frame].SoulShardsBar[I].Height - 2)
			Self.WarlockSpecBars[I]:SetStatusBarTexture(Configuration.Texture)

			Self.warlockSpecBarsBorder[I] = Self:CreateTexture(nil, "LOW")
			Self.warlockSpecBarsBorder[I]:SetPoint("TOPLEFT", Self.WarlockSpecBars[I], -1, 1)
			Self.warlockSpecBarsBorder[I]:SetSize(GetConfiguration()[Self.Frame].SoulShardsBar[I].Width, GetConfiguration()[Self.Frame].SoulShardsBar[I].Height)
			Self.warlockSpecBarsBorder[I]:SetTexture(0, 0, 0)
		end
	end
end