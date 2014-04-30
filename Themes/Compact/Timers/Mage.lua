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

Configuration.Themes.Compact.Timers["MAGE"] =
{
	Anchor = "BOTTOM",
	Height = 24,
	Width = 464,
	X = 26,
	Y = 242,

	[1] =
	{
		Priority = 1,
		ShowOnFocus = true,
		Spell = "Living Bomb",
		Type = "Debuff",
		Unit = "Target",

		Color =
		{
			B = 16 / 255,
			G = 204 / 255,
			R = 247 / 255
		}
	},

	["FIRE"] =
	{
		[1] =
		{
			Priority = 2,
			ShowAmount = true,
			ShowOnFocus = true,
			Spell = "Ignite",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 20 / 255,
				G = 101 / 255,
				R = 230 / 255
			}
		},

		[2] =
		{
			Priority = 3,
			Spell = "Inferno Blast",
			Type = "Cooldown",

			Color =
			{
				B = 13 / 255,
				G = 33 / 255,
				R = 220 / 255
			}
		},

		[3] =
		{
			Priority = 4,
			ShowAmount = true,
			ShowOnFocus = true,
			Spell = "Combustion",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 6 / 255,
				G = 158 / 255,
				R = 223 / 255
			}
		}
	},

	["FROST"] =
	{
		Y = 270,

		[1] =
		{
			Priority = 2,
			Spell = "Frozen Orb",
			Type = "Cooldown",

			Color =
			{
				B = 252 / 255,
				G = 190 / 255,
				R = 38 / 255
			}
		},

		[2] =
		{
			Priority = 3,
			Spell = "Icy Veins",
			Type = "Buff",

			Color =
			{
				B = 1,
				G = 196 / 255,
				R = 77 / 255
			}
		}
	}
}
