-- Warlock.lua
-- Written by Snail

Configuration.Themes.Compact.Timers["WARLOCK"] =
{
	Anchor = "BOTTOM",
	Height = 24,
	Width = 464,
	X = 26,
	Y = 298,

	[1] =
	{
		Priority = 99,
		ShowOnFocus = true,
		Spell = "Fear",
		Type = "Debuff",
		Unit = "Target",

		Color =
		{
			B = 97 / 255,
			G = 30 / 255,
			R = 74 / 255
		}
	},

	["AFFLICTION"] =
	{
		[1] =
		{
			Priority = 1,
			ShowOnFocus = true,
			Spell = "Unstable Affliction",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 171 / 255,
				G = 0,
				R = 115 / 255
			}
		},

		[2] =
		{
			Priority = 2,
			ShowOnFocus = true,
			Spell = "Corruption",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 1,
				G = 0,
				R = 111 / 255
			}
		},

		[3] =
		{
			Priority = 3,
			ShowOnFocus = true,
			Spell = "Agony",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 27 / 255,
				G = 70 / 255,
				R = 128 / 255
			}
		},

		[4] =
		{
			Priority = 4,
			ShowOnFocus = true,
			Spell = "Haunt",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 157 / 255,
				G = 186 / 255,
				R = 169 / 255
			}
		},

		[5] =
		{
			Priority = 5,
			Spell = "Dark Soul: Misery",
			Type = "Buff",

			Color =
			{
				B = 1,
				G = 0,
				R = 143 / 255
			}
		}
	},

	["DEMONOLOGY"] =
	{
		[1] =
		{
			Priority = 1,
			Spell = "Hand of Gul'dan",
			Type = "Cooldown",

			Color =
			{
				B = 193 / 255,
				G = 84 / 255,
				R = 193 / 255
			}
		},

		[2] =
		{
			Priority = 2,
			ShowOnFocus = true,
			Spell = "Corruption",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 1,
				G = 0,
				R = 111 / 255
			}
		},

		[3] =
		{
			Priority = 3,
			ShowOnFocus = true,
			Spell = "Doom",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 192 / 255,
				G = 192 / 255,
				R = 192 / 255
			}
		},

		[4] =
		{
			Priority = 4,
			Spell = "Molten Core",
			Type = "Buff",

			Color =
			{
				B = 22 / 255,
				G = 47 / 255,
				R = 141 / 255
			}
		},

		[5] =
		{
			Priority = 5,
			ShowOnFocus = true,
			Spell = "Shadowflame",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 210 / 255,
				G = 7 / 255,
				R = 134 / 255
			}
		},

		[6] =
		{
			Priority = 6,
			Spell = "Dark Soul: Knowledge",
			Type = "Buff",

			Color =
			{
				B = 1,
				G = 0,
				R = 143 / 255
			}
		}
	},

	["DESTRUCTION"] =
	{
		[1] =
		{
			Priority = 1,
			Spell = "Conflagrate",
			Type = "Cooldown",

			Color =
			{
				B = 0,
				G = 85 / 255,
				R = 204 / 255
			}
		},

		[2] =
		{
			Priority = 2,
			ShowOnFocus = true,
			Spell = "Immolate",
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
			Priority = 3,
			Spell = "Rain of Fire",
			Type = "Buff",

			Color =
			{
				B = 10 / 255,
				G = 83 / 255,
				R = 198 / 255
			}
		},

		[4] =
		{
			Priority = 4,		
			Spell = "Backdraft",
			Type = "Buff",

			Color =
			{
				B = 6 / 255,
				G = 128 / 255,
				R = 1
			}
		},

		[5] =
		{
			Priority = 5,
			Spell = "Havoc",
			Type = "Cooldown",

			Color =
			{
				B = 41 / 255,
				G = 32 / 255,
				R = 206 / 255
			}
		},

		[6] =
		{
			Priority = 6,
			Spell = "Dark Soul: Instability",
			Type = "Buff",

			Color =
			{
				B = 27 / 255,
				G = 111 / 255,
				R = 244 / 255
			}
		}
	}
}
