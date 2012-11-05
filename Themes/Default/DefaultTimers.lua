-- DefaultTimers.lua
-- Written by Snail

Configuration.Themes.Default.Timers =
{
    ["DEATHKNIGHT"] =
    {
        [1] =
        {
            Anchor = "BOTTOM",
            Height = 24,
            Spell = "Blood Plague",
            Type = "Debuff",
            Unit = "Target",
            Width = 464,
            X = 26,
            Y = 223,

            Color =
            {
                B = 171 / 255,
                G = 0,
                R = 115 / 255
            }
        },

        [2] =
        {
            Anchor = "BOTTOM",
            Height = 24,
            Spell = "Frost Fever",
            Type = "Debuff",
            Unit = "Target",
            Width = 464,
            X = 26,
            Y = 251,

            Color =
            {
                B = 251 / 255,
                G = 194 / 255,
                R = 115 / 255
            }
        }
    },

    ["WARLOCK"] =
    {
        ["AFFLICTION"] =
        {
            [1] =
            {
                Anchor = "BOTTOM",
                Height = 24,
                Spell = "Unstable Affliction",
                Type = "Debuff",
                Unit = "Target",
                Width = 464,
                X = 26,
                Y = 251,

                Color =
                {
                    B = 171 / 255,
                    G = 0,
                    R = 115 / 255
                }
            },

            [2] =
            {
                Anchor = "BOTTOM",
                Height = 24,
                Spell = "Corruption",
                Type = "Debuff",
                Unit = "Target",
                Width = 464,
                X = 26,
                Y = 279,

                Color =
                {
                    B = 1,
                    G = 0,
                    R = 111 / 255
                }
            },

            [3] =
            {
                Anchor = "BOTTOM",
                Height = 24,
                Spell = "Agony",
                Type = "Debuff",
                Unit = "Target",
                Width = 464,
                X = 26,
                Y = 307,

                Color =
                {
                    B = 27 / 255,
                    G = 70 / 255,
                    R = 128 / 255
                }
            },

            [4] =
            {
                Anchor = "BOTTOM",
                Height = 24,
                Spell = "Haunt",
                Type = "Debuff",
                Unit = "Target",
                Width = 464,
                X = 26,
                Y = 335,

                Color =
                {
                    B = 157 / 255,
                    G = 186 / 255,
                    R = 169 / 255
                }
            }
        },

        ["DEMONOLOGY"] =
        {
            [1] =
            {
                Anchor = "BOTTOM",
                Height = 24,
                Spell = "Hand of Gul'dan",
                Type = "Cooldown",
                Width = 464,
                X = 26,
                Y = 251,

                Color =
                {
                    B = 193 / 255,
                    G = 84 / 255,
                    R = 193 / 255
                }
            },

            [2] =
            {
                Anchor = "BOTTOM",
                Height = 24,
                Spell = "Corruption",
                Type = "Debuff",
                Unit = "Target",
                Width = 464,
                X = 26,
                Y = 279,

                Color =
                {
                    B = 1,
                    G = 0,
                    R = 111 / 255
                }
            },

            [3] =
            {
                Anchor = "BOTTOM",
                Height = 24,
                Spell = "Doom",
                Type = "Debuff",
                Unit = "Target",
                Width = 464,
                X = 26,
                Y = 307,

                Color =
                {
                    B = 192 / 255,
                    G = 192 / 255,
                    R = 192 / 255
                }
            }
        },

        ["DESTRUCTION"] =
        {
            [1] =
            {
                Anchor = "BOTTOM",
                Height = 24,
                Spell = "Conflagrate",
                Type = "Cooldown",
                Width = 464,
                X = 26,
                Y = 251,

                Color =
                {
                    B = 0,
                    G = 85 / 255,
                    R = 204 / 255
                }
            },

            [2] =
            {
                Anchor = "BOTTOM",
                Height = 24,
                Spell = "Immolate",
                Type = "Debuff",
                Unit = "Target",
                Width = 464,
                X = 26,
                Y = 279,

                Color =
                {
                    B = 0,
                    G = 0,
                    R = 139 / 255
                }
            }
        }
    }
}
