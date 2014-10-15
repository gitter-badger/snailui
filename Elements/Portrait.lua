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

function HandlePortrait(Self)
	if GetConfiguration()[Self.Frame].Portrait then
		Self.Portrait = CreateFrame("PlayerModel", nil, Self)
		Self.Portrait:SetPoint(GetConfiguration()[Self.Frame].Portrait.Anchor, GetConfiguration()[Self.Frame].Portrait.X, GetConfiguration()[Self.Frame].Portrait.Y)
		Self.Portrait:SetSize(GetConfiguration()[Self.Frame].Portrait.Width - 3, GetConfiguration()[Self.Frame].Portrait.Height - 3)

		Self.Portrait.Border = Self.Portrait:CreateTexture(nil, "LOW")
		Self.Portrait.Border:SetPoint("TOPLEFT", -1, 1)
		Self.Portrait.Border:SetSize(GetConfiguration()[Self.Frame].Portrait.Width, GetConfiguration()[Self.Frame].Portrait.Height)
		Self.Portrait.Border:SetTexture(0, 0, 0)
	end
end
