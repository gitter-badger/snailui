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
	}
}
