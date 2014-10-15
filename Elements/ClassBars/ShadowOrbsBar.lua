--
-- Copyright (C) 2012-2014 Snailsoft <http://www.snailsoft.me/>
--
-- This program is free software; you can redistribute it and/or modify it
-- under the terms of the GNU General Public License as published by the
-- Free Software Foundation; either version 2 of the License, or (at your
-- option) any later version.
--
-- This program is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details.
--
-- You should have received a copy of the GNU General Public License along
-- with this program. If not, see <http://www.gnu.org/licenses/>.
--

function HandleShadowOrbsBar(Self)
	local Class = select(2, UnitClass(Self.Frame))
	local Specialization = GetSpecialization()

	if Specialization then
		Specialization = select(2, GetSpecializationInfo(Specialization))
		Specialization = Specialization:gsub("(.)", string.upper)
	end

	if GetConfiguration()[Self.Frame].ShadowOrbsBar and (Self.Frame == "Player") and (Class == "PRIEST") and (Specialization == "SHADOW") then
		Self.ClassIcons = Self:CreateTexture(Self, "BACKGROUND")
		Self.ClassIcons:SetSize(GetConfiguration()[Self.Frame].ShadowOrbsBar.Width, GetConfiguration()[Self.Frame].ShadowOrbsBar.Height)
		Self.ClassIcons:SetTexture(0, 0, 0)

		if GetConfiguration()[Self.Frame].ShadowOrbsBar.Parent then
			Self.ClassIcons:SetPoint(GetConfiguration()[Self.Frame].ShadowOrbsBar.Anchor, GetConfiguration()[Self.Frame].ShadowOrbsBar.Parent, GetConfiguration()[Self.Frame].ShadowOrbsBar.X, GetConfiguration()[Self.Frame].ShadowOrbsBar.Y)
		else
			Self.ClassIcons:SetPoint(GetConfiguration()[Self.Frame].ShadowOrbsBar.Anchor, GetConfiguration()[Self.Frame].ShadowOrbsBar.X, GetConfiguration()[Self.Frame].ShadowOrbsBar.Y)
		end

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
