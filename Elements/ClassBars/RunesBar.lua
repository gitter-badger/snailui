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

function HandleRunesBar(Self)
	local Class = select(2, UnitClass(Self.Frame))

	if GetConfiguration()[Self.Frame].RunesBar and (Self.Frame == "Player") and (Class == "DEATHKNIGHT") then
		Self.Runes = CreateFrame("Frame", nil, Self)
		Self.Runes:SetSize(GetConfiguration()[Self.Frame].RunesBar.Width - 2, GetConfiguration()[Self.Frame].RunesBar.Height - 2)

		if GetConfiguration()[Self.Frame].RunesBar.Parent then
			Self.Runes:SetPoint(GetConfiguration()[Self.Frame].RunesBar.Anchor, GetConfiguration()[Self.Frame].RunesBar.Parent, GetConfiguration()[Self.Frame].RunesBar.X, GetConfiguration()[Self.Frame].RunesBar.Y)
		else
			Self.Runes:SetPoint(GetConfiguration()[Self.Frame].RunesBar.Anchor, GetConfiguration()[Self.Frame].RunesBar.X, GetConfiguration()[Self.Frame].RunesBar.Y)
		end

		Self.Runes.Background = Self.Runes:CreateTexture(nil, "BACKGROUND")
		Self.Runes.Background:SetPoint("TOPLEFT")
		Self.Runes.Background:SetSize(GetConfiguration()[Self.Frame].RunesBar.Width - 2, GetConfiguration()[Self.Frame].RunesBar.Height - 2)

		Self.Runes.Border = Self.Runes:CreateTexture(nil, "BACKGROUND")
		Self.Runes.Border:SetPoint("TOPLEFT", -1, 1)
		Self.Runes.Border:SetSize(GetConfiguration()[Self.Frame].RunesBar.Width, GetConfiguration()[Self.Frame].RunesBar.Height)
		Self.Runes.Border:SetTexture(0, 0, 0)

		for I = 1, #GetConfiguration()[Self.Frame].RunesBar do
			Self.Runes[I] = CreateFrame("StatusBar", nil, Self)
			Self.Runes[I]:SetPoint(GetConfiguration()[Self.Frame].RunesBar[I].Anchor, Self.Runes, GetConfiguration()[Self.Frame].RunesBar[I].X, GetConfiguration()[Self.Frame].RunesBar[I].Y)
			Self.Runes[I]:SetSize(GetConfiguration()[Self.Frame].RunesBar[I].Width - 2, GetConfiguration()[Self.Frame].RunesBar[I].Height - 2)
			Self.Runes[I]:SetStatusBarTexture(Configuration.Texture)

			Self.Runes[I].Border = Self.Runes:CreateTexture(nil, "LOW")
			Self.Runes[I].Border:SetPoint("TOPLEFT", Self.Runes[I], -1, 1)
			Self.Runes[I].Border:SetSize(GetConfiguration()[Self.Frame].RunesBar[I].Width, GetConfiguration()[Self.Frame].RunesBar[I].Height)
			Self.Runes[I].Border:SetTexture(0, 0, 0)
		end
	end
end
