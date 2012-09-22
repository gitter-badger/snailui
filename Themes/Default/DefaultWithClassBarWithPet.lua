-- DefaultWithClassBarWithPet.lua
-- Written by Snail

DefaultWithClassBarWithPet = deepcopy(DefaultWithClassBar)
DefaultWithClassBarWithPet.ActionBars.Pet =
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

DefaultWithClassBarWithPet.Pet =
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
    
DefaultWithClassBarWithPet.Player.HealthBar.width = 200
DefaultWithClassBarWithPet.Player.width = 204
DefaultWithClassBarWithPet.Player.x = -156
DefaultWithClassBarWithPet.Player.y = 164
DefaultWithClassBarWithPet.Target.HealthBar.width = 200
DefaultWithClassBarWithPet.Target.PowerBar.width = 200
DefaultWithClassBarWithPet.Target.width = 204
DefaultWithClassBarWithPet.Target.x = 156
DefaultWithClassBarWithPet.Target.y = 164
DefaultWithClassBarWithPet.Target.CastingBar.height = 212
