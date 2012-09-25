-- Default.lua
-- Written by Snail

-- v from http://lua-users.org/wiki/CopyTable
function deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end
-- v from http://lua-users.org/wiki/CopyTable

Configuration.Themes.Default = 
{
    ActionBars =
    {
        Player =
        {
            anchor = 'BOTTOM',
            buttons = 10,
            height = 24,
            width = 48,
            x = 0,
            y = 108,

            TextureCoordinate =
            {
                bottom = 0.7,
                left = 0.1,
                right = 0.9,
                top = 0.3
            }
        }
    },

    Buffs =
    {
        anchor = 'RIGHT',
        height = 32,
        width = 32,
        x = -4,
        y = 0
    },

    Chat =
    {
        anchor = 'BOTTOM',
        height = 100,
        width = 256,
        x = -130,
        y = 9
    },

    ExtraButton =
    {
        anchor = 'TOP',
        height = 24,
        hoverToShow = true,
        width = 204,
        x = 0,
        y = -6
    },

    Minimap =
    {
        anchor = 'BOTTOM',
        height = 100,
        width = 100,
        x = 208,
        y = 7,

        Calender =
        {
            anchor ='TOPRIGHT',
            x = 0,
            y = 0
        },

        Clock =
        {
            anchor ='BOTTOM',
            x = 2,
            y = 6
        },

        MailButton =
        {
            anchor ='BOTTOMRIGHT',
            x = 1,
            y = -2
        },

        TrackingButton =
        {
            anchor ='TOPLEFT',
            x = -1,
            y = 0
        },

        QueueStatusButton =
        {
            anchor ='BOTTOMLEFT',
            x = 0,
            y = 0
        },
    },
    
    Player =
    {
        anchor = 'BOTTOM',
        height = 24,
        width = 256,
        x = -130,
        y = 136,

        CastingBar =
        {
            anchor = 'TOPLEFT',
            height = 24,
            orientation = 'HORIZONTAL',
            width = 516,
            x = 3,
            y = 25
        },

        HealthBar =
        {
            anchor = 'TOP',
            height = 15,
            orientation = 'HORIZONTAL',
            width = 252,
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
            width = 252,
            x = 0,
            y = 3
        }
    },

    Raid =
    {
        anchor = 'LEFT',
        columnAnchor = 'LEFT',
        columns = 1,
        columnSpacing = 4,
        columnX = 4,
        columnY = -4,
        groupBy = 'GROUP',
        groupOrder = '1, 2, 3, 4, 5, 6, 7, 8',
        healthThreshold = 90,
        height = 32,
        rows = 40,
        showParty = true,
        showPlayer = true,
        showRaid = true,
        showSolo = true,
        width = 32,
        x = 4,
        y = 0,

        HealthBar =
        {
            anchor = 'CENTER',
            height = 28,
            orientation = 'VERTICAL',
            smallText = true,
            width = 28,
            x = 0,
            y = 0,

            Text =
            {
                anchor ='CENTER',
                x = 1,
                y = 0
            }
        }
    },

    Target =
    {
        anchor = 'BOTTOM',
        height = 24,
        width = 256,
        x = 130,
        y = 136,

        CastingBar =
        {
            anchor = 'TOPRIGHT',
            height = 156,
            orientation = 'VERTICAL',
            width = 8,
            x = 9,
            y = -3
        },

        HealthBar =
        {
            anchor = 'TOP',
            height = 15,
            orientation = 'HORIZONTAL',
            width = 252,
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
            width = 252,
            x = 0,
            y = 3
        }
    }
}
