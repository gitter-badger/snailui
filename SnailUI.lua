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

local Version = "1.2.1"

oUF:RegisterStyle("SnailUI",
	function(Self, Unit)
		Unit = Unit:gsub("(.)", string.upper, 1)

		if GetConfiguration()[Unit] then
			Self.Frame = Unit

			HandleBurningEmbersBar(Self)
			HandleCastingBar(Self)
			HandleChiBar(Self)
			HandleColors(Self)
			HandleComboPointsBar(Self)
			HandleDebuffIndicators(Self)
			HandleDemonicFuryBar(Self)
			HandleEclipseBar(Self)
			HandleHealingIndicators(Self)
			HandleHealthBar(Self)
			HandleHolyPowerBar(Self)
			HandlePortrait(Self)
			HandlePowerBar(Self)
			HandleRunesBar(Self)
			HandleShadowOrbsBar(Self)
			HandleSoulShardsBar(Self)
			HandleSpellRange(Self)
			HandleUnit(Self)
		end
	end
)

oUF:Factory(
	function(Self)
		if GetConfiguration().Initialize then
			GetConfiguration():Initialize()
		end

		HandleActionBars()
		HandleAutoGreed()
		HandleBag()
		HandleBank()
		HandleBattlegroundAutoRelease()
		HandleBlizzardFrames()
		HandleBuffs()
		HandleChat()
		HandleConsoleVariables()
		HandleExperienceBar()
		HandleExtraButton()
		HandleFocus(Self)
		HandleFocusTarget(Self)
		HandleGarbageCollector()
		HandleInterfaceOptions(Version)
		HandleMeter()
		HandleMinimap()
		HandlePet(Self)
		HandlePlayer(Self)
		HandleRaid(Self)
		HandleTarget(Self)
		HandleTargetTarget(Self)
		HandleTimers()
		HandleTimerTrackers()
		HandleTooltips()
		HandleVendorAutoRepair()

		Self:SetActiveStyle("SnailUI")
	end
)
