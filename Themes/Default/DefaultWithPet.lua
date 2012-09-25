-- DefaultWithPet.lua
-- Written by Snail

DefaultWithPet = deepcopy(Configuration.Themes.Default)
DefaultWithPet.ActionBars.Pet =
{
    anchor = 'BOTTOM',
    buttons = 10,
    height = 24,
    width = 48,
    x = 0,
    y = 28,

    TextureCoordinate =
    {
        bottom = 0.7,
        left = 0.1,
        right = 0.9,
        top = 0.3
    }
}

DefaultWithPet.Pet =
{
    anchor = 'BOTTOM',
    height = 24,
    width = 100,
    x = 0,
    y = 164,

    HealthBar =
    {
        anchor = 'TOP',
        height = 15,
        orientation = 'HORIZONTAL',
        width = 96,
        x = 0,
        y = -3,

        Text =
        {
            anchor ='CENTER',
            x = 1,
            y = 0
        }
    },

    PowerBar =
    {
        anchor = 'BOTTOM',
        height = 4,
        orientation = 'HORIZONTAL',
        width = 96,
        x = 0,
        y = 3
    }
}
    
DefaultWithPet.Player.HealthBar.width = 200
DefaultWithPet.Player.PowerBar.width = 200
DefaultWithPet.Player.width = 204
DefaultWithPet.Player.x = -156
DefaultWithPet.Player.y = 164
DefaultWithPet.Target.HealthBar.width = 200
DefaultWithPet.Target.PowerBar.width = 200
DefaultWithPet.Target.width = 204
DefaultWithPet.Target.x = 156
DefaultWithPet.Target.y = 164
DefaultWithPet.Target.CastingBar.height = 184
