--
-- Copyright (C) 2012-2015 Snail <https://github.com/snail23/snailui/>
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
