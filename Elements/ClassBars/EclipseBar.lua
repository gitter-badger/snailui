--
-- Copyright (C) 2012-2015 Snailsoft <http://www.snailsoft.me/>
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

function HandleEclipseBar(Self)
	local Class = select(2, UnitClass(Self.Frame))
	local Specialization = GetSpecialization()

	if Specialization then
		Specialization = select(2, GetSpecializationInfo(Specialization))
		Specialization = Specialization:gsub("(.)", string.upper)
	end

	if GetConfiguration()[Self.Frame].EclipseBar and (Self.Frame == "Player") and (Class == "DRUID") and (Specialization == "BALANCE") then
		Self.EclipseBar = CreateFrame("Frame", nil, Self)
		Self.EclipseBar:SetSize(GetConfiguration()[Self.Frame].EclipseBar.Width - 2, GetConfiguration()[Self.Frame].EclipseBar.Height - 2)

		if GetConfiguration()[Self.Frame].EclipseBar.Parent then
			Self.EclipseBar:SetPoint(GetConfiguration()[Self.Frame].EclipseBar.Anchor, GetConfiguration()[Self.Frame].EclipseBar.Parent, GetConfiguration()[Self.Frame].EclipseBar.X, GetConfiguration()[Self.Frame].EclipseBar.Y)
		else
			Self.EclipseBar:SetPoint(GetConfiguration()[Self.Frame].EclipseBar.Anchor, GetConfiguration()[Self.Frame].EclipseBar.X, GetConfiguration()[Self.Frame].EclipseBar.Y)
		end

		Self.EclipseBar.Background = Self.EclipseBar:CreateTexture(nil, "BACKGROUND")
		Self.EclipseBar.Background:SetPoint("TOPLEFT")
		Self.EclipseBar.Background:SetSize(GetConfiguration()[Self.Frame].EclipseBar.Width - 2, GetConfiguration()[Self.Frame].EclipseBar.Height - 2)

		Self.EclipseBar.Border = Self.EclipseBar:CreateTexture(nil, "BACKGROUND")
		Self.EclipseBar.Border:SetPoint("TOPLEFT", -1, 1)
		Self.EclipseBar.Border:SetSize(GetConfiguration()[Self.Frame].EclipseBar.Width, GetConfiguration()[Self.Frame].EclipseBar.Height)
		Self.EclipseBar.Border:SetTexture(0, 0, 0)

		Self.EclipseBar.InnerBorder = Self.EclipseBar:CreateTexture(nil, "LOW")
		Self.EclipseBar.InnerBorder:SetPoint("TOPLEFT", 1, -1)
		Self.EclipseBar.InnerBorder:SetSize(GetConfiguration()[Self.Frame].EclipseBar[1].Width, GetConfiguration()[Self.Frame].EclipseBar[1].Height)
		Self.EclipseBar.InnerBorder:SetTexture(0, 0, 0)

		Self.EclipseBar.LunarBar = CreateFrame("StatusBar", nil, Self)
		Self.EclipseBar.LunarBar:SetPoint(GetConfiguration()[Self.Frame].EclipseBar[1].Anchor, Self.EclipseBar, GetConfiguration()[Self.Frame].EclipseBar[1].X, GetConfiguration()[Self.Frame].EclipseBar[1].Y)
		Self.EclipseBar.LunarBar:SetSize(GetConfiguration()[Self.Frame].EclipseBar[1].Width - 2, GetConfiguration()[Self.Frame].EclipseBar[1].Height - 2)
		Self.EclipseBar.LunarBar:SetStatusBarTexture(Configuration.Texture)
		Self.EclipseBar.LunarBar:SetStatusBarColor(0.3, 0.52, 0.9)

		Self.EclipseBar.SolarBar = CreateFrame("StatusBar", nil, Self)
		Self.EclipseBar.SolarBar:SetPoint("LEFT", Self.EclipseBar.LunarBar:GetStatusBarTexture(), "RIGHT")
		Self.EclipseBar.SolarBar:SetSize(GetConfiguration()[Self.Frame].EclipseBar[1].Width - 2, GetConfiguration()[Self.Frame].EclipseBar[1].Height - 2)
		Self.EclipseBar.SolarBar:SetStatusBarTexture(Configuration.Texture)
		Self.EclipseBar.SolarBar:SetStatusBarColor(0.8, 0.82, 0.6)

		Self.EclipseBar.direction = Self.EclipseBar:CreateFontString(nil, "OVERLAY")
		Self.EclipseBar.direction.frequentUpdates = true
		Self.EclipseBar.direction:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
		Self.EclipseBar.direction:SetPoint("CENTER", Self.EclipseBar.InnerBorder, 1, 0)
		Self.EclipseBar.direction:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		Self:Tag(Self.EclipseBar.direction, "[SnailUI:EclipseDirection]")
	end
end
