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

function HandleGarbageCollector()
	local EventCount = 0
	local GarbageCollector = CreateFrame("Frame", nil, UIParent)

	GarbageCollector:RegisterAllEvents()
	GarbageCollector:SetScript("OnEvent",
		function(Self, Event)
			EventCount = EventCount + 1

			if (InCombatLockdown() and (EventCount > 25000)) or ((not InCombatLockdown()) and (EventCount > 10000)) or (Event == "PLAYER_ENTERING_WORLD") then
				collectgarbage("collect")
				EventCount = 0
			end
		end
	)
end
