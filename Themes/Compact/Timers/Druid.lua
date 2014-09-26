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
	Y = 270,

	["BALANCE"] =
	{
		[1] =
		{
			Priority = 1,
			ShowOnFocus = true,
			Spell = "Moonfire",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 185 / 255,
				G = 85 / 255,
				R = 156 / 255
			}
		},

		[2] =
		{
			Priority = 2,
			ShowOnFocus = true,
			Spell = "Sunfire",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 59 / 255,
				G = 169 / 255,
				R = 1
			}
		},

		[3] =
		{
			Priority = 3,
			Spell = "Starsurge",
			Type = "Cooldown",

			Color =
			{
				B = 1,
				G = 74 / 255,
				R = 216 / 255
			}
		},

		[4] =
		{
			Priority = 4,
			Spell = "Starfall",
			Type = "Cooldown",

			Color =
			{
				B = 243 / 255,
				G = 192 / 255,
				R = 187 / 255
			}
		}
	},

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
	},

	["RESTORATION"] =
	{
		Anchor = "TOP",
		AnchorToRaid = true,
		Y = 49,

		[1] =
		{
			Priority = 1,
			Spell = "Swiftmend",
			Type = "Cooldown",

			Color =
			{
				B = 155 / 255,
				G = 124 / 255,
				R = 45 / 255
			}
		},

		[2] =
		{
			Priority = 2,
			Spell = "Wild Growth",
			Type = "Cooldown",

			Color =
			{
				B = 99 / 255,
				G = 219 / 255,
				R = 132 / 255
			}
		},

		[3] =
		{
			Priority = 3,
			Spell = "Sage Mender",
			Type = "Buff",

			Color =
			{
				B = 8 / 255,
				G = 247 / 255,
				R = 149 / 255
			}
		}
	}
}
