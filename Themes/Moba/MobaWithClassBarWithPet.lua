-- MobaWithClassBarWithPet.lua
-- Written by Snail

MobaWithClassBarWithPet = DeepCopy(MobaWithClassBar)
MobaWithClassBarWithPet.ActionBars.Pet =
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

MobaWithClassBarWithPet.Pet =
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
	
MobaWithClassBarWithPet.Player.HealthBar.Width = 200
MobaWithClassBarWithPet.Player.Width = 204
MobaWithClassBarWithPet.Player.X = -156
MobaWithClassBarWithPet.Player.Y = 211
MobaWithClassBarWithPet.Target.HealthBar.Width = 200
MobaWithClassBarWithPet.Target.PowerBar.Width = 200
MobaWithClassBarWithPet.Target.Width = 204
MobaWithClassBarWithPet.Target.X = 156
MobaWithClassBarWithPet.Target.Y = 211
