-- Configuration.lua
-- Written by Snail

Configuration =
{
    InactiveAlpha = 0.1,
    Texture = "Interface\\AddOns\\SnailUI\\SnailUI.tga",
    Theme = "Default",

    Font =
    {
        Name = "Interface\\AddOns\\SnailUI\\SnailUI.ttf",
        Outline = "MONOCHROME, OUTLINE",
        Size = 8,
    },

    Themes =
    {
    }
}

if not Theme then
    Theme = Configuration.Theme
end
