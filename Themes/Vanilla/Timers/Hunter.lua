-- Hunter.lua
-- Written by Snail

Configuration.Themes.Vanilla.Timers["HUNTER"] =
{
	Anchor = "BOTTOM",
	Height = 24,
	Width = 464,
	X = 26,
	Y = 298,

	[1] =
	{
		Priority = 1,
		ShowOnFocus = true,
		Spell = "Serpent Sting",
		Type = "Debuff",
		Unit = "Target",

		Color =
		{
			B = 30 / 255,
			G = 115 / 255,
			R = 79 / 255
		}
	},

	["SURVIVAL"] =
	{
		[1] =
		{
			Priority = 2,
			ShowOnFocus = true,
			Spell = "Explosive Shot",
			Type = "Cooldown",

			Color =
			{
				B = 33 / 255,
				G = 138 / 255,
				R = 235 / 255
			}
		},

		[2] =
		{
			Priority = 3,
			ShowOnFocus = true,
			Spell = "Black Arrow",
			Type = "Cooldown",

			Color =
			{
				B = 185 / 255,
				G = 0,
				R = 102 / 255
			}
		},

		[3] =
		{
			Priority = 4,
			Spell = "Dire Beast",
			Type = "Cooldown",

			Color =
			{
				B = 124 / 255,
				G = 107 / 255,
				R = 66 / 255
			}
		},

		[5] =
		{
			Priority = 5,
			Spell = "Kill Shot",
			Type = "Cooldown",

			Color =
			{
				B = 33 / 255,
				G = 22 / 255,
				R = 179 / 255
			}
		}
	}
}
