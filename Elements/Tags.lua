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

oUF.Tags.Events["SnailUI:EclipseDirection"] = "ECLIPSE_DIRECTION_CHANGE"
oUF.Tags.Events["SnailUI:DemonicFury"] = "UNIT_POWER"
oUF.Tags.Events["SnailUI:Health"] = "UNIT_HEALTH UNIT_HEAL_PREDICTION"
oUF.Tags.Events["SnailUI:SmallHealth"] = "UNIT_HEALTH UNIT_HEAL_PREDICTION"

oUF.Tags.Methods["SnailUI:EclipseDirection"] = function(Unit)
	local Direction = GetEclipseDirection()

	if Direction == "moon" then
		return "<-"
	elseif Direction == "sun" then
		return "->"
	end

	return nil
end

oUF.Tags.Methods["SnailUI:DemonicFury"] = function(Unit)
	return UnitPower("Player", SPELL_POWER_DEMONIC_FURY)
end

oUF.Tags.Methods["SnailUI:Health"] = function(Unit)
	local Health = Trim(GetUnitName(Unit, false))

	if math.floor(((UnitHealth(Unit) / UnitHealthMax(Unit)) * 100) + 0.5) < 100 then
		if UnitGetIncomingHeals(Unit) then
			Health = math.floor((((UnitHealth(Unit) + UnitGetIncomingHeals(Unit)) / UnitHealthMax(Unit)) * 100) + 0.5) .. "%"
		else
			Health = math.floor(((UnitHealth(Unit) / UnitHealthMax(Unit)) * 100) + 0.5) .. "%"
		end
	end

	if UnitIsDead(Unit) then
		Health = Trim(GetUnitName(Unit, false), " | Dead")
	end

	if UnitIsGhost(Unit) then
		Health = Trim(GetUnitName(Unit, false), " | Ghost")
	end

	if UnitIsAFK(Unit) then
		Health = Trim(GetUnitName(Unit, false), " | AFK")
	end

	if not UnitIsConnected(Unit) then
		Health = Trim(GetUnitName(Unit, false), " | D/C")
	end

	return Health
end

oUF.Tags.Methods["SnailUI:SmallHealth"] = function(Unit)
	local Health = Trim2(GetUnitName(Unit, false))

	if math.floor(((UnitHealth(Unit) / UnitHealthMax(Unit)) * 100) + 0.5) < 100 then
		if UnitGetIncomingHeals(Unit) then
			Health = math.floor((((UnitHealth(Unit) + UnitGetIncomingHeals(Unit)) / UnitHealthMax(Unit)) * 100) + 0.5) .. "%"
		else
			Health = math.floor(((UnitHealth(Unit) / UnitHealthMax(Unit)) * 100) + 0.5) .. "%"
		end
	end

	if UnitIsDead(Unit) then
		Health = "DEA"
	end

	if UnitIsGhost(Unit) then
		Health = "GHO"
	end

	if UnitIsAFK(Unit) then
		Health = "AFK"
	end

	if not UnitIsConnected(Unit) then
		Health = "D/C"
	end

	return Health
end
