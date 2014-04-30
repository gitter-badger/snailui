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

Configuration.Themes.Compact.Timers["ROGUE"] =
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
		Spell = "Garrote",
		Type = "Debuff",
		Unit = "Target",

		Color =
		{
			B = 0,
			G = 13 / 255,
			R = 87 / 255
		}
	},

	[2] =
	{
		Priority = 2,
		ShowOnFocus = true,
		Spell = "Rupture",
		Type = "Debuff",
		Unit = "Target",

		Color =
		{
			B = 41 / 255,
			G = 32 / 255,
			R = 206 / 255
		}
	},

	[3] =
	{
		Priority = 3,
		ShowOnFocus = true,
		Spell = "Crimson Tempest",
		Type = "Debuff",
		Unit = "Target",

		Color =
		{
			B = 30 / 255,
			G = 40 / 255,
			R = 198 / 255
		}
	},

	[4] =
	{
		Priority = 4,
		Spell = "Slice and Dice",
		Type = "Buff",

		Color =
		{
			B = 0,
			G = 85 / 255,
			R = 204 / 255
		}
	},

	[5] =
	{
		Priority = 90,
		Spell = "Recuperate",
		Type = "Buff",

		Color =
		{
			B = 107 / 255,
			G = 142 / 255,
			R = 41 / 255
		}
	},

	[6] =
	{
		Priority = 91,
		Spell = "Feint",
		Type = "Buff",

		Color =
		{
			B = 179 / 255,
			G = 142 / 255,
			R = 100 / 255
		}
	},

	[7] =
	{
		Priority = 92,
		ShowOnFocus = true,
		Spell = "Gouge",
		Type = "Debuff",
		Unit = "Target",

		Color =
		{
			B = 215 / 255,
			G = 212 / 255,
			R = 213 / 255
		}
	},

	[8] =
	{
		Priority = 93,
		ShowOnFocus = true,
		Spell = "Garrote - Silence",
		Type = "Debuff",
		Unit = "Target",

		Color =
		{
			B = 0,
			G = 13 / 255,
			R = 87 / 255
		}
	},

	[9] =
	{
		Priority = 94,
		ShowOnFocus = true,
		Spell = "Cheap Shot",
		Type = "Debuff",
		Unit = "Target",

		Color =
		{
			B = 147 / 255,
			G = 168 / 255,
			R = 193 / 255
		}
	},

	[10] =
	{
		Priority = 95,
		ShowOnFocus = true,
		Spell = "Kidney Shot",
		Type = "Debuff",
		Unit = "Target",

		Color =
		{
			B = 144 / 255,
			G = 197 / 255,
			R = 1
		}
	},

	[11] =
	{
		Priority = 96,
		ShowOnFocus = true,
		Spell = "Blind",
		Type = "Debuff",
		Unit = "Target",

		Color =
		{
			B = 173 / 255,
			G = 211 / 255,
			R = 247 / 255
		}
	},

	[12] =
	{
		Priority = 97,
		ShowOnFocus = true,
		Spell = "Dismantle",
		Type = "Debuff",
		Unit = "Target",

		Color =
		{
			B = 112 / 255,
			G = 230 / 255,
			R = 235 / 255
		}
	},

	[13] =
	{
		Priority = 98,
		ShowOnFocus = true,
		Spell = "Sap",
		Type = "Debuff",
		Unit = "Target",

		Color =
		{
			B = 167 / 255,
			G = 168 / 255,
			R = 167 / 255
		}
	},

	[14] =
	{
		Priority = 99,
		Spell = "Subterfuge",
		Type = "Buff",

		Color =
		{
			B = 132 / 255,
			G = 103 / 255,
			R = 79 / 255
		}
	},

	["ASSASSINATION"] =
	{
		[1] =
		{
			Priority = 5,
			Spell = "Envenom",
			Type = "Buff",

			Color =
			{
				B = 0,
				G = 153 / 255,
				R = 0
			}
		},

		[2] =
		{
			Priority = 6,
			ShowOnFocus = true,
			Spell = "Vendetta",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 0,
				G = 0,
				R = 139 / 255
			}
		},

		[3] =
		{
			Priority = 7,
			Spell = "Shadow Blades",
			Type = "Buff",

			Color =
			{
				B = 1,
				G = 0,
				R = 143 / 255
			}
		}
	},

	["COMBAT"] =
	{
		[1] =
		{
			Priority = 5,
			ShowOnFocus = true,
			Spell = "Revealing Strike",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 147 / 255,
				G = 164 / 255,
				R = 175 / 255
			}
		},

		[2] =
		{
			Priority = 6,
			Spell = "Shallow Insight",
			Type = "Buff",

			Color =
			{
				B = 0,
				G = 153 / 255,
				R = 0
			}
		},

		[3] =
		{
			Priority = 6,
			Spell = "Moderate Insight",
			Type = "Buff",

			Color =
			{
				B = 93 / 255,
				G = 236 / 255,
				R = 251 / 255
			}
		},

		[4] =
		{
			Priority = 6,
			Spell = "Deep Insight",
			Type = "Buff",

			Color =
			{
				B = 0,
				G = 0,
				R = 139 / 255
			}
		},

		[5] =
		{
			Priority = 7,
			Spell = "Adrenaline Rush",
			Type = "Buff",

			Color =
			{
				B = 130 / 255,
				G = 220 / 255,
				R = 240 / 255
			}
		},

		[6] =
		{
			Priority = 8,
			Spell = "Shadow Blades",
			Type = "Buff",

			Color =
			{
				B = 1,
				G = 0,
				R = 143 / 255
			}
		},

		[7] =
		{
			Priority = 9,
			Spell = "Blade Flurry",
			Type = "Buff",

			Color =
			{
				B = 34 / 255,
				G = 88 / 255,
				R = 226 / 255
			}
		}
	},

	["SUBTLETY"] =
	{
		[1] =
		{
			Priority = 5,
			ShowOnFocus = true,
			Spell = "Hemorrhage",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 0,
				G = 0,
				R = 139 / 255
			}
		},

		[2] =
		{
			Priority = 6,
			ShowOnFocus = true,
			Spell = "Find Weakness",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 107 / 255,
				G = 168 / 255,
				R = 0
			}
		},

		[3] =
		{
			Priority = 7,
			Spell = "Shadow Dance",
			Type = "Buff",

			Color =
			{
				B = 1,
				G = 0,
				R = 10 / 255
			}
		},

		[4] =
		{
			Priority = 8,
			Spell = "Shadow Blades",
			Type = "Buff",

			Color =
			{
				B = 1,
				G = 0,
				R = 143 / 255
			}
		}
	}
}
