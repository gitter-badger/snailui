--
-- Copyright (C) 2012-2015 Snail <https://github.com/snail23/snailui/>
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
-- with this program. If not, see <http://www.gnu.org/licenses/>.

function HandleBattlegroundAutoRelease()
	local BattlegroundAutoRelease = CreateFrame("Frame", nil, UIParent)

	BattlegroundAutoRelease:RegisterEvent("PLAYER_DEAD")
	BattlegroundAutoRelease:RegisterEvent("PLAYER_ENTERING_WORLD")
	BattlegroundAutoRelease:SetScript("OnEvent",
		function(Self, Event)
			if Event == "PLAYER_DEAD" then
				local InInstance, InstanceType = IsInInstance()

				if InInstance then
					if InstanceType == "pvp" then
						RepopMe()
					end
				end
			else
				if StaticPopup1:IsShown() and ((not UnitIsDead("Player")) or (UnitIsDead("Player") and UnitIsGhost("Player"))) then
					StaticPopup_OnClick(StaticPopup1, StaticPopup1Button1:GetID())
				end
			end
		end
	)
end
