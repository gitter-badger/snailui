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

Configuration.Themes.Compact.Timers["HUNTER"] =
{
	Anchor = "BOTTOM",
	Height = 24,
	Width = 464,
	X = 26,
	Y = 298,

	[1] =
	{
		Priority = 1,
		ShowOnFocus = true,
		Spell = "Serpent Sting",
		Type = "Debuff",
		Unit = "Target",

		Color =
		{
			B = 30 / 255,
			G = 115 / 255,
			R = 79 / 255
		}
	},

	["SURVIVAL"] =
	{
		[1] =
		{
			Priority = 2,
			ShowOnFocus = true,
			Spell = "Explosive Shot",
			Type = "Cooldown",

			Color =
			{
				B = 33 / 255,
				G = 138 / 255,
				R = 235 / 255
			}
		},

		[2] =
		{
			Priority = 3,
			ShowOnFocus = true,
			Spell = "Black Arrow",
			Type = "Cooldown",

			Color =
			{
				B = 185 / 255,
				G = 0,
				R = 102 / 255
			}
		},

		[3] =
		{
			Priority = 4,
			Spell = "Dire Beast",
			Type = "Cooldown",

			Color =
			{
				B = 124 / 255,
				G = 107 / 255,
				R = 66 / 255
			}
		},

		[4] =
		{
			Priority = 5,
			Spell = "Kill Shot",
			Type = "Cooldown",

			Color =
			{
				B = 33 / 255,
				G = 22 / 255,
				R = 179 / 255
			}
		}
	}
}
