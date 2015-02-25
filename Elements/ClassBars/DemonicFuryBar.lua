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

function HandleDemonicFuryBar(Self)
	local Class = select(2, UnitClass(Self.Frame))
	local Specialization = GetSpecialization()

	if Specialization then
		Specialization = select(2, GetSpecializationInfo(Specialization))
		Specialization = Specialization:gsub("(.)", string.upper)
	end

	if GetConfiguration()[Self.Frame].DemonicFuryBar and (Self.Frame == "Player") and (Class == "WARLOCK") and (Specialization == "DEMONOLOGY") then
		Self.WarlockSpecBars = CreateFrame("Frame", nil, Self)
		Self.WarlockSpecBars:SetSize(GetConfiguration()[Self.Frame].DemonicFuryBar.Width - 2, GetConfiguration()[Self.Frame].DemonicFuryBar.Height - 2)

		if GetConfiguration()[Self.Frame].DemonicFuryBar.Parent then
			Self.WarlockSpecBars:SetPoint(GetConfiguration()[Self.Frame].DemonicFuryBar.Anchor, GetConfiguration()[Self.Frame].DemonicFuryBar.Parent, GetConfiguration()[Self.Frame].DemonicFuryBar.X, GetConfiguration()[Self.Frame].DemonicFuryBar.Y)
		else
			Self.WarlockSpecBars:SetPoint(GetConfiguration()[Self.Frame].DemonicFuryBar.Anchor, GetConfiguration()[Self.Frame].DemonicFuryBar.X, GetConfiguration()[Self.Frame].DemonicFuryBar.Y)
		end

		Self.warlockSpecBarsBackground = Self:CreateTexture(nil, "BACKGROUND")
		Self.warlockSpecBarsBackground:SetPoint("TOPLEFT", Self.WarlockSpecBars)
		Self.warlockSpecBarsBackground:SetSize(GetConfiguration()[Self.Frame].DemonicFuryBar.Width - 2, GetConfiguration()[Self.Frame].DemonicFuryBar.Height - 2)

		Self.warlockSpecBarsBorder = Self:CreateTexture(nil, "BACKGROUND")
		Self.warlockSpecBarsBorder:SetPoint("TOPLEFT", Self.WarlockSpecBars, -1, 1)
		Self.warlockSpecBarsBorder:SetSize(GetConfiguration()[Self.Frame].DemonicFuryBar.Width, GetConfiguration()[Self.Frame].DemonicFuryBar.Height)
		Self.warlockSpecBarsBorder:SetTexture(0, 0, 0)

		for I = 1, #GetConfiguration()[Self.Frame].DemonicFuryBar do
			Self.WarlockSpecBars[I] = CreateFrame("StatusBar", nil, Self)
			Self.WarlockSpecBars[I]:SetPoint(GetConfiguration()[Self.Frame].DemonicFuryBar[I].Anchor, Self.WarlockSpecBars, GetConfiguration()[Self.Frame].DemonicFuryBar[I].X, GetConfiguration()[Self.Frame].DemonicFuryBar[I].Y)
			Self.WarlockSpecBars[I]:SetSize(GetConfiguration()[Self.Frame].DemonicFuryBar[I].Width - 2, GetConfiguration()[Self.Frame].DemonicFuryBar[I].Height - 2)
			Self.WarlockSpecBars[I]:SetStatusBarTexture(Configuration.Texture)

			Self.warlockSpecBarsBorder[I] = Self:CreateTexture(nil, "LOW")
			Self.warlockSpecBarsBorder[I]:SetPoint("TOPLEFT", Self.WarlockSpecBars[I], -1, 1)
			Self.warlockSpecBarsBorder[I]:SetSize(GetConfiguration()[Self.Frame].DemonicFuryBar[I].Width, GetConfiguration()[Self.Frame].DemonicFuryBar[I].Height)
			Self.warlockSpecBarsBorder[I]:SetTexture(0, 0, 0)

			Self.WarlockSpecBars[I].Fury = Self.WarlockSpecBars[I]:CreateFontString(nil, "OVERLAY")
			Self.WarlockSpecBars[I].Fury.frequentUpdates = true
			Self.WarlockSpecBars[I].Fury:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
			Self.WarlockSpecBars[I].Fury:SetPoint("TOP", Self.warlockSpecBarsBorder, 1, -((GetConfiguration()[Self.Frame].DemonicFuryBar[I].Height - 2) / 2) + 1)
			Self.WarlockSpecBars[I].Fury:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			Self:Tag(Self.WarlockSpecBars[I].Fury, "[SnailUI:DemonicFury]")
		end
	end
end
