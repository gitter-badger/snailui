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

local _

function HandleTimerTrackers()
	if GetConfiguration().TimerTrackers then
		hooksecurefunc("StartTimer_SetGoTexture",
			function(Self)
				Self.GoTexture:SetTexture(Configuration.GoTexture)
				Self.GoTextureGlow:SetTexture(Configuration.GoTextureGlow)
			end
		)

		hooksecurefunc("StartTimer_SetTexNumbers",
			function(Self, ...)
				local Digits = {...}
				local Parent
				local Point
				local RelativePoint
				local X
				local Y

				for I = 1, #Digits do
					Point, Parent, RelativePoint, X, Y = Digits[I]:GetPoint()

					if I == 1 then
						if Self.anchorCenter then
							Digits[I]:SetPoint(Point, Parent, RelativePoint, X, 0)
						else
							Digits[I]:SetPoint(Point, Parent, RelativePoint, X, -floor((floor(Digits[I]:GetHeight() + 0.5) / 2) + 0.5))
						end
					end
				end
			end
		)

		local function SkinTimer(Self)
			local Bar
			local Class = select(2, UnitClass("Player"))

			for _, Timer in pairs(TimerTracker.timerList) do
				if Timer.bar and (not Timer.bar.Skinned) then
					Timer:SetPoint(GetConfiguration().TimerTrackers.Anchor, GetConfiguration().TimerTrackers.X, GetConfiguration().TimerTrackers.Y)
					Timer:SetSize(GetConfiguration().TimerTrackers.Width - 6, GetConfiguration().TimerTrackers.Height - 6)

					if GetConfiguration().ExperienceBar then
						Timer:SetPoint(GetConfiguration().TimerTrackers.Anchor, GetConfiguration().TimerTrackers.X, GetConfiguration().TimerTrackers.Y - (GetConfiguration().ExperienceBar.Height - 3))
					end

					Timer.ClearAllPoints = Blank
					Timer.SetPoint = Blank

					Bar = Timer.bar
					Bar:SetPoint("CENTER")
					Bar:SetSize(GetConfiguration().TimerTrackers.Width - 6, GetConfiguration().TimerTrackers.Height - 6)
					Bar:SetStatusBarTexture(Configuration.Texture)
					Bar:SetStatusBarColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

					Bar.background = select(1, Bar:GetRegions())
					Bar.background:Hide()

					Bar.BackgroundBottom = Bar:CreateTexture(nil, "LOW")
					Bar.BackgroundBottom:SetPoint("BOTTOM", 0, -2)
					Bar.BackgroundBottom:SetSize(GetConfiguration().TimerTrackers.Width - 2, 1)
					Bar.BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

					Bar.BackgroundLeft = Bar:CreateTexture(nil, "LOW")
					Bar.BackgroundLeft:SetPoint("LEFT", -2, 0)
					Bar.BackgroundLeft:SetSize(1, GetConfiguration().TimerTrackers.Height - 4)
					Bar.BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

					Bar.BackgroundRight = Bar:CreateTexture(nil, "LOW")
					Bar.BackgroundRight:SetPoint("RIGHT", 2, 0)
					Bar.BackgroundRight:SetSize(1, GetConfiguration().TimerTrackers.Height - 4)
					Bar.BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

					Bar.BackgroundTop = Bar:CreateTexture(nil, "LOW")
					Bar.BackgroundTop:SetPoint("TOP", 0, 2)
					Bar.BackgroundTop:SetSize(GetConfiguration().TimerTrackers.Width - 2, 1)
					Bar.BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

					Bar.border = _G[Bar:GetName() .. "Border"]
					Bar.border:Hide()

					Bar.Border = Bar:CreateTexture(nil, "BACKGROUND")
					Bar.Border:SetPoint("TOPLEFT", -3, 3)
					Bar.Border:SetSize(GetConfiguration().TimerTrackers.Width, GetConfiguration().TimerTrackers.Height)
					Bar.Border:SetTexture(0, 0, 0)

					Bar.ClearAllPoints = Blank
					Bar.SetPoint = Blank

					Bar.timeText:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
					Bar.timeText:SetPoint("CENTER", 1, 0)
					Bar.timeText:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
					Bar.timeText:SetShadowOffset(0, 0)

					Bar.Skinned = true
				end
			end
		end

		local Timer = CreateFrame("Frame", nil, UIParent)

		Timer:RegisterEvent("START_TIMER")
		Timer:SetScript("OnEvent", SkinTimer)
	end
end
