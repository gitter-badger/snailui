-- VanillaWithClassBarWithPet.lua
-- Written by Snail

VanillaWithClassBarWithPet = DeepCopy(VanillaWithClassBar)
VanillaWithClassBarWithPet.ActionBars.Pet =
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

VanillaWithClassBarWithPet.Pet =
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
	
VanillaWithClassBarWithPet.Player.HealthBar.Width = 200
VanillaWithClassBarWithPet.Player.Width = 204
VanillaWithClassBarWithPet.Player.X = -156
VanillaWithClassBarWithPet.Player.Y = 211
VanillaWithClassBarWithPet.Target.HealthBar.Width = 200
VanillaWithClassBarWithPet.Target.PowerBar.Width = 200
VanillaWithClassBarWithPet.Target.Width = 204
VanillaWithClassBarWithPet.Target.X = 156
VanillaWithClassBarWithPet.Target.Y = 211
