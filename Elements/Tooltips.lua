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

	hooksecurefunc("GameTooltip_SetDefaultAnchor",
		function(Self, Parent)
			Self:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -7, 7)
		end
	)
end
