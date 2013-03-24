-- DefaultWithClassBarWithPet.lua
-- Written by Snail

DefaultWithClassBarWithPet = DeepCopy(DefaultWithClassBar)
DefaultWithClassBarWithPet.ActionBars.Pet =
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

DefaultWithClassBarWithPet.Pet =
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
	
DefaultWithClassBarWithPet.Player.HealthBar.Width = 200
DefaultWithClassBarWithPet.Player.Width = 204
DefaultWithClassBarWithPet.Player.X = -156
DefaultWithClassBarWithPet.Player.Y = 211
DefaultWithClassBarWithPet.Target.HealthBar.Width = 200
DefaultWithClassBarWithPet.Target.PowerBar.Width = 200
DefaultWithClassBarWithPet.Target.Width = 204
DefaultWithClassBarWithPet.Target.X = 156
DefaultWithClassBarWithPet.Target.Y = 211
DefaultWithClassBarWithPet.Target.CastingBar.Height = 259
