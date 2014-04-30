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

function HandleRaid(Self)
	if GetConfiguration().Raid and Options.EnableRaidFrames then
		Raid = Self:SpawnHeader(
			nil, nil, nil,
			"columnAnchorPoint", GetConfiguration().Raid.ColumnAnchor,
			"columnSpacing", GetConfiguration().Raid.ColumnSpacing,
			"groupBy", GetConfiguration().Raid.GroupBy,
			"groupingOrder", GetConfiguration().Raid.GroupOrder,
			"maxColumns", GetConfiguration().Raid.Columns,
			"showParty", GetConfiguration().Raid.ShowParty,
			"showPlayer", GetConfiguration().Raid.ShowPlayer,
			"showRaid", GetConfiguration().Raid.ShowRaid,
			"showSolo", GetConfiguration().Raid.ShowSolo,
			"UnitsPerColumn", GetConfiguration().Raid.Rows,
			"xOffset", GetConfiguration().Raid.ColumnX,
			"yOffset", GetConfiguration().Raid.ColumnY
		)

		Raid:SetPoint(GetConfiguration().Raid.Anchor, GetConfiguration().Raid.X, GetConfiguration().Raid.Y)

		if GetConfiguration().Raid.Shown then
			Raid:Show()
		else
			Raid:Hide()
		end
	end
end
