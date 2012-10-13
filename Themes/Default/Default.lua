-- Default.lua
-- Written by Snail

Configuration.Themes.Default = 
{
    ActionBars =
    {
        Player =
        {
            Anchor = "BOTTOM",
            Buttons = 10,
            Height = 24,
            Width = 48,
            X = 0,
            Y = 108,

            TextureCoordinate =
            {
                Bottom = 0.7,
                Left = 0.1,
                Right = 0.9,
                Top = 0.3
            }
        },

        Player2 =
        {
            Anchor = "BOTTOM",
            Buttons = 10,
            Height = 24,
            Width = 48,
            X = 0,
            Y = 136,

            TextureCoordinate =
            {
                Bottom = 0.7,
                Left = 0.1,
                Right = 0.9,
                Top = 0.3
            }
        }
    },

    Bag =
    {
        Anchor = "BOTTOMRIGHT",
        Columns = 8,
        Height = 24,
        Width = 48,
        X = -5,
        Y = 5,

        TextureCoordinate =
        {
            Bottom = 0.7,
            Left = 0.1,
            Right = 0.9,
            Top = 0.3
        }
    },

    Buffs =
    {
        Anchor = "RIGHT",
        Height = 32,
        Width = 32,
        X = -4,
        Y = 0,

        TextureCoordinate =
        {
            Bottom = 0.9,
            Left = 0.1,
            Right = 0.9,
            Top = 0.1
        }
    },

    Chat =
    {
        Anchor = "BOTTOM",
        Height = 100,
        Width = 256,
        X = -130,
        Y = 9
    },

    ExperienceBar =
    {
        Anchor = "TOP",
        Height = 8,
        Width = 204,
        X = 0,
        Y = -28
    },

    ExtraButton =
    {
        Anchor = "TOP",
        Height = 24,
        HoverToShow = true,
        Width = 204,
        X = 0,
        Y = -6
    },

    Initialize = function(Self)
        Configuration.Themes.Default["DEATHKNIGHT"] = DefaultWithClassBar
        Configuration.Themes.Default["DEATHKNIGHT"]["UNHOLY"] = DefaultWithClassBarWithPet
        Configuration.Themes.Default["DRUID"] = Configuration.Themes.Default
        Configuration.Themes.Default["DRUID"]["BALANCE"] = DefaultWithClassBar
        Configuration.Themes.Default["DRUID"]["FERAL"] = DefaultWithClassBar
        Configuration.Themes.Default["DRUID"]["RESTORATION"] = DefaultHealer
        Configuration.Themes.Default["HUNTER"] = DefaultWithPet
        Configuration.Themes.Default["MAGE"] = Configuration.Themes.Default
        Configuration.Themes.Default["MAGE"]["FROST"] = DefaultWithPet
        Configuration.Themes.Default["MONK"] = DefaultWithClassBar
        Configuration.Themes.Default["MONK"]["MISTWEAVER"] = DefaultHealerWithClassBar
        Configuration.Themes.Default["PALADIN"] = DefaultWithClassBar
        Configuration.Themes.Default["PALADIN"]["HOLY"] = DefaultHealerWithClassBar
        Configuration.Themes.Default["PRIEST"] = DefaultHealer
        Configuration.Themes.Default["PRIEST"]["SHADOW"] = DefaultWithClassBar
        Configuration.Themes.Default["ROGUE"] = DefaultWithClassBar
        Configuration.Themes.Default["SHAMAN"] = Configuration.Themes.Default
        Configuration.Themes.Default["SHAMAN"]["RESTORATION"] = DefaultHealer
        Configuration.Themes.Default["WARLOCK"] = DefaultWithClassBarWithPet

        local Class = select(2, UnitClass("Player"))

        if Class == "WARLOCK" then
            local _, _, _, _, Selected = GetTalentInfo(15)

            if Selected == true then
                Configuration.Themes.Default["WARLOCK"] = DefaultWithClassBar
            end
        end
    end,

    Meter =
    {
        Anchor = "BOTTOM",
        Height = 100,
        Width = 152,
        X = 78,
        Y = 7,

        Bars =
        {
            Bars = 5,
            Height = 24,
            Width = 100
        }
    },

    Minimap =
    {
        Anchor = "BOTTOM",
        Height = 100,
        Width = 100,
        X = 208,
        Y = 7,

        Calender =
        {
            Anchor ="TOPRIGHT",
            X = 0,
            Y = 0
        },

        Clock =
        {
            Anchor ="BOTTOM",
            X = 2,
            Y = 6
        },

        Mail =
        {
            Anchor ="BOTTOMRIGHT",
            X = 1,
            Y = -2
        },

        Tracking =
        {
            Anchor ="TOPLEFT",
            X = -1,
            Y = 0
        },

        QueueStatus =
        {
            Anchor ="BOTTOMLEFT",
            X = 0,
            Y = 0
        },
    },
    
    Player =
    {
        Anchor = "BOTTOM",
        Height = 24,
        Width = 256,
        X = -130,
        Y = 164,

        CastingBar =
        {
            Anchor = "TOPLEFT",
            Height = 24,
            Orientation = "HORIZONTAL",
            Width = 464,
            X = 55,
            Y = 25,

            Spell =
            {
                Duration =
                {
                    Anchor = "RIGHT",
                    X = -4,
                    Y = 0
                },

                Name =
                {
                    Anchor = "LEFT",
                    X = 6,
                    Y = 0
                },

                Texture =
                {
                    Anchor = "LEFT",
                    Height = 24,
                    Width = 48,
                    X = -52,
                    Y = 0,

                    TextureCoordinate =
                    {
                        Bottom = 0.7,
                        Left = 0.1,
                        Right = 0.9,
                        Top = 0.3
                    }
                }
            }
        },

        HealthBar =
        {
            Anchor = "TOP",
            Height = 15,
            Orientation = "HORIZONTAL",
            Width = 252,
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
            Width = 252,
            X = 0,
            Y = 3
        }
    },

    Raid =
    {
        Anchor = "LEFT",
        ColumnAnchor = "LEFT",
        Columns = 1,
        ColumnSpacing = 4,
        ColumnX = 4,
        ColumnY = -4,
        GroupBY = "GROUP",
        GroupOrder = "1, 2, 3, 4, 5, 6, 7, 8",
        HealthThreshold = 90,
        Height = 32,
        Rows = 40,
        ShowParty = true,
        ShowPlayer = true,
        ShowRaid = true,
        ShowSolo = true,
        Width = 32,
        X = 4,
        Y = 0,

        HealthBar =
        {
            Anchor = "CENTER",
            Height = 28,
            Orientation = "VERTICAL",
            Width = 28,
            X = 0,
            Y = 0,

            Health =
            {
                Anchor ="CENTER",
                SmallText = true,
                X = 1,
                Y = 0
            }
        }
    },

    Target =
    {
        Anchor = "BOTTOM",
        Height = 24,
        Width = 256,
        X = 130,
        Y = 164,

        CastingBar =
        {
            Anchor = "TOPRIGHT",
            Height = 184,
            Orientation = "VERTICAL",
            Width = 10,
            X = 11,
            Y = -3
        },

        HealthBar =
        {
            Anchor = "TOP",
            Height = 15,
            Orientation = "HORIZONTAL",
            Width = 252,
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
            Width = 252,
            X = 0,
            Y = 3
        }
    }
}
