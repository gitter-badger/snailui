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

function HandleExtraButton()
	if GetConfiguration().ExtraButton then
		local Class = select(2, UnitClass("Player"))

		ExtraButton = CreateFrame("Button", nil, UIParent)
		ExtraButton:RegisterForClicks("AnyUp")
		ExtraButton:SetPoint(GetConfiguration().ExtraButton.Anchor, GetConfiguration().ExtraButton.X, GetConfiguration().ExtraButton.Y)
		ExtraButton:SetSize(GetConfiguration().ExtraButton.Width - 4, GetConfiguration().ExtraButton.Height - 4)
		ExtraButton:SetScript("OnClick",
			function(Self)
				if Self.Shown then
					if not InCombatLockdown() then
						BuffFrame:Hide()
						MainMenuExpBar:Hide()

						MultiBarBottomRight.EnableShow = nil
						MultiBarLeft.EnableShow = nil

						MultiBarBottomRight:Hide()
						MultiBarLeft:Hide()

						ObjectiveTrackerFrame:Hide()
						VehicleSeatIndicator:Hide()
						WorldStateAlwaysUpFrame:Hide()

						if (not GetConfiguration().Raid.Shown) and Options.EnableRaidFrames then
							Raid:Hide()
						end

						Self.Bar.Text:SetText("Show Misc Frames")
						Self.Shown = nil
					else
						print("Can't hide misc frames while in combat!")
					end
				else
					if not InCombatLockdown() then
						BuffFrame:Show()
						MainMenuExpBar:Show()

						MultiBarBottomRight.EnableShow = true
						MultiBarLeft.EnableShow = true

						MultiBarBottomRight:Show()
						MultiBarLeft:Show()

						ObjectiveTrackerFrame:Show()
						VehicleSeatIndicator:Show()
						WorldStateAlwaysUpFrame:Show()

						if (not GetConfiguration().Raid.shown) and Options.EnableRaidFrames then
							Raid:Show()
						end

						Self.Bar.Text:SetText("Hide Misc Frames")
						Self.Shown = true
					else
						print("Can't show misc frames while in combat!")
					end
				end
			end
		)

		if GetConfiguration().ExtraButton.HoverToShow then
			ExtraButton:SetAlpha(0.25)
			ExtraButton:SetScript("OnEnter",
				function(Self)
					if not ExtraButton.Shown then
						Self:SetAlpha(1)
					end
				end
			)

			ExtraButton:SetScript("OnLeave",
				function(Self)
					if not ExtraButton.Shown then
						Self:SetAlpha(0.25)
					end
				end
			)
		end

		ExtraButton.Background = ExtraButton:CreateTexture(nil, "LOW")
		ExtraButton.Background:SetPoint("TOPLEFT", -1, 1)
		ExtraButton.Background:SetSize(GetConfiguration().ExtraButton.Width - 2, GetConfiguration().ExtraButton.Height - 2)
		ExtraButton.Background:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		ExtraButton.Border = ExtraButton:CreateTexture(nil, "BACKGROUND")
		ExtraButton.Border:SetPoint("TOPLEFT", -2, 2)
		ExtraButton.Border:SetSize(GetConfiguration().ExtraButton.Width, GetConfiguration().ExtraButton.Height)
		ExtraButton.Border:SetTexture(0, 0, 0)

		ExtraButton.Bar = CreateFrame("StatusBar", nil, ExtraButton)
		ExtraButton.Bar:SetPoint("CENTER")
		ExtraButton.Bar:SetSize(GetConfiguration().ExtraButton.Width - 6, GetConfiguration().ExtraButton.Height - 6)
		ExtraButton.Bar:SetStatusBarTexture(Configuration.Texture)
		ExtraButton.Bar:SetStatusBarColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		ExtraButton.Bar.Border = ExtraButton.Bar:CreateTexture(nil, "BACKGROUND")
		ExtraButton.Bar.Border:SetPoint("TOPLEFT", -1, 1)
		ExtraButton.Bar.Border:SetSize(GetConfiguration().ExtraButton.Width - 4, GetConfiguration().ExtraButton.Height - 4)
		ExtraButton.Bar.Border:SetTexture(0, 0, 0)

		ExtraButton.Bar.Text = ExtraButton.Bar:CreateFontString(nil, "OVERLAY")
		ExtraButton.Bar.Text:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
		ExtraButton.Bar.Text:SetPoint("CENTER", 1, 0)
		ExtraButton.Bar.Text:SetText("Show Misc Frames")
		ExtraButton.Bar.Text:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
	end
end
