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

Configuration.Themes.Compact.Timers["PRIEST"] =
{
	Anchor = "BOTTOM",
	Height = 24,
	Width = 464,
	X = 26,
	Y = 270,

	[1] =
	{
		Priority = 99,
		ShowOnFocus = true,
		Spell = "Psychic Scream",
		Type = "Debuff",
		Unit = "Target",

		Color =
		{
			B = 132 / 255,
			G = 52 / 255,
			R = 24 / 255
		}
	},

	["DISCIPLINE"] =
	{
		Anchor = "TOP",
		AnchorToRaid = true,
		Y = 49,

		[1] =
		{
			Priority = 1,
			Spell = "Penance",
			Type = "Cooldown",

			Color =
			{
				B = 131 / 255,
				G = 1,
				R = 1
			}
		},

		[2] =
		{
			Priority = 2,
			Spell = "Holy Fire",
			Type = "Cooldown",

			Color =
			{
				B = 176 / 255,
				G = 234 / 255,
				R = 1
			}
		},

		[3] =
		{
			Priority = 3,
			Spell = "Evangelism",
			Type = "Buff",

			Color =
			{
				B = 167 / 255,
				G = 204 / 255,
				R = 1
			}
		},

		[4] =
		{
			Priority = 4,
			Spell = "Spirit Shell",
			Type = "Buff",

			Color =
			{
				B = 130 / 255,
				G = 34 / 255,
				R = 134 / 255
			}
		}
	},

	["SHADOW"] =
	{
		[1] =
		{
			Priority = 1,
			Spell = "Mind Blast",
			Type = "Cooldown",

			Color =
			{
				B = 251 / 255,
				G = 215 / 255,
				R = 245 / 255
			}
		},

		[2] =
		{
			Priority = 2,
			ShowOnFocus = true,
			Spell = "Vampiric Touch",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 146 / 255,
				G = 106 / 255,
				R = 14 / 255
			}
		},

		[3] =
		{
			Priority = 3,
			ShowOnFocus = true,
			Spell = "Shadow Word: Pain",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 0,
				G = 12 / 255,
				R = 214 / 255
			}
		},

		[4] =
		{
			Priority = 4,
			Spell = "Shadow Word: Death",
			Type = "Cooldown",

			Color =
			{
				B = 4 / 255,
				G = 4 / 255,
				R = 142 / 255
			}
		},

		[5] =
		{
			Priority = 5,
			ShowOnFocus = true,
			Spell = "Devouring Plague",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 186 / 255,
				G = 34 / 255,
				R = 192 / 255
			}
		},

		[6] =
		{
			Priority = 6,
			Spell = "Halo",
			Type = "Cooldown",

			Color =
			{
				B = 173 / 255,
				G = 85 / 255,
				R = 193 / 255
			}
		},

		[7] =
		{
			Priority = 6,
			Spell = "Divine Star",
			Type = "Cooldown",

			Color =
			{
				B = 247 / 255,
				G = 73 / 255,
				R = 148 / 255
			}
		},

		[8] =
		{
			Priority = 6,
			Spell = "Cascade",
			Type = "Cooldown",

			Color =
			{
				B = 247 / 255,
				G = 73 / 255,
				R = 148 / 255
			}
		},

		[9] =
		{
			Priority = 7,
			Spell = "Tempus Repit",
			Type = "Buff",
			Unit = "Player",

			Color =
			{
				B = 176 / 255,
				G = 222 / 255,
				R = 1
			}
		}
	}
}
