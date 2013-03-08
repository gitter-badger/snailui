-- ShadowOrbsBar.lua
-- Written by Snail

function HandleShadowOrbsBar(Self)
	local Class = select(2, UnitClass(Self.Frame))
	local Specialization = GetSpecialization()

	if Specialization then
		Specialization = select(2, GetSpecializationInfo(Specialization))
		Specialization = Specialization:gsub("(.)", string.upper)
	end

	if GetConfiguration()[Self.Frame].ShadowOrbsBar and (Self.Frame == "Player") and (Class == "PRIEST") and (Specialization == "SHADOW") then
		Self.ClassIcons = Self:CreateTexture(Self, "BACKGROUND")
		Self.ClassIcons:SetPoint(GetConfiguration()[Self.Frame].ShadowOrbsBar.Anchor, GetConfiguration()[Self.Frame].ShadowOrbsBar.X, GetConfiguration()[Self.Frame].ShadowOrbsBar.Y)
		Self.ClassIcons:SetSize(GetConfiguration()[Self.Frame].ShadowOrbsBar.Width, GetConfiguration()[Self.Frame].ShadowOrbsBar.Height)
		Self.ClassIcons:SetTexture(0, 0, 0)

		Self.ClassIcons.Background = Self:CreateTexture(nil, "LOW")
		Self.ClassIcons.Background:SetPoint("TOPLEFT", Self.ClassIcons, 1, -1)
		Self.ClassIcons.Background:SetSize(GetConfiguration()[Self.Frame].ShadowOrbsBar.Width - 2, GetConfiguration()[Self.Frame].ShadowOrbsBar.Height - 2)

		for I = 1, 5 do
			Self.ClassIcons[I] = Self:CreateTexture(Self, "LOW")

			if I <= #GetConfiguration()[Self.Frame].ShadowOrbsBar then
				Self.ClassIcons[I]:SetPoint(GetConfiguration()[Self.Frame].ShadowOrbsBar[I].Anchor, Self.ClassIcons, GetConfiguration()[Self.Frame].ShadowOrbsBar[I].X, GetConfiguration()[Self.Frame].ShadowOrbsBar[I].Y)
				Self.ClassIcons[I]:SetSize(GetConfiguration()[Self.Frame].ShadowOrbsBar[I].Width - 2, GetConfiguration()[Self.Frame].ShadowOrbsBar[I].Height - 2)
				Self.ClassIcons[I]:SetTexture(Configuration.Texture)

				Self.ClassIcons[I].Border = Self:CreateTexture(nil, "LOW")
				Self.ClassIcons[I].Border:SetPoint("TOPLEFT", Self.ClassIcons[I], -1, 1)
				Self.ClassIcons[I].Border:SetSize(GetConfiguration()[Self.Frame].ShadowOrbsBar[I].Width, GetConfiguration()[Self.Frame].ShadowOrbsBar[I].Height)
				Self.ClassIcons[I].Border:SetTexture(0, 0, 0)
			end
		end
	end
end
