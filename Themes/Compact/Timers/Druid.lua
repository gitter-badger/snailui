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

Configuration.Themes.Compact.Timers["DRUID"] =
{
	Anchor = "BOTTOM",
	Height = 24,
	Width = 464,
	X = 26,
	Y = 242,

	["FERAL"] =
	{
		[1] =
		{
			Priority = 1,
			ShowOnFocus = true,
			Spell = "Rake",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 52 / 255,
				G = 68 / 255,
				R = 180 / 255
			}
		},

		[2] =
		{
			Priority = 2,
			ShowOnFocus = true,
			Spell = "Rip",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 10 / 255,
				G = 40 / 255,
				R = 180 / 255
			}
		},

		[3] =
		{
			Priority = 3,
			ShowOnFocus = true,
			Spell = "Savage Roar",
			Type = "Buff",

			Color =
			{
				B = 57 / 255,
				G = 128 / 255,
				R = 204 / 255
			}
		}
	}
}
