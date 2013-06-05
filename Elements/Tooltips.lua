-- Tooltips.lua
-- Written by Snail

function HandleTooltips()
	local Class = select(2, UnitClass("Player"))

	GameTooltip:SetBackdrop(nil)
	GameTooltip:HookScript("OnShow",
		function(Self)
			Self.Time = 0.1
			GameTooltipStatusBar:Hide()
		end
	)

	GameTooltip:HookScript("OnUpdate",
		function(Self, ElapsedTime)
			if not Self.Time then
				Self.Time = 0.1
			end

			if (Self.Time + ElapsedTime) >= 0.1 then
				Self.BackgroundBottom:SetSize(Self:GetWidth() + 2, 1)
				Self.BackgroundLeft:SetSize(1, Self:GetHeight() + 4)
				Self.BackgroundRight:SetSize(1, Self:GetHeight() + 4)
				Self.BackgroundTop:SetSize(Self:GetWidth() + 2, 1)

				Self.BorderBottom:SetSize(Self:GetWidth() + 4, 3)
				Self.BorderLeft:SetSize(3, Self:GetHeight() + 6)
				Self.BorderRight:SetSize(3, Self:GetHeight() + 6)
				Self.BorderTop:SetSize(Self:GetWidth() + 4, 3)

				Self.Time = 0
				Self.TransparentBackground:SetSize(Self:GetWidth(), Self:GetHeight())
			else
				Self.Time = Self.Time + ElapsedTime
			end
		end
	)

	GameTooltip.BackgroundBottom = GameTooltip:CreateTexture(nil, "LOW")
	GameTooltip.BackgroundBottom:SetPoint("BOTTOM", 0, -2)
	GameTooltip.BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

	GameTooltip.BackgroundLeft = GameTooltip:CreateTexture(nil, "LOW")
	GameTooltip.BackgroundLeft:SetPoint("LEFT", -2, 0)
	GameTooltip.BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

	GameTooltip.BackgroundRight = GameTooltip:CreateTexture(nil, "LOW")
	GameTooltip.BackgroundRight:SetPoint("RIGHT", 2, 0)
	GameTooltip.BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

	GameTooltip.BackgroundTop = GameTooltip:CreateTexture(nil, "LOW")
	GameTooltip.BackgroundTop:SetPoint("TOP", 0, 2)
	GameTooltip.BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

	GameTooltip.BorderBottom = GameTooltip:CreateTexture(nil, "BACKGROUND")
	GameTooltip.BorderBottom:SetPoint("BOTTOM", 0, -3)
	GameTooltip.BorderBottom:SetTexture(0, 0, 0)

	GameTooltip.BorderLeft = GameTooltip:CreateTexture(nil, "BACKGROUND")
	GameTooltip.BorderLeft:SetPoint("LEFT", -3, 0)
	GameTooltip.BorderLeft:SetTexture(0, 0, 0)

	GameTooltip.BorderRight = GameTooltip:CreateTexture(nil, "BACKGROUND")
	GameTooltip.BorderRight:SetPoint("RIGHT", 3, 0)
	GameTooltip.BorderRight:SetTexture(0, 0, 0)

	GameTooltip.BorderTop = GameTooltip:CreateTexture(nil, "BACKGROUND")
	GameTooltip.BorderTop:SetPoint("TOP", 0, 3)
	GameTooltip.BorderTop:SetTexture(0, 0, 0)

	GameTooltip.TransparentBackground = GameTooltip:CreateTexture(nil, "BACKGROUND")
	GameTooltip.TransparentBackground:SetPoint("CENTER")
	GameTooltip.TransparentBackground:SetTexture(0, 0, 0, 0.5)

	local OriginalGameTooltip_SetDefaultAnchor = GameTooltip_SetDefaultAnchor

	GameTooltip_SetDefaultAnchor = function(Self, Parent)
		OriginalGameTooltip_SetDefaultAnchor(Self, Parent)

		Self:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -7, 7)
	end
end
