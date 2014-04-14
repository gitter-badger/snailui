-- CompactWithPet.lua
-- Written by Snail

CompactWithPet = DeepCopy(Configuration.Themes.Compact)
CompactWithPet.ActionBars.Pet =
{
	Anchor = "BOTTOM",
	Buttons = 10,
	Height = 24,
	Width = 48,
	X = 0,
	Y = 56,

	TextureCoordinate =
	{
		Bottom = 0.7,
		Left = 0.1,
		Right = 0.9,
		Top = 0.3
	}
}

CompactWithPet.Pet =
{
	Anchor = "BOTTOM",
	Height = 24,
	Width = 100,
	X = 0,
	Y = 211,

	HealthBar =
	{
		Anchor = "TOP",
		Height = 15,
		Orientation = "HORIZONTAL",
		Width = 96,
		X = 0,
		Y = -3,

		Health =
		{
			Anchor ="CENTER",
			X = 1,
			Y = 0
		}
	},

	PowerBar =
	{
		Anchor = "BOTTOM",
		Height = 4,
		Orientation = "HORIZONTAL",
		Width = 96,
		X = 0,
		Y = 3
	}
}
	
CompactWithPet.Player.HealthBar.Width = 200
CompactWithPet.Player.PowerBar.Width = 200
CompactWithPet.Player.Width = 204
CompactWithPet.Player.X = -156
CompactWithPet.Player.Y = 211

CompactWithPet.Target.HealthBar.Width = 200
CompactWithPet.Target.PowerBar.Width = 200
CompactWithPet.Target.Width = 204
CompactWithPet.Target.X = 156
CompactWithPet.Target.Y = 211
