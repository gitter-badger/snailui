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

Configuration.Themes.Compact.Timers["DEATHKNIGHT"] =
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
		Spell = "Blood Plague",
		Type = "Debuff",
		Unit = "Target",

		Color =
		{
			B = 220 / 255,
			G = 3 / 255,
			R = 193 / 255
		}
	},

	[2] =
	{
		Priority = 2,
		ShowOnFocus = true,
		Spell = "Frost Fever",
		Type = "Debuff",
		Unit = "Target",

		Color =
		{
			B = 1,
			G = 252 / 255,
			R = 33 / 255
		}
	},

	[3] =
	{
		Priority = 3,
		Spell = "Death and Decay",
		Type = "Cooldown",

		Color =
		{
			B = 18 / 255,
			G = 43 / 255,
			R = 141 / 255
		}
	},

	[4] =
	{
		Priority = 4,
		Spell = "Plague Leech",
		Type = "Cooldown",

		Color =
		{
			B = 38 / 255,
			G = 170 / 255,
			R = 63 / 255
		}
	},

	[5] =
	{
		Priority = 5,
		Spell = "Soul Reaper",
		Type = "Cooldown",

		Color =
		{
			B = 160 / 255,
			G = 137 / 255,
			R = 74 / 255
		}
	},

	["FROST"] =
	{
		[1] =
		{
			Priority = 6,
			Spell = "Pillar of Frost",
			Type = "Buff",

			Color =
			{
				B = 234 / 255,
				G = 179 / 255,
				R = 98 / 255
			}
		}
	}
}
