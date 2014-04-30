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

Configuration.Themes.Compact.Timers["MONK"] =
{
	Anchor = "BOTTOM",
	Height = 24,
	Width = 464,
	X = 26,
	Y = 242,

	["MISTWEAVER"] =
	{
		Anchor = "TOP",
		AnchorToRaid = true,
		Y = 49,
		
		[1] =
		{
			Priority = 1,
			Spell = "Expel Harm",
			Type = "Cooldown",

			Color =
			{
				B = 165 / 255,
				G = 190 / 255,
				R = 8 / 255
			}
		},

		[2] =
		{
			Priority = 2,
			Spell = "Renewing Mist",
			Type = "Cooldown",

			Color =
			{
				B = 141 / 255,
				G = 186 / 255,
				R = 57 / 255
			}
		},

		[3] =
		{
			Priority = 3,
			Spell = "Chi Wave",
			Type = "Cooldown",

			Color =
			{
				B = 223 / 255,
				G = 251 / 255,
				R = 61 / 255
			}
		},

		[4] =
		{
			Priority = 4,
			Spell = "Mana Tea",
			Type = "Cooldown",

			Color =
			{
				B = 1,
				G = 165 / 255,
				R = 13 / 255
			}
		}
	},

	["WINDWALKER"] =
	{
		[1] =
		{
			Priority = 1,
			Spell = "Tiger Power",
			Type = "Buff",

			Color =
			{
				B = 175 / 255,
				G = 218 / 255,
				R = 8 / 255
			}
		}
	}
}
