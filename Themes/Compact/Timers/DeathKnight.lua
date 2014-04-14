-- DeathKnight.lua
-- Written by Snail

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
