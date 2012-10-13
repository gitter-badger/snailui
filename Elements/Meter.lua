-- Meter.lua
-- Written by Snail

function HandleMeter()
    if GetConfiguration().Meter then
        local Class = select(2, UnitClass("Player"))
        local Meter = CreateFrame("Frame", nil, UIParent)

        Meter:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        Meter:RegisterEvent("PLAYER_REGEN_DISABLED")
        Meter:RegisterEvent("PLAYER_REGEN_ENABLED")
        Meter:SetPoint(GetConfiguration().Meter.Anchor, GetConfiguration().Meter.X, GetConfiguration().Meter.Y)
        Meter:SetSize(GetConfiguration().Meter.Width - 6, GetConfiguration().Meter.Height - 6)
        Meter:SetScript("OnEvent",
            function(Self, Event, ...)
                print(Event)
            end
        )

        Meter.BackgroundBottom = Meter:CreateTexture(nil, "LOW")
        Meter.BackgroundBottom:SetPoint("BOTTOM", 0, -2)
        Meter.BackgroundBottom:SetSize(GetConfiguration().Meter.Width - 2, 1)
        Meter.BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

        Meter.BackgroundLeft = Meter:CreateTexture(nil, "LOW")
        Meter.BackgroundLeft:SetPoint("LEFT", -2, 0)
        Meter.BackgroundLeft:SetSize(1, GetConfiguration().Meter.Height - 4)
        Meter.BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

        Meter.BackgroundRight = Meter:CreateTexture(nil, "LOW")
        Meter.BackgroundRight:SetPoint("RIGHT", 2, 0)
        Meter.BackgroundRight:SetSize(1, GetConfiguration().Meter.Height - 4)
        Meter.BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

        Meter.BackgroundTop = Meter:CreateTexture(nil, "LOW")
        Meter.BackgroundTop:SetPoint("TOP", 0, 2)
        Meter.BackgroundTop:SetSize(GetConfiguration().Meter.Width - 2, 1)
        Meter.BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

        Meter.Border = Meter:CreateTexture(nil, "BACKGROUND")
        Meter.Border:SetPoint("TOPLEFT", -3, 3)
        Meter.Border:SetSize(GetConfiguration().Meter.Width, GetConfiguration().Meter.Height)
        Meter.Border:SetTexture(0, 0, 0)
    end
end
