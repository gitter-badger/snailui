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

function HandleComboPointsBar(Self)
	local Class = select(2, UnitClass(Self.Frame))
	local Specialization = GetSpecialization()

	if Specialization then
		Specialization = select(2, GetSpecializationInfo(Specialization))
		Specialization = Specialization:gsub("(.)", string.upper)
	end

	if GetConfiguration()[Self.Frame].ComboPointsBar and (Self.Frame == "Player") and ((Class == "ROGUE") or ((Class == "DRUID") and (Specialization == "FERAL"))) then
		Self.CPoints = CreateFrame("Frame", nil, Self)
		Self.CPoints:SetSize(GetConfiguration()[Self.Frame].ComboPointsBar.Width - 2, GetConfiguration()[Self.Frame].ComboPointsBar.Height - 2)

		if GetConfiguration()[Self.Frame].ComboPointsBar.Parent then
			Self.CPoints:SetPoint(GetConfiguration()[Self.Frame].ComboPointsBar.Anchor, GetConfiguration()[Self.Frame].ComboPointsBar.Parent, GetConfiguration()[Self.Frame].ComboPointsBar.X, GetConfiguration()[Self.Frame].ComboPointsBar.Y)
		else
			Self.CPoints:SetPoint(GetConfiguration()[Self.Frame].ComboPointsBar.Anchor, GetConfiguration()[Self.Frame].ComboPointsBar.X, GetConfiguration()[Self.Frame].ComboPointsBar.Y)
		end

		Self.CPoints.Background = Self.CPoints:CreateTexture(nil, "BACKGROUND")
		Self.CPoints.Background:SetPoint("TOPLEFT")
		Self.CPoints.Background:SetSize(GetConfiguration()[Self.Frame].ComboPointsBar.Width - 2, GetConfiguration()[Self.Frame].ComboPointsBar.Height - 2)

		Self.CPoints.Border = Self.CPoints:CreateTexture(nil, "BACKGROUND")
		Self.CPoints.Border:SetPoint("TOPLEFT", -1, 1)
		Self.CPoints.Border:SetSize(GetConfiguration()[Self.Frame].ComboPointsBar.Width, GetConfiguration()[Self.Frame].ComboPointsBar.Height)
		Self.CPoints.Border:SetTexture(0, 0, 0)

		for I = 1, #GetConfiguration()[Self.Frame].ComboPointsBar do
			Self.CPoints[I] = CreateFrame("StatusBar", nil, Self)
			Self.CPoints[I]:SetPoint(GetConfiguration()[Self.Frame].ComboPointsBar[I].Anchor, Self.CPoints, GetConfiguration()[Self.Frame].ComboPointsBar[I].X, GetConfiguration()[Self.Frame].ComboPointsBar[I].Y)
			Self.CPoints[I]:SetSize(GetConfiguration()[Self.Frame].ComboPointsBar[I].Width - 2, GetConfiguration()[Self.Frame].ComboPointsBar[I].Height - 2)
			Self.CPoints[I]:SetStatusBarTexture(Configuration.Texture)

			Self.CPoints[I].Border = Self.CPoints:CreateTexture(nil, "LOW")
			Self.CPoints[I].Border:SetPoint("TOPLEFT", Self.CPoints[I], -1, 1)
			Self.CPoints[I].Border:SetSize(GetConfiguration()[Self.Frame].ComboPointsBar[I].Width, GetConfiguration()[Self.Frame].ComboPointsBar[I].Height)
			Self.CPoints[I].Border:SetTexture(0, 0, 0)
		end
	end
end
