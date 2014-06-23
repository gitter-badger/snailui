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

Configuration.Themes.Compact.Timers["PALADIN"] =
{
	Anchor = "BOTTOM",
	Height = 24,
	Width = 464,
	X = 26,
	Y = 242,

	[1] =
	{
		Priority = 1,
		Spell = "Crusader Strike",
		Type = "Cooldown",

		Color =
		{
			B = 87 / 255,
			G = 245 / 255,
			R = 254 / 255
		}
	},

	[2] =
	{
		Priority = 2,
		Spell = "Judgment",
		Type = "Cooldown",

		Color =
		{
			B = 74 / 255,
			G = 186 / 255,
			R = 222 / 255
		}
	},

	[3] =
	{
		Priority = 3,
		Spell = "Exorcism",
		Type = "Cooldown",

		Color =
		{
			B = 0,
			G = 114 / 255,
			R = 231 / 255
		}
	},

	[4] =
	{
		Priority = 4,
		Spell = "Hammer of Wrath",
		Type = "Cooldown",

		Color =
		{
			B = 223 / 255,
			G = 218 / 255,
			R = 57 / 255
		}
	},

	["HOLY"] =
	{
		Anchor = "TOP",
		AnchorToRaid = true,
		Y = 49,

		[1] =
		{
			Priority = 5,
			Spell = "Holy Shock",
			Type = "Cooldown",

			Color =
			{
				B = 218 / 255,
				G = 251 / 255,
				R = 1
			}
		}
	},

	["RETRIBUTION"] =
	{
		[1] =
		{
			Priority = 5,
			Spell = "Inquisition",
			Type = "Buff",

			Color =
			{
				B = 149 / 255,
				G = 251 / 255,
				R = 1
			}
		}
	}
}
