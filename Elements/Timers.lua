-- Timers.lua
-- Written by Snail

function HandleTimers()
    if GetConfiguration().Timers then
        local Class = select(2, UnitClass("Player"))
        local Specialization = GetSpecialization()

        if Specialization then
            Specialization = select(2, GetSpecializationInfo(Specialization))
            Specialization = Specialization:gsub("(.)", string.upper)
        end

        local Timers = {}

        if GetConfiguration().Timers[Class] then
            if GetConfiguration().Timers[Class][Specialization] then
                for I = 1, #GetConfiguration().Timers[Class][Specialization] do
                    Timers[#Timers + 1] = GetConfiguration().Timers[Class][Specialization][I]
                end
            end

            for I = 1, #GetConfiguration().Timers[Class] do
                Timers[#Timers + 1] = GetConfiguration().Timers[Class][I]
            end
        end

        if #Timers > 0 then
            local TimerBars = CreateFrame("Frame", nil, UIParent)

            for I = 1, #Timers do
                TimerBars[I] = CreateFrame("StatusBar", nil, UIParent)
                TimerBars[I]:Hide()
                TimerBars[I]:RegisterEvent("PLAYER_ENTERING_WORLD")
                TimerBars[I]:RegisterEvent("PLAYER_TARGET_CHANGED")
                TimerBars[I]:RegisterEvent("SPELL_UPDATE_COOLDOWN")
                TimerBars[I]:RegisterEvent("UNIT_AURA")
                TimerBars[I]:SetPoint(Timers[I].Anchor, Timers[I].X, Timers[I].Y)
                TimerBars[I]:SetSize(Timers[I].Width - 6, Timers[I].Height - 6)
                TimerBars[I]:SetStatusBarTexture(Configuration.Texture)
                TimerBars[I]:SetStatusBarColor(Timers[I].Color.R, Timers[I].Color.G, Timers[I].Color.B)
                TimerBars[I]:SetScript("OnEvent",
                    function(Self, Event, Unit)
                        if not Self.Timer.Unit then
                            Self.Timer.Unit = "Player"
                        end

                        if Unit then
                            Unit = Unit:gsub("(.)", string.upper, 1)
                        else
                            if Event == "PLAYER_TARGET_CHANGED" then
                                Unit = "Target"
                            else
                                Unit = "Player"
                            end
                        end

                        if Unit == Self.Timer.Unit then
                            if Self.Timer.Type == "Buff" then
                                if UnitBuff(Unit, Self.Timer.Spell, nil, "PLAYER") then
                                    Self:Show()
                                end
                            elseif Self.Timer.Type == "Cooldown" then
                                local Start, Duration = GetSpellCooldown(Self.Timer.Spell)

                                if Duration and (Duration > 2) then
                                    Self:Show()
                                end
                            elseif Self.Timer.Type == "Debuff" then
                                if UnitDebuff(Unit, Self.Timer.Spell, nil, "PLAYER") then
                                    Self:Show()
                                end
                            end
                        end
                    end
                )

                TimerBars[I]:SetScript("OnHide",
                    function(Self)
                        Self:SetScript("OnUpdate", nil)
                    end
                )

                TimerBars[I]:SetScript("OnShow",
                    function(Self)
                        Self:SetScript("OnUpdate",
                            function(Self, ElapsedTime)
                                local SpellCount
                                local SpellDuration
                                local SpellExpires
                                local SpellIcon
                                local SpellName

                                if Self.Timer.Type == "Buff" then
                                    SpellName, _, SpellIcon, SpellCount, _, SpellDuration, SpellExpires = UnitBuff(Self.Timer.Unit, Self.Timer.Spell, nil, "PLAYER")
                                elseif Self.Timer.Type == "Cooldown" then
                                    SpellExpires, SpellDuration, Enabled = GetSpellCooldown(Self.Timer.Spell)

                                    if SpellDuration > 2 then
                                        SpellName, _, SpellIcon = GetSpellInfo(Self.Timer.Spell)
                                        SpellExpires = SpellExpires + SpellDuration
                                    end
                                elseif Self.Timer.Type == "Debuff" then
                                    SpellName, _, SpellIcon, SpellCount, _, SpellDuration, SpellExpires = UnitDebuff(Self.Timer.Unit, Self.Timer.Spell, nil, "PLAYER")
                                end

                                if SpellName then
                                    if SpellDuration > 0 then
                                        Self:SetMinMaxValues(0, SpellDuration)
                                        Self:SetValue(SpellExpires - GetTime())

                                        Self.Time:SetText(math.ceil(SpellExpires - GetTime()))
                                    else
                                        Self:SetMinMaxValues(0, 1)
                                        Self:SetValue(1)

                                        Self.Time:SetText(nil)
                                    end

                                    Self.Icon:SetTexture(SpellIcon)

                                    if SpellCount and (SpellCount > 1) then
                                        Self.Text:SetText(SpellName .. ": " .. SpellCount)
                                    else
                                        Self.Text:SetText(SpellName)
                                    end
                                else
                                    Self:Hide()
                                end
                            end
                        )
                    end
                )

                TimerBars[I].BackgroundBottom = TimerBars[I]:CreateTexture(nil, "LOW")
                TimerBars[I].BackgroundBottom:SetPoint("BOTTOM", 0, -2)
                TimerBars[I].BackgroundBottom:SetSize(Timers[I].Width - 2, 1)
                TimerBars[I].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                TimerBars[I].BackgroundLeft = TimerBars[I]:CreateTexture(nil, "LOW")
                TimerBars[I].BackgroundLeft:SetPoint("LEFT", -2, 0)
                TimerBars[I].BackgroundLeft:SetSize(1, Timers[I].Height - 4)
                TimerBars[I].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                TimerBars[I].BackgroundRight = TimerBars[I]:CreateTexture(nil, "LOW")
                TimerBars[I].BackgroundRight:SetPoint("RIGHT", 2, 0)
                TimerBars[I].BackgroundRight:SetSize(1, Timers[I].Height - 4)
                TimerBars[I].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                TimerBars[I].BackgroundTop = TimerBars[I]:CreateTexture(nil, "LOW")
                TimerBars[I].BackgroundTop:SetPoint("TOP", 0, 2)
                TimerBars[I].BackgroundTop:SetSize(Timers[I].Width - 2, 1)
                TimerBars[I].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                TimerBars[I].Border = TimerBars[I]:CreateTexture(nil, "BACKGROUND")
                TimerBars[I].Border:SetPoint("TOPLEFT", -3, 3)
                TimerBars[I].Border:SetSize(Timers[I].Width, Timers[I].Height)
                TimerBars[I].Border:SetTexture(0, 0, 0)

                TimerBars[I].Icon = TimerBars[I]:CreateTexture(nil, "LOW")
                TimerBars[I].Icon:SetPoint("LEFT", -(Timers[I].Height * 2) - 4, 0)
                TimerBars[I].Icon:SetSize((Timers[I].Height * 2) - 6, Timers[I].Height - 6)
                TimerBars[I].Icon:SetTexCoord(0.1, 0.9, 0.3, 0.7)

                TimerBars[I].IconBackgroundBottom = TimerBars[I]:CreateTexture(nil, "LOW")
                TimerBars[I].IconBackgroundBottom:SetPoint("BOTTOM", TimerBars[I].Icon, 0, -2)
                TimerBars[I].IconBackgroundBottom:SetSize((Timers[I].Height * 2) - 2, 1)
                TimerBars[I].IconBackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                TimerBars[I].IconBackgroundLeft = TimerBars[I]:CreateTexture(nil, "LOW")
                TimerBars[I].IconBackgroundLeft:SetPoint("LEFT", TimerBars[I].Icon, -2, 0)
                TimerBars[I].IconBackgroundLeft:SetSize(1, Timers[I].Height - 4)
                TimerBars[I].IconBackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                TimerBars[I].IconBackgroundRight = TimerBars[I]:CreateTexture(nil, "LOW")
                TimerBars[I].IconBackgroundRight:SetPoint("RIGHT", TimerBars[I].Icon, 2, 0)
                TimerBars[I].IconBackgroundRight:SetSize(1, Timers[I].Height - 4)
                TimerBars[I].IconBackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                TimerBars[I].IconBackgroundTop = TimerBars[I]:CreateTexture(nil, "LOW")
                TimerBars[I].IconBackgroundTop:SetPoint("TOP", TimerBars[I].Icon, 0, 2)
                TimerBars[I].IconBackgroundTop:SetSize((Timers[I].Height * 2) - 2, 1)
                TimerBars[I].IconBackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                TimerBars[I].IconBorder = TimerBars[I]:CreateTexture(nil, "BACKGROUND")
                TimerBars[I].IconBorder:SetPoint("TOPLEFT", TimerBars[I].Icon, -3, 3)
                TimerBars[I].IconBorder:SetSize(Timers[I].Height * 2, Timers[I].Height)
                TimerBars[I].IconBorder:SetTexture(0, 0, 0)

                TimerBars[I].Text = TimerBars[I]:CreateFontString(nil, "OVERLAY")
                TimerBars[I].Text:SetJustifyH("LEFT")
                TimerBars[I].Text:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                TimerBars[I].Text:SetPoint("LEFT", 6, 0)
                TimerBars[I].Text:SetTextColor(Timers[I].Color.R, Timers[I].Color.G, Timers[I].Color.B)

                TimerBars[I].Time = TimerBars[I]:CreateFontString(nil, "OVERLAY")
                TimerBars[I].Time:SetJustifyH("RIGHT")
                TimerBars[I].Time:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                TimerBars[I].Time:SetPoint("RIGHT", -4, 0)
                TimerBars[I].Time:SetTextColor(Timers[I].Color.R, Timers[I].Color.G, Timers[I].Color.B)

                TimerBars[I].Timer = Timers[I]
            end
        end
    end
end
