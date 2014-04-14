-- Paladin.lua
-- Written by Snail

Configuration.Themes.Compact.Timers["PALADIN"] =
{
	Anchor = "BOTTOM",
	Height = 24,
	Width = 464,
	X = 26,
	Y = 242,

	[1] =
	{
		Priority = 1,
		Spell = "Crusader Strike",
		Type = "Cooldown",

		Color =
		{
			B = 87 / 255,
			G = 245 / 255,
			R = 254 / 255
		}
	},

	[2] =
	{
		Priority = 2,
		Spell = "Judgment",
		Type = "Cooldown",

		Color =
		{
			B = 74 / 255,
			G = 186 / 255,
			R = 222 / 255
		}
	},

	[3] =
	{
		Priority = 3,
		Spell = "Exorcism",
		Type = "Cooldown",

		Color =
		{
			B = 0,
			G = 114 / 255,
			R = 231 / 255
		}
	},

	[4] =
	{
		Priority = 4,
		Spell = "Hammer of Wrath",
		Type = "Cooldown",

		Color =
		{
			B = 223 / 255,
			G = 218 / 255,
			R = 57 / 255
		}
	},

	["RETRIBUTION"] =
	{
		[1] =
		{
			Priority = 5,
			Spell = "Inquisition",
			Type = "Buff",

			Color =
			{
				B = 149 / 255,
				G = 251 / 255,
				R = 1
			}
		}
	}
}
