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

local FocusX = math.floor(GetScreenWidth() / 4)

Configuration.Themes.Default =
{
	ActionBars =
	{
		Player =
		{
			Anchor = "BOTTOM",
			Buttons = 10,
			Height = 24,
			Width = 48,
			X = 0,
			Y = 127,

			TextureCoordinate =
			{
				Bottom = 0.7,
				Left = 0.1,
				Right = 0.9,
				Top = 0.3
			}
		},

		Player2 =
		{
			Anchor = "BOTTOM",
			Buttons = 10,
			Height = 24,
			UIParent = true,
			Width = 48,
			X = 0,
			Y = 155,

			TextureCoordinate =
			{
				Bottom = 0.7,
				Left = 0.1,
				Right = 0.9,
				Top = 0.3
			}
		},

		Player3 =
		{
			Anchor = "RIGHT",
			Buttons = 12,
			Height = 32,
			Orientation = "VERTICAL",
			UIParent = true,
			Width = 32,
			X = -4,
			Y = 0,

			TextureCoordinate =
			{
				Bottom = 0.9,
				Left = 0.1,
				Right = 0.9,
				Top = 0.1
			}
		},

		Player4 =
		{
			Anchor = "RIGHT",
			Buttons = 12,
			Height = 32,
			Orientation = "VERTICAL",
			UIParent = true,
			Width = 32,
			X = -40,
			Y = 0,

			TextureCoordinate =
			{
				Bottom = 0.9,
				Left = 0.1,
				Right = 0.9,
				Top = 0.1
			}
		}
	},

	Bag =
	{
		Anchor = "BOTTOMRIGHT",
		Columns = 8,
		Height = 24,
		Width = 48,
		X = -5,
		Y = 5,

		TextureCoordinate =
		{
			Bottom = 0.7,
			Left = 0.1,
			Right = 0.9,
			Top = 0.3
		}
	},

	Bank =
	{
		Anchor = "BOTTOMLEFT",
		Columns = 7,
		Height = 24,
		Width = 48,
		X = 5,
		Y = 5,

		TextureCoordinate =
		{
			Bottom = 0.7,
			Left = 0.1,
			Right = 0.9,
			Top = 0.3
		}
	},

	Buffs =
	{
		Anchor = "RIGHT",
		Height = 32,
		Orientation = "VERTICAL",
		Width = 32,
		X = -76,
		Y = 0,

		TextureCoordinate =
		{
			Bottom = 0.9,
			Left = 0.1,
			Right = 0.9,
			Top = 0.1
		}
	},

	Chat =
	{
		Anchor = "BOTTOM",
		Height = 119,
		Width = 256,
		X = -130,
		Y = 9
	},

	DebuffIndicators =
	{
		TextureCoordinate =
		{
			Bottom = 0.9,
			Left = 0.1,
			Right = 0.9,
			Top = 0.1
		}
	},

	ExperienceBar =
	{
		Anchor = "TOP",
		Height = 8,
		Width = 204,
		X = 0,
		Y = -28
	},

	ExtraButton =
	{
		Anchor = "TOP",
		Height = 24,
		HoverToShow = true,
		Width = 204,
		X = 0,
		Y = -6
	},

	Focus =
	{
		Anchor = "LEFT",
		Height = 24,
		Width = 256,
		X = FocusX,
		Y = 0,

		CastingBar =
		{
			Anchor = "TOPLEFT",
			Height = 24,
			Orientation = "HORIZONTAL",
			Width = 204,
			X = 55,
			Y = 25,

			Spell =
			{
				Duration =
				{
					Anchor = "RIGHT",
					X = -4,
					Y = 0
				},

				Name =
				{
					Anchor = "LEFT",
					X = 6,
					Y = 0
				},

				Texture =
				{
					Anchor = "LEFT",
					Height = 24,
					Width = 48,
					X = -52,
					Y = 0,

					TextureCoordinate =
					{
						Bottom = 0.7,
						Left = 0.1,
						Right = 0.9,
						Top = 0.3
					}
				}
			}
		},

		HealthBar =
		{
			Anchor = "TOP",
			Height = 15,
			Orientation = "HORIZONTAL",
			Width = 252,
			X = 0,
			Y = -3,

			Health =
			{
				Anchor ="CENTER",
				X = 1,
				Y = 0
			}
		},

		PowerBar =
		{
			Anchor = "BOTTOM",
			Height = 4,
			Orientation = "HORIZONTAL",
			Width = 252,
			X = 0,
			Y = 3
		}
	},

	Initialize = function(Self)
		Configuration.Themes[Options.Theme]["DEATHKNIGHT"]			= _G[Options.Theme .. "WithClassBar"]
		Configuration.Themes[Options.Theme]["DEATHKNIGHT"]["UNHOLY"]		= _G[Options.Theme .. "WithClassBarWithPet"]
		Configuration.Themes[Options.Theme]["DRUID"]				= Configuration.Themes[Options.Theme]
		Configuration.Themes[Options.Theme]["DRUID"]["BALANCE"]			= _G[Options.Theme .. "WithClassBar"]
		Configuration.Themes[Options.Theme]["DRUID"]["FERAL"]			= _G[Options.Theme .. "WithClassBar"]
		Configuration.Themes[Options.Theme]["DRUID"]["RESTORATION"]		= _G[Options.Theme .. "Healer"]
		Configuration.Themes[Options.Theme]["HUNTER"]				= _G[Options.Theme .. "WithClassBarWithPet"]
		Configuration.Themes[Options.Theme]["MAGE"]				= Configuration.Themes[Options.Theme]
		Configuration.Themes[Options.Theme]["MAGE"]["FROST"]			= _G[Options.Theme .. "WithPet"]
		Configuration.Themes[Options.Theme]["MONK"]				= _G[Options.Theme .. "WithClassBar"]
		Configuration.Themes[Options.Theme]["MONK"]["MISTWEAVER"]		= _G[Options.Theme .. "HealerWithClassBar"]
		Configuration.Themes[Options.Theme]["PALADIN"]				= _G[Options.Theme .. "WithClassBar"]
		Configuration.Themes[Options.Theme]["PALADIN"]["HOLY"]			= _G[Options.Theme .. "HealerWithClassBar"]
		Configuration.Themes[Options.Theme]["PRIEST"]				= _G[Options.Theme .. "Healer"]
		Configuration.Themes[Options.Theme]["PRIEST"]["SHADOW"]			= _G[Options.Theme .. "WithClassBar"]
		Configuration.Themes[Options.Theme]["ROGUE"]				= _G[Options.Theme .. "WithClassBar"]
		Configuration.Themes[Options.Theme]["SHAMAN"]				= Configuration.Themes[Options.Theme]
		Configuration.Themes[Options.Theme]["SHAMAN"]["RESTORATION"]		= _G[Options.Theme .. "Healer"]
		Configuration.Themes[Options.Theme]["WARLOCK"]				= _G[Options.Theme .. "WithPet"]
		Configuration.Themes[Options.Theme]["WARLOCK"]["AFFLICTION"]		= _G[Options.Theme .. "WithClassBarWithPet"]
		Configuration.Themes[Options.Theme]["WARLOCK"]["DEMONOLOGY"]		= _G[Options.Theme .. "WithClassBarWithPet"]
		Configuration.Themes[Options.Theme]["WARLOCK"]["DESTRUCTION"]		= _G[Options.Theme .. "WithClassBarWithPet"]
		Configuration.Themes[Options.Theme]["WARRIOR"]				= _G[Options.Theme .. "WithClassBar"]

		local Class = select(2, UnitClass("Player"))
		local Specialization = GetSpecialization()

		if Specialization then
			Specialization = select(2, GetSpecializationInfo(Specialization))
			Specialization = Specialization:gsub("(.)", string.upper)
		end

		if Class == "HUNTER" then
			if Specialization ~= "BEAST MASTERY" then
				local _, _, _, Selected = GetTalentInfo(7, 3, GetActiveSpecGroup())

				if Selected == true then
					Configuration.Themes[Options.Theme]["HUNTER"] = _G[Options.Theme .. "WithClassBar"]
				end
			end
		elseif Class == "MONK" then
			local _, _, _, Selected = GetTalentInfo(3, 2, GetActiveSpecGroup())

			if Selected == true then
				GetConfiguration().Player.ChiBar = GetConfiguration().Player.ChiBar5
				
				if IsSpellKnown(157411) and (Specialization == "WINDWALKER") then
					GetConfiguration().Player.ChiBar = GetConfiguration().Player.ChiBar6
				end
			elseif IsSpellKnown(157411) and (Specialization == "WINDWALKER") then
				GetConfiguration().Player.ChiBar = GetConfiguration().Player.ChiBar5
			end
		elseif Class == "PALADIN" then
			local Level = UnitLevel("Player")

			if Level and (Level >= 85) then
				GetConfiguration().Player.HolyPowerBar = GetConfiguration().Player.HolyPowerBar5
			end
		elseif (Class == "PRIEST") and (Specialization == "SHADOW") then
			if IsSpellKnown(157217) then
				GetConfiguration().Player.ShadowOrbsBar = GetConfiguration().Player.ShadowOrbsBar5
			end
		elseif Class == "WARLOCK" then
			if Specialization ~= "DEMONOLOGY" then
				local _, _, _, Selected = GetTalentInfo(5, 3, GetActiveSpecGroup())

				if Selected == true then
					Configuration.Themes[Options.Theme]["WARLOCK"] = _G[Options.Theme .. "WithClassBar"]
				end
			end
		end
		
		if (Class == "HUNTER") or ((Class == "DRUID") and (Specialization == "GUARDIAN")) or (Class == "WARRIOR") then
			Configuration.Themes[Options.Theme][Class].Player.PowerBar.Border = true
			Configuration.Themes[Options.Theme][Class].Player.PowerBar.Height = 24
			Configuration.Themes[Options.Theme][Class].Player.PowerBar.Width = 516
			Configuration.Themes[Options.Theme][Class].Player.PowerBar.Y = 25
		end

		if not Options.EnableSideBars then
			GetConfiguration().ActionBars.Player3 = nil
			GetConfiguration().ActionBars.Player4 = nil
			GetConfiguration().Buffs.X = GetConfiguration().Buffs.X + 72
		end

		return Class, Specialization
	end,

	Meter =
	{
		Anchor = "BOTTOM",
		Height = 119,
		Width = 152,
		X = 78,
		Y = 7,

		[0] =
		{
			Height = 24,
			Width = 152
		},

		[1] =
		{
			Height = 22,
			Width = 152
		},

		[2] =
		{
			Height = 22,
			Width = 152
		},

		[3] =
		{
			Height = 22,
			Width = 152
		},

		[4] =
		{
			Height = 22,
			Width = 152
		},

		[5] =
		{
			Height = 22,
			Width = 152
		}
	},

	Minimap =
	{
		Anchor = "BOTTOM",
		Height = 100,
		Width = 100,
		X = 208,
		Y = 26,

		Calender =
		{
			Anchor ="TOPRIGHT",
			X = 0,
			Y = 0
		},

		Clock =
		{
			Anchor ="BOTTOM",
			X = 2,
			Y = 5
		},

		Info =
		{
			Anchor = "BOTTOM",
			Height = 22,
			Width = 100,
			X = 0,
			Y = -19,

			FPS =
			{
				Anchor = "LEFT",
				X = 5,
				Y = 0
			},

			Latency =
			{
				Anchor = "RIGHT",
				X = -2,
				Y = 0
			}
		},

		Mail =
		{
			Anchor ="BOTTOMRIGHT",
			X = 1,
			Y = -2
		},

		Tracking =
		{
			Anchor ="TOPLEFT",
			X = -1,
			Y = 0
		},

		QueueStatus =
		{
			Anchor ="BOTTOMLEFT",
			X = 0,
			Y = 0
		},
	},

	Player =
	{
		Anchor = "BOTTOM",
		Height = 24,
		Width = 256,
		X = -130,
		Y = 183,

		CastingBar =
		{
			Anchor = "TOPLEFT",
			Height = 24,
			Orientation = "HORIZONTAL",
			Width = 464,
			X = 55,
			Y = 25,

			Spell =
			{
				Duration =
				{
					Anchor = "RIGHT",
					X = -4,
					Y = 0
				},

				Name =
				{
					Anchor = "LEFT",
					X = 6,
					Y = 0
				},

				Texture =
				{
					Anchor = "LEFT",
					Height = 24,
					Width = 48,
					X = -52,
					Y = 0,

					TextureCoordinate =
					{
						Bottom = 0.7,
						Left = 0.1,
						Right = 0.9,
						Top = 0.3
					}
				}
			}
		},

		HealthBar =
		{
			Anchor = "TOP",
			Height = 15,
			Orientation = "HORIZONTAL",
			Width = 252,
			X = 0,
			Y = -3,

			Health =
			{
				Anchor ="CENTER",
				X = 1,
				Y = 0
			}
		},

		PowerBar =
		{
			Anchor = "BOTTOM",
			Height = 4,
			Orientation = "HORIZONTAL",
			Width = 252,
			X = 0,
			Y = 3
		}
	},

	Raid =
	{
		Anchor = "LEFT",
		ColumnAnchor = "LEFT",
		Columns = 4,
		ColumnSpacing = 4,
		ColumnX = 4,
		ColumnY = -4,
		GroupBY = "ROLE",
		GroupOrder = "TANK, HEALER, DAMAGER",
		HealthThreshold = 90,
		Height = 32,
		Rows = 10,
		ShowParty = true,
		ShowPlayer = true,
		ShowRaid = true,
		ShowSolo = true,
		Width = 32,
		X = 4,
		Y = 0,

		HealthBar =
		{
			Anchor = "CENTER",
			Height = 28,
			Orientation = "VERTICAL",
			Width = 28,
			X = 0,
			Y = 0,

			Health =
			{
				Anchor ="CENTER",
				SmallText = true,
				X = 1,
				Y = 0
			}
		}
	},

	Target =
	{
		Anchor = "BOTTOM",
		Height = 24,
		Width = 256,
		X = 130,
		Y = 183,

		HealthBar =
		{
			Anchor = "TOP",
			Height = 15,
			Orientation = "HORIZONTAL",
			Width = 252,
			X = 0,
			Y = -3,

			Health =
			{
				Anchor ="CENTER",
				X = 1,
				Y = 0
			}
		},

		PowerBar =
		{
			Anchor = "BOTTOM",
			Height = 4,
			Orientation = "HORIZONTAL",
			Width = 252,
			X = 0,
			Y = 3
		}
	},

	TimerTrackers =
	{
		Anchor = "TOP",
		Height = 24,
		Width = 204,
		X = 0,
		Y = -33
	}
}
