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

function HandleColors(Self)
	Self.PostUpdate = function(Self)
		local Class = select(2, UnitClass(Self.unit))
		
		if UnitClass(Self.unit) then
			Self.ClassColor = RAID_CLASS_COLORS[Class]
		else
			Self.ClassColor =
			{
				b = 1,
				g = 1,
				r = 1
			}
		end

		Self.Background:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)

		if (Self.Frame == "Raid") or Options.EnableThreatColorsOnAllFrames then
			Self.ThreatLevel = UnitThreatSituation(Self.unit)

			if Self.ThreatLevel and (Self.ThreatLevel > 0) then
				Self.ThreatColor =
				{
					b = 0,
					g = 0,
					r = 0
				}

				Self.ThreatColor.r, Self.ThreatColor.g, Self.ThreatColor.b = GetThreatStatusColor(UnitThreatSituation(Self.unit))
				Self.Background:SetTexture(Self.ThreatColor.r, Self.ThreatColor.g, Self.ThreatColor.b)
				Self.ShowFull = true
			else
				Self.ShowFull = nil
			end

			Self.SpellRange.Update(Self, Self.InRange)
		end

		if Self.Castbar then
			Self.Castbar:SetStatusBarColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
			Self.Castbar.BackgroundBottom:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
			Self.Castbar.BackgroundLeft:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
			Self.Castbar.BackgroundRight:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
			Self.Castbar.BackgroundTop:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)

			if Self.Castbar.IconBackgroundBottom then
				Self.Castbar.IconBackgroundBottom:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
				Self.Castbar.IconBackgroundLeft:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
				Self.Castbar.IconBackgroundRight:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
				Self.Castbar.IconBackgroundTop:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
			end

			if Self.Castbar.Text then
				Self.Castbar.Text:SetTextColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
			end

			if Self.Castbar.Time then
				Self.Castbar.Time:SetTextColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
			end
		end

		if Self.ClassIcons then
			Self.ClassIcons.Background:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)

			for I = 1, #Self.ClassIcons do
				Self.ClassIcons[I]:SetVertexColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
			end
		end

		if Self.CPoints then
			Self.CPoints.Background:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)

			for I = 1, #Self.CPoints do
				Self.CPoints[I]:SetStatusBarColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
			end
		end

		if Self.EclipseBar then
			Self.EclipseBar.Background:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
		end

		if Self.Health then
			Self.Health:SetStatusBarColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)

			if Self.HealPrediction.myBar then
				Self.HealPrediction.myBar:SetStatusBarColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
			end

			if Self.HealPrediction.otherBar then
				Self.HealPrediction.otherBar:SetStatusBarColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
			end

			if Self.Health.Health then
				Self.Health.Health:SetTextColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
			end
		end

		if Self.Power then
			Self.Power:SetStatusBarColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)

			if Self.Power.BackgroundBottom then
				Self.Power.BackgroundBottom:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
				Self.Power.BackgroundLeft:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
				Self.Power.BackgroundRight:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
				Self.Power.BackgroundTop:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
			end
		end

		if Self.Runes then
			Self.Runes.Background:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
		end

		if Self.WarlockSpecBars then
			Self.warlockSpecBarsBackground:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)

			for I = 1, #Self.WarlockSpecBars do
				Self.WarlockSpecBars[I]:SetStatusBarColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
			end
		end
	end

	Self:RegisterEvent('PLAYER_ENTER_COMBAT', Self.PostUpdate)
	Self:RegisterEvent('PLAYER_ENTERING_WORLD', Self.PostUpdate)
	Self:RegisterEvent('PLAYER_LEAVE_COMBAT', Self.PostUpdate)
	Self:RegisterEvent('UNIT_AURA', Self.PostUpdate)
	Self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', Self.PostUpdate)
end
