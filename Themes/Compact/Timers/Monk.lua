-- Monk.lua
-- Written by Snail

Configuration.Themes.Compact.Timers["MONK"] =
{
	Anchor = "BOTTOM",
	Height = 24,
	Width = 464,
	X = 26,
	Y = 242,

	["MISTWEAVER"] =
	{
		Anchor = "TOP",
		AnchorToRaid = true,
		Y = 49,
		
		[1] =
		{
			Priority = 1,
			Spell = "Expel Harm",
			Type = "Cooldown",

			Color =
			{
				B = 165 / 255,
				G = 190 / 255,
				R = 8 / 255
			}
		},

		[2] =
		{
			Priority = 2,
			Spell = "Renewing Mist",
			Type = "Cooldown",

			Color =
			{
				B = 141 / 255,
				G = 186 / 255,
				R = 57 / 255
			}
		},

		[3] =
		{
			Priority = 3,
			Spell = "Chi Wave",
			Type = "Cooldown",

			Color =
			{
				B = 223 / 255,
				G = 251 / 255,
				R = 61 / 255
			}
		},

		[4] =
		{
			Priority = 4,
			Spell = "Mana Tea",
			Type = "Cooldown",

			Color =
			{
				B = 1,
				G = 165 / 255,
				R = 13 / 255
			}
		}
	},

	["WINDWALKER"] =
	{
		[1] =
		{
			Priority = 1,
			Spell = "Tiger Power",
			Type = "Buff",

			Color =
			{
				B = 175 / 255,
				G = 218 / 255,
				R = 8 / 255
			}
		}
	}
}
