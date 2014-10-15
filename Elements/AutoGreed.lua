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

function HandleAutoGreed()
	local AutoGreed = CreateFrame("Frame", nil, UIParent)
	
	AutoGreed:RegisterEvent("START_LOOT_ROLL")
	AutoGreed:SetScript("OnEvent",
		function(Self, Event, Id)
			local _, _, _, Quality, BoP = GetLootRollItemInfo(Id)

			if Id and (Quality == ITEM_QUALITY_UNCOMMON) and (not BoP) then
				RollOnLoot(Id, 2)
			end
		end
	)
end
