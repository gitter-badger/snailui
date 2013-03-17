-- Raid.lua
-- Written by Snail

function HandleRaid(Self)
	if GetConfiguration().Raid and (not EnableRaidFrames) then
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
