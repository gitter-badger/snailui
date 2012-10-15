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
                if Event == "PLAYER_REGEN_DISABLED" then
                    Self.Data =
                    {
                        InCombat = true,
                        TotalDamage = 0,
                        TotalHealing = 0
                    }
                elseif Event == "PLAYER_REGEN_ENABLED" then
                    Self.Data.InCombat = nil
                elseif Event == "COMBAT_LOG_EVENT_UNFILTERED" then
                    if Self.Data.InCombat then
                        local CombatEvent = select(2, ...)

                        if string.find(CombatEvent, "_DAMAGE") or string.find(CombatEvent, "_EXTRA_ATTACKS") then
                            local UnitFlags = select(6, ...)

                            if (bit.band(UnitFlags, COMBATLOG_OBJECT_TYPE_GUARDIAN) ~= 0) or (bit.band(UnitFlags, COMBATLOG_OBJECT_TYPE_PET) ~= 0) or (bit.band(UnitFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0) then
                                local _, PlayerClass, _, _, _, PlayerName, PlayerRealm = GetPlayerInfoByGUID(select(4, ...))
                                local Damage

                                if string.find(CombatEvent, "SWING") then
                                    Damage = select(12, ...)
                                else
                                    Damage = select(15, ...)
                                end

                                local PlayerData = GetData(Self.Data, PlayerName, PlayerRealm)

                                if not PlayerData then
                                    Self.Data[#Self.Data + 1] =
                                    {
                                        Class = PlayerClass,
                                        Damage = 0,
                                        EndTime = 0,
                                        Name = PlayerName,
                                        Realm = PlayerRealm,
                                        StartTime = GetTime()
                                    }

                                    PlayerData = Self.Data[#Self.Data]
                                end

                                PlayerData.Damage = PlayerData.Damage + Damage
                                PlayerData.EndTime = GetTime()

                                Self.Data.TotalDamage = Self.Data.TotalDamage + Damage
                            end
                        elseif CombatEvent == "SPELL_SUMMON" then
                            print("a")
                        end
                    end
                end
            end
        )

        Meter:SetScript("OnUpdate",
            function(Self, ElapsedTime)
                if not Self.Time then
                    Self.Time = 0
                end

                if (Self.Time + ElapsedTime) >= 1 then
                    table.sort(Self.Data,
                        function(A, B)
                            return A.Damage > B.Damage
                        end
                    )

                    for I = 1, #Self.Bars do
                        if Self.Data[I] then
                            Self.Bars[I]:SetMinMaxValues(0, Self.Data.TotalDamage)
                            Self.Bars[I]:SetStatusBarColor(RAID_CLASS_COLORS[Self.Data[I].Class].r, RAID_CLASS_COLORS[Self.Data[I].Class].g, RAID_CLASS_COLORS[Self.Data[I].Class].b)
                            Self.Bars[I]:SetValue(Self.Data[I].Damage)
                            Self.Bars[I]:Show()

                            Self.Bars[I].LeftText:SetText(Trim3(I .. ". " .. Self.Data[I].Name))
                            Self.Bars[I].LeftText:SetTextColor(RAID_CLASS_COLORS[Self.Data[I].Class].r, RAID_CLASS_COLORS[Self.Data[I].Class].g, RAID_CLASS_COLORS[Self.Data[I].Class].b)
                            Self.Bars[I].RightText:SetTextColor(RAID_CLASS_COLORS[Self.Data[I].Class].r, RAID_CLASS_COLORS[Self.Data[I].Class].g, RAID_CLASS_COLORS[Self.Data[I].Class].b)

                            if (Self.Data[I].EndTime - Self.Data[I].StartTime) > 0 then
                                Self.Bars[I].RightText:SetText(ShortNumber(Self.Data[I].Damage) .. " (" .. ShortNumber(math.floor((Self.Data[I].Damage / (Self.Data[I].EndTime - Self.Data[I].StartTime)) + 0.05)) .. ")")
                            else
                                Self.Bars[I].RightText:SetText(ShortNumber(Self.Data[I].Damage) .. " (" .. ShortNumber(math.floor(Self.Data[I].Damage + 0.05)) .. ")")
                            end
                        else
                            Self.Bars[I]:Hide()
                        end
                    end

                    Self.Time = 0
                else
                    Self.Time = Self.Time + ElapsedTime
                end
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

        Meter.Data =
        {
            InCombat = nil,
            TotalDamage = 0,
            TotalHealing = 0
        }

        local Bars = CreateFrame("Frame", nil, Meter)
        Meter.Bars = Bars

        for I = 0, #GetConfiguration().Meter do
            if I == 0 then
                Bars[I] = CreateFrame("Frame", nil, Meter)

                Bars[I].Text = Bars[I]:CreateFontString(nil, "OVERLAY")
                Bars[I].Text:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                Bars[I].Text:SetPoint("CENTER", 1, 0)
                Bars[I].Text:SetText("Damage")
                Bars[I].Text:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
            else
                Bars[I] = CreateFrame("StatusBar", nil, Meter)
                Bars[I]:Hide()
                Bars[I]:SetStatusBarTexture(Configuration.Texture)

                Bars[I].LeftText = Bars[I]:CreateFontString(nil, "OVERLAY")
                Bars[I].LeftText:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                Bars[I].LeftText:SetJustifyH("LEFT")
                Bars[I].LeftText:SetPoint("LEFT", 4, 0)

                Bars[I].RightText = Bars[I]:CreateFontString(nil, "OVERLAY")
                Bars[I].RightText:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                Bars[I].RightText:SetJustifyH("RIGHT")
                Bars[I].RightText:SetPoint("RIGHT", -1, 0)
            end

            Bars[I]:SetPoint(GetConfiguration().Meter[I].Anchor, GetConfiguration().Meter[I].X, GetConfiguration().Meter[I].Y)
            Bars[I]:SetSize(GetConfiguration().Meter[I].Width - 6, GetConfiguration().Meter[I].Height - 6)

            Bars[I].BackgroundBottom = Bars[I]:CreateTexture(nil, "LOW")
            Bars[I].BackgroundBottom:SetPoint("BOTTOM", 0, -2)
            Bars[I].BackgroundBottom:SetSize(GetConfiguration().Meter[I].Width - 2, 1)
            Bars[I].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

            Bars[I].BackgroundLeft = Bars[I]:CreateTexture(nil, "LOW")
            Bars[I].BackgroundLeft:SetPoint("LEFT", -2, 0)
            Bars[I].BackgroundLeft:SetSize(1, GetConfiguration().Meter[I].Height - 4)
            Bars[I].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

            Bars[I].BackgroundRight = Bars[I]:CreateTexture(nil, "LOW")
            Bars[I].BackgroundRight:SetPoint("RIGHT", 2, 0)
            Bars[I].BackgroundRight:SetSize(1, GetConfiguration().Meter[I].Height - 4)
            Bars[I].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

            Bars[I].BackgroundTop = Bars[I]:CreateTexture(nil, "LOW")
            Bars[I].BackgroundTop:SetPoint("TOP", 0, 2)
            Bars[I].BackgroundTop:SetSize(GetConfiguration().Meter[I].Width - 2, 1)
            Bars[I].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

            Bars[I].BorderBottom = Bars[I]:CreateTexture(nil, "BACKGROUND")
            Bars[I].BorderBottom:SetPoint("BOTTOM", 0, -1)
            Bars[I].BorderBottom:SetSize(GetConfiguration().Meter[I].Width, 1)
            Bars[I].BorderBottom:SetTexture(0, 0, 0)

            Bars[I].BorderLeft = Bars[I]:CreateTexture(nil, "BACKGROUND")
            Bars[I].BorderLeft:SetPoint("LEFT", -1, 0)
            Bars[I].BorderLeft:SetSize(1, GetConfiguration().Meter[I].Height - 2)
            Bars[I].BorderLeft:SetTexture(0, 0, 0)

            Bars[I].BorderRight = Bars[I]:CreateTexture(nil, "BACKGROUND")
            Bars[I].BorderRight:SetPoint("RIGHT", 1, 0)
            Bars[I].BorderRight:SetSize(1, GetConfiguration().Meter[I].Height - 2)
            Bars[I].BorderRight:SetTexture(0, 0, 0)

            Bars[I].BorderTop = Bars[I]:CreateTexture(nil, "BACKGROUND")
            Bars[I].BorderTop:SetPoint("TOP", 0, 1)
            Bars[I].BorderTop:SetSize(GetConfiguration().Meter[I].Width, 1)
            Bars[I].BorderTop:SetTexture(0, 0, 0)
        end
    end
end
