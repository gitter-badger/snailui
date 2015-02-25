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

function HandlePowerBar(Self)
	if GetConfiguration()[Self.Frame].PowerBar then
		Self.Power = CreateFrame("StatusBar", nil, Self)
		Self.Power.frequentUpdates = true
		Self.Power:SetOrientation(GetConfiguration()[Self.Frame].PowerBar.Orientation)
		Self.Power:SetStatusBarTexture(Configuration.Texture)

		if GetConfiguration()[Self.Frame].PowerBar.Parent then
			Self.Power:SetPoint(GetConfiguration()[Self.Frame].PowerBar.Anchor, GetConfiguration()[Self.Frame].PowerBar.Parent, GetConfiguration()[Self.Frame].PowerBar.X, GetConfiguration()[Self.Frame].PowerBar.Y)
		else
			Self.Power:SetPoint(GetConfiguration()[Self.Frame].PowerBar.Anchor, GetConfiguration()[Self.Frame].PowerBar.X, GetConfiguration()[Self.Frame].PowerBar.Y)
		end

		local Class = select(2, UnitClass(Self.unit))

		if GetConfiguration()[Self.Frame].PowerBar.Border then
			Self.Power:SetSize(GetConfiguration()[Self.Frame].PowerBar.Width - 6, GetConfiguration()[Self.Frame].PowerBar.Height - 6)

			Self.Power.BackgroundBottom = Self.Power:CreateTexture(nil, "LOW")
			Self.Power.BackgroundBottom:SetPoint("BOTTOM", 0, -2)
			Self.Power.BackgroundBottom:SetSize(GetConfiguration()[Self.Frame].PowerBar.Width - 2, 1)
			Self.Power.BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			Self.Power.BackgroundLeft = Self.Power:CreateTexture(nil, "LOW")
			Self.Power.BackgroundLeft:SetPoint("LEFT", -2, 0)
			Self.Power.BackgroundLeft:SetSize(1, GetConfiguration()[Self.Frame].PowerBar.Height - 4)
			Self.Power.BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			Self.Power.BackgroundRight = Self.Power:CreateTexture(nil, "LOW")
			Self.Power.BackgroundRight:SetPoint("RIGHT", 2, 0)
			Self.Power.BackgroundRight:SetSize(1, GetConfiguration()[Self.Frame].PowerBar.Height - 4)
			Self.Power.BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			Self.Power.BackgroundTop = Self.Power:CreateTexture(nil, "LOW")
			Self.Power.BackgroundTop:SetPoint("TOP", 0, 2)
			Self.Power.BackgroundTop:SetSize(GetConfiguration()[Self.Frame].PowerBar.Width - 2, 1)
			Self.Power.BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			Self.Power.Border = Self.Power:CreateTexture(nil, "BACKGROUND")
			Self.Power.Border:SetPoint("TOPLEFT", -3, 3)
			Self.Power.Border:SetSize(GetConfiguration()[Self.Frame].PowerBar.Width, GetConfiguration()[Self.Frame].PowerBar.Height)
			Self.Power.Border:SetTexture(0, 0, 0)
		else
			Self.Power:SetSize(GetConfiguration()[Self.Frame].PowerBar.Width - 2, GetConfiguration()[Self.Frame].PowerBar.Height - 2)

			Self.Power.Border = Self.Power:CreateTexture(nil, "LOW")
			Self.Power.Border:SetPoint("TOPLEFT", -1, 1)
			Self.Power.Border:SetSize(GetConfiguration()[Self.Frame].PowerBar.Width, GetConfiguration()[Self.Frame].PowerBar.Height)
			Self.Power.Border:SetTexture(0, 0, 0)
		end
	end
end
