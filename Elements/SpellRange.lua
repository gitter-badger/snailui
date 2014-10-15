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

function HandleSpellRange(Self)
	Self.SpellRange =
	{
		Update = function(Self, InRange)
			if Configuration.InactiveAlpha then
				if UnitIsUnit(Self.unit, "Player") then
					InRange = true
				end

				if InRange then
					Self:SetAlpha(1)
					Self.InRange = InRange

					if GetConfiguration()[Self.Frame].HealthThreshold then
						if (not Self.ShowFull) and (not Self.ShowingDebuffIndicators) and (math.floor(((UnitHealth(Self.unit) / UnitHealthMax(Self.unit)) * 100) + 0.5) >= GetConfiguration()[Self.Frame].HealthThreshold) then
							Self:SetAlpha(Configuration.InactiveAlpha)
						end
					end
				else
					Self:SetAlpha(Configuration.InactiveAlpha)
					Self.InRange = nil
				end
			end
		end
	}

	if GetConfiguration()[Self.Frame].HealthThreshold then
		Self:RegisterEvent("UNIT_HEALTH",
			function(Self)
				Self:SetAlpha(Configuration.InactiveAlpha)

				if Self.ShowFull or Self.ShowingDebuffIndicators or (math.floor(((UnitHealth(Self.unit) / UnitHealthMax(Self.unit)) * 100) + 0.5) < GetConfiguration()[Self.Frame].HealthThreshold) then
					if Self.InRange then
						Self:SetAlpha(1)
					end
				end
			end
		)
	end
end
