-- MobaWithPet.lua
-- Written by Snail

MobaWithPet = DeepCopy(Configuration.Themes.Moba)
MobaWithPet.ActionBars.Pet =
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

MobaWithPet.Pet =
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
	
MobaWithPet.Player.HealthBar.Width = 200
MobaWithPet.Player.PowerBar.Width = 200
MobaWithPet.Player.Width = 204
MobaWithPet.Player.X = -156
MobaWithPet.Player.Y = 211
MobaWithPet.Target.HealthBar.Width = 200
MobaWithPet.Target.PowerBar.Width = 200
MobaWithPet.Target.Width = 204
MobaWithPet.Target.X = 156
MobaWithPet.Target.Y = 211
