-- Priest.lua
-- Written by Snail

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
		}
	}
}
