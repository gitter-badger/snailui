-- CompactWithClassBarWithPet.lua
-- Written by Snail

CompactWithClassBarWithPet = DeepCopy(CompactWithClassBar)
CompactWithClassBarWithPet.ActionBars.Pet =
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

CompactWithClassBarWithPet.Pet =
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
	
CompactWithClassBarWithPet.Player.HealthBar.Width = 200
CompactWithClassBarWithPet.Player.Width = 204
CompactWithClassBarWithPet.Player.X = -156
CompactWithClassBarWithPet.Player.Y = 211

CompactWithClassBarWithPet.Target.HealthBar.Width = 200
CompactWithClassBarWithPet.Target.PowerBar.Width = 200
CompactWithClassBarWithPet.Target.Width = 204
CompactWithClassBarWithPet.Target.X = 156
CompactWithClassBarWithPet.Target.Y = 211
