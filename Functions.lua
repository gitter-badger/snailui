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

local _

function AddPet(Pets, PlayerGUID, PetGUID)
	if Pets and PlayerGUID and PetGUID then
		if not Pets[PlayerGUID] then
			Pets[PlayerGUID] = {}
		end

		Pets[PlayerGUID][#Pets[PlayerGUID] + 1] = PetGUID
	end
end

function Blank()
end

function DeepCopy(Object)
	local Table = {}

	local function Copy(Object)
		if type(Object) ~= "table" then
			return Object
		elseif Table[Object] then
			return Table[Object]
		end

		local NewTable = {}
		Table[Object] = NewTable

		for Key, Value in pairs(Object) do
			NewTable[Copy(Key)] = Copy(Value)
		end

		return setmetatable(NewTable, getmetatable(Object))
	end

	return Copy(Object)
end

function Dump(Object, Name, Depth)
	if not Depth then
		Depth = 0
	end

	if not Name then
		Name = "Parent"
	end

	local Prefix = ""

	for I = 1, Depth do
		Prefix = Prefix .. "-"
	end

	print(Prefix .. Name)

	for Index, Value in pairs(Object) do
		if type(Value) == "table" then
			Dump(Value, Index, Depth + 1)
		elseif type(Value) == "userdata" then
			Dump({Value}, Index, Depth + 1)
		end
	end
end

function GetAbsorb(Absorbs, GUID, Spell, SourceGUID)
	if Absorbs[GUID] then
		for Index, Absorb in pairs(Absorbs[GUID]) do
			if Absorb.Spell == Spell then
				if SourceGUID then
					if Absorb.SourceGUID == SourceGUID then
						return Absorb, Index
					end
				else
					return Absorb, Index
				end
			end
		end
	else
		Absorbs[GUID] = {}
	end

	return nil, nil
end

function GetActiveTime(Time)
	if Time > 60 then
		local Seconds = math.floor((Time % 60) + 0.5)

		if Seconds > 0 then
			return " (" .. math.floor((Time / 60) + 0.5) .. "m " .. Seconds .. "s)"
		else
			return " (" .. math.floor((Time / 60) + 0.5) .. "m)"
		end
	else
		return " (" .. math.floor(Time + 0.5) .. "s)"
	end
end

function GetConfiguration()
	local Class = select(2, UnitClass("Player"))
	local Specialization = GetSpecialization()

	if Specialization then
		Specialization = select(2, GetSpecializationInfo(Specialization))
		Specialization = Specialization:gsub("(.)", string.upper)
	else
		Specialization = nil
	end

	if Configuration.Themes[Options.Theme] then
		if Configuration.Themes[Options.Theme][Class] then
			if Specialization then
				if Configuration.Themes[Options.Theme][Class][Specialization] then
					return Configuration.Themes[Options.Theme][Class][Specialization]
				end
			end

			return Configuration.Themes[Options.Theme][Class]
		end

		return Configuration.Themes[Options.Theme]
	end

	return Configuration.Themes[Configuration.Theme]
end

function GetCount(Fights, Mode)
	local Count = 0

	for I = 1, #Fights do
		if Fights[I][Mode] > 0 then
			Count = Count + 1
		end
	end

	return Count
end

function GetDispel(Dispels, Type)
	for _, Dispel in ipairs(Dispels) do
		if Dispel == Type then
			return Dispel
		end
	end

	return nil
end

function GetDuration(Time)
	if (((Time / 60) / 60) / 24) >= 1 then
		return math.ceil(((Time / 60) / 60) / 24) .. "D"
	elseif ((Time / 60) / 60) >= 1 then
		return math.ceil((Time / 60) / 60) .. "H"
	elseif (Time / 60) >= 1 then
		return math.ceil(Time / 60) .. "M"
	end

	return math.ceil(Time)
end

function GetPetOwner(Pets, GUID)
	if Pets and GUID then
		for PlayerGUID, Player in pairs(Pets) do
			for _, PetGUID in ipairs(Player) do
				if PetGUID == GUID then
					return PlayerGUID
				end
			end
		end
	end

	return nil
end

function GetSpell(Spells, SpellName)
	for _, Spell in ipairs(Spells) do
		if Spell.SpellName == SpellName then
			return Spell
		end
	end

	return nil
end

function ShortNumber(Number)
	if Number > 999999 then
		return string.format("%.1fM", Number / 1000000)
	elseif Number > 999 then
		return string.format("%.1fK", Number / 1000)
	end

	return math.floor(Number)
end

function Trim(String1, String2)
	if String2 then
		if (String1:len() + String2:len()) > 12 then
			return String1:sub(1, 9 - String2:len()) .. "..." .. String2
		end

		return String1 .. String2
	end

	if String1:len() > 12 then
		return String1:sub(1, 9) .. "..."
	end

	return String1
end

function Trim2(String)
	if String:len() > 3 then
		return String:sub(1, 3)
	end

	return String
end

function Trim3(String1)
	if String1:len() > 9 then
		return String1:sub(1, 7) .. "..."
	end

	return String1
end

function GetUnit(Fights, GUID)
	if Fights and GUID then
		for _, Unit in ipairs(Fights) do
			if Unit.GUID == GUID then
				return Unit
			end
		end
	end

	return nil
end
