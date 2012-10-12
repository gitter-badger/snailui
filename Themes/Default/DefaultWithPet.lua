-- DefaultWithPet.lua
-- Written by Snail

DefaultWithPet = DeepCopy(Configuration.Themes.Default)
DefaultWithPet.ActionBars.Pet =
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

DefaultWithPet.Pet =
{
    Anchor = "BOTTOM",
    Height = 24,
    Width = 100,
    X = 0,
    Y = 192,

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
    
DefaultWithPet.Player.HealthBar.Width = 200
DefaultWithPet.Player.PowerBar.Width = 200
DefaultWithPet.Player.Width = 204
DefaultWithPet.Player.X = -156
DefaultWithPet.Player.Y = 192
DefaultWithPet.Target.HealthBar.Width = 200
DefaultWithPet.Target.PowerBar.Width = 200
DefaultWithPet.Target.Width = 204
DefaultWithPet.Target.X = 156
DefaultWithPet.Target.Y = 192
DefaultWithPet.Target.CastingBar.Height = 212
