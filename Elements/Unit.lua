-- Unit.lua
-- Written by Snail

function HandleUnit(Self)
	Self:RegisterForClicks("AnyUp")
	Self:SetSize(GetConfiguration()[Self.Frame].Width, GetConfiguration()[Self.Frame].Height)
	Self:SetScript("OnEnter",
		function(Self)
			UnitFrame_UpdateTooltip(Self)
		end
	)

	Self:SetScript("OnLeave",
		function()
			GameTooltip_Hide()
		end
	)

	Self.Background = Self:CreateTexture(nil, "LOW")
	Self.Background:SetPoint("TOPLEFT", 1, -1)
	Self.Background:SetSize(GetConfiguration()[Self.Frame].Width - 2, GetConfiguration()[Self.Frame].Height - 2)

	Self.Border = Self:CreateTexture(nil, "BACKGROUND")
	Self.Border:SetPoint("TOPLEFT")
	Self.Border:SetSize(GetConfiguration()[Self.Frame].Width, GetConfiguration()[Self.Frame].Height)
	Self.Border:SetTexture(0, 0, 0)

	Self.menu = function(Self)
		if Self.unit:match("^party") then
			ToggleDropDownMenu(1, nil, _G["PartyMemberFrame" .. Self.id .. "DropDown"], "cursor", 0, 0)
		elseif Self.unit:match("^raid") then
			Self.name = Self.unit
			RaidGroupButton_ShowMenu(Self)
		else
			ToggleDropDownMenu(1, nil, _G[Self.unit:gsub("(.)", string.upper, 1) .. "FrameDropDown"], "cursor", 0, 0)
		end
	end
end
