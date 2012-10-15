-- Minimap.lua
-- Written by Snail

function HandleMinimap()
    if GetConfiguration().Minimap then
        local Class = select(2, UnitClass("Player"))
        local Minimap = CreateFrame("Minimap", nil, UIParent)

        Minimap:SetMaskTexture("Interface\\Buttons\\WHITE8X8.tga")
        Minimap:SetPoint(GetConfiguration().Minimap.Anchor, GetConfiguration().Minimap.X, GetConfiguration().Minimap.Y)
        Minimap:SetSize(GetConfiguration().Minimap.Width - 6, GetConfiguration().Minimap.Height - 6)
        Minimap:SetScript("OnMouseWheel",
            function(Self, Zoom)
                if Zoom > 0 then
                    Minimap_ZoomIn()
                else
                    Minimap_ZoomOut()
                end
            end
        )

        Minimap.BackgroundBottom = Minimap:CreateTexture(nil, "LOW")
        Minimap.BackgroundBottom:SetPoint("BOTTOM", 0, -2)
        Minimap.BackgroundBottom:SetSize(GetConfiguration().Minimap.Width - 2, 1)
        Minimap.BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

        Minimap.BackgroundLeft = Minimap:CreateTexture(nil, "LOW")
        Minimap.BackgroundLeft:SetPoint("LEFT", -2, 0)
        Minimap.BackgroundLeft:SetSize(1, GetConfiguration().Minimap.Height - 4)
        Minimap.BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

        Minimap.BackgroundRight = Minimap:CreateTexture(nil, "LOW")
        Minimap.BackgroundRight:SetPoint("RIGHT", 2, 0)
        Minimap.BackgroundRight:SetSize(1, GetConfiguration().Minimap.Height - 4)
        Minimap.BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

        Minimap.BackgroundTop = Minimap:CreateTexture(nil, "LOW")
        Minimap.BackgroundTop:SetPoint("TOP", 0, 2)
        Minimap.BackgroundTop:SetSize(GetConfiguration().Minimap.Width - 2, 1)
        Minimap.BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

        Minimap.BorderBottom = Minimap:CreateTexture(nil, "BACKGROUND")
        Minimap.BorderBottom:SetPoint("BOTTOM", 0, -3)
        Minimap.BorderBottom:SetSize(GetConfiguration().Minimap.Width, 3)
        Minimap.BorderBottom:SetTexture(0, 0, 0)

        Minimap.BorderLeft = Minimap:CreateTexture(nil, "BACKGROUND")
        Minimap.BorderLeft:SetPoint("LEFT", -3, 0)
        Minimap.BorderLeft:SetSize(3, GetConfiguration().Minimap.Height - 2)
        Minimap.BorderLeft:SetTexture(0, 0, 0)

        Minimap.BorderRight = Minimap:CreateTexture(nil, "BACKGROUND")
        Minimap.BorderRight:SetPoint("RIGHT", 3, 0)
        Minimap.BorderRight:SetSize(3, GetConfiguration().Minimap.Height - 2)
        Minimap.BorderRight:SetTexture(0, 0, 0)

        Minimap.BorderTop = Minimap:CreateTexture(nil, "BACKGROUND")
        Minimap.BorderTop:SetPoint("TOP", 0, 3)
        Minimap.BorderTop:SetSize(GetConfiguration().Minimap.Width, 3)
        Minimap.BorderTop:SetTexture(0, 0, 0)

        if GetConfiguration().Minimap.Calender then
            GameTimeFrame:ClearAllPoints()
            GameTimeFrame:SetParent(Minimap)
            GameTimeFrame:SetPoint(GetConfiguration().Minimap.Calender.Anchor, GetConfiguration().Minimap.Calender.X, GetConfiguration().Minimap.Calender.Y)
            GameTimeFrame:SetSize(32, 32)

            GameTimeFrame.Time = GameTimeFrame:CreateFontString(nil, "OVERLAY")
            GameTimeFrame.Time:SetFont("Fonts\\FrizQT__.ttf", Configuration.Font.Size)
            GameTimeFrame.Time:SetPoint("CENTER", 0, -2)
            GameTimeFrame.Time:SetTextColor(0, 0, 0)

            GameTimeFrame_SetDate = function()
                local _, _, Day = CalendarGetDate()
                GameTimeFrame.Time:SetText(Day)
            end

            GameTimeFrame:SetText(nil)
        end

        if GetConfiguration().Minimap.Clock then
            TimeManagerClockButton:ClearAllPoints()
            TimeManagerClockButton:GetRegions():Hide()
            TimeManagerClockButton:SetParent(Minimap)
            TimeManagerClockButton:SetPoint(GetConfiguration().Minimap.Clock.Anchor, GetConfiguration().Minimap.Clock.X, GetConfiguration().Minimap.Clock.Y)
            TimeManagerClockButton:SetSize(TimeManagerClockTicker:GetWidth(), TimeManagerClockTicker:GetHeight())

            TimeManagerClockTicker:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
            TimeManagerClockTicker:SetPoint("CENTER", TimeManagerClockButton)
            TimeManagerClockTicker:SetShadowOffset(0, 0)
            TimeManagerClockTicker:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
        end

        if GetConfiguration().Minimap.Mail then
            MiniMapMailBorder:Hide()
            MiniMapMailFrame:ClearAllPoints()
            MiniMapMailFrame:SetParent(Minimap)
            MiniMapMailFrame:SetPoint(GetConfiguration().Minimap.Mail.Anchor, GetConfiguration().Minimap.Mail.X, GetConfiguration().Minimap.Mail.Y)
            MiniMapMailIcon:SetTexture("Interface\\Minimap\\Tracking\\Mailbox.tga")
        end

        if GetConfiguration().Minimap.Tracking then
            MiniMapTracking:ClearAllPoints()
            MiniMapTracking:SetParent(Minimap)
            MiniMapTracking:SetPoint(GetConfiguration().Minimap.Tracking.Anchor, GetConfiguration().Minimap.Tracking.X, GetConfiguration().Minimap.Tracking.Y)
            MiniMapTrackingBackground:Hide()
            MiniMapTrackingButtonBorder:Hide()
            MiniMapTrackingIconOverlay:SetTexture(nil)
        end

        if GetConfiguration().Minimap.QueueStatus then
            QueueStatusMinimapButton:ClearAllPoints()
            QueueStatusMinimapButton:SetParent(Minimap)
            QueueStatusMinimapButton:SetPoint(GetConfiguration().Minimap.QueueStatus.Anchor, GetConfiguration().Minimap.QueueStatus.X, GetConfiguration().Minimap.QueueStatus.Y)
            QueueStatusMinimapButtonBorder:Hide()
        end
    end
end
