-- Meter.lua
-- Written by Snail

RAID_CLASS_COLORS["UNKNOWN"] =
{
    b = 1,
    g = 0,
    r = 1
}

if not MeterData then
    MeterData =
    {
        Absorbs = {},
        CombatTime = 0,
        Data = {},
        InCombat = nil,
        Pets = {},
        TotalDamage = 0,
        TotalHealing = 0
    }
end

local function RefreshMeter(Self)
    table.sort(MeterData.Data,
        function(A, B)
            if A[MeterData.Mode] and B[MeterData.Mode] then
                return A[MeterData.Mode] > B[MeterData.Mode]
            end

            return nil
        end
    )

    local MaxAmount = 0

    for I = 1, #MeterData.Data do
        if MeterData.Data[I][MeterData.Mode] then
            if MeterData.Data[I][MeterData.Mode] > MaxAmount then
                MaxAmount = MeterData.Data[I][MeterData.Mode]
            end
        end
    end

    for I = 1, #Self.Bars do
        if MeterData.Data[(I - 1) + MeterData.Position] then
            if MeterData.Data[(I - 1) + MeterData.Position][MeterData.Mode] then
                if MeterData.Data[(I - 1) + MeterData.Position][MeterData.Mode] > 0 then
                    Self.Bars[I]:SetMinMaxValues(0, MaxAmount)
                    Self.Bars[I]:SetValue(MeterData.Data[(I - 1) + MeterData.Position][MeterData.Mode])
                    Self.Bars[I]:Show()

                    if MeterData.Data[(I - 1) + MeterData.Position].Hostile then
                        Self.Bars[I]:SetStatusBarColor(RAID_CLASS_COLORS[MeterData.Data[(I - 1) + MeterData.Position].Class or "UNKNOWN"].r / 2, RAID_CLASS_COLORS[MeterData.Data[(I - 1) + MeterData.Position].Class or "UNKNOWN"].g / 2, RAID_CLASS_COLORS[MeterData.Data[(I - 1) + MeterData.Position].Class or "UNKNOWN"].b / 2)
                        Self.Bars[I].LeftText:SetTextColor(RAID_CLASS_COLORS[MeterData.Data[(I - 1) + MeterData.Position].Class or "UNKNOWN"].r / 2, RAID_CLASS_COLORS[MeterData.Data[(I - 1) + MeterData.Position].Class or "UNKNOWN"].g / 2, RAID_CLASS_COLORS[MeterData.Data[(I - 1) + MeterData.Position].Class or "UNKNOWN"].b / 2)
                        Self.Bars[I].RightText:SetTextColor(RAID_CLASS_COLORS[MeterData.Data[(I - 1) + MeterData.Position].Class or "UNKNOWN"].r / 2, RAID_CLASS_COLORS[MeterData.Data[(I - 1) + MeterData.Position].Class or "UNKNOWN"].g / 2, RAID_CLASS_COLORS[MeterData.Data[(I - 1) + MeterData.Position].Class or "UNKNOWN"].b / 2)
                    else
                        Self.Bars[I]:SetStatusBarColor(RAID_CLASS_COLORS[MeterData.Data[(I - 1) + MeterData.Position].Class or "UNKNOWN"].r, RAID_CLASS_COLORS[MeterData.Data[(I - 1) + MeterData.Position].Class or "UNKNOWN"].g, RAID_CLASS_COLORS[MeterData.Data[(I - 1) + MeterData.Position].Class or "UNKNOWN"].b)
                        Self.Bars[I].LeftText:SetTextColor(RAID_CLASS_COLORS[MeterData.Data[(I - 1) + MeterData.Position].Class or "UNKNOWN"].r, RAID_CLASS_COLORS[MeterData.Data[(I - 1) + MeterData.Position].Class or "UNKNOWN"].g, RAID_CLASS_COLORS[MeterData.Data[(I - 1) + MeterData.Position].Class or "UNKNOWN"].b)
                        Self.Bars[I].RightText:SetTextColor(RAID_CLASS_COLORS[MeterData.Data[(I - 1) + MeterData.Position].Class or "UNKNOWN"].r, RAID_CLASS_COLORS[MeterData.Data[(I - 1) + MeterData.Position].Class or "UNKNOWN"].g, RAID_CLASS_COLORS[MeterData.Data[(I - 1) + MeterData.Position].Class or "UNKNOWN"].b)
                    end

                    Self.Bars[I].LeftText:SetText(Trim3(((I - 1) + MeterData.Position) .. ". " .. MeterData.Data[(I - 1) + MeterData.Position].Name))

                    if (MeterData.Data[(I - 1) + MeterData.Position].EndTime - MeterData.Data[(I - 1) + MeterData.Position].StartTime) > 0 then
                        Self.Bars[I].RightText:SetText(ShortNumber(MeterData.Data[(I - 1) + MeterData.Position][MeterData.Mode]) .. " (" .. ShortNumber(math.floor((MeterData.Data[(I - 1) + MeterData.Position][MeterData.Mode] / (MeterData.Data[(I - 1) + MeterData.Position].EndTime - MeterData.Data[(I - 1) + MeterData.Position].StartTime)) + 0.05)) .. ")")
                    else
                        Self.Bars[I].RightText:SetText(ShortNumber(MeterData.Data[(I - 1) + MeterData.Position][MeterData.Mode]) .. " (" .. ShortNumber(math.floor(MeterData.Data[(I - 1) + MeterData.Position][MeterData.Mode] + 0.05)) .. ")")
                    end
                else
                    Self.Bars[I]:Hide()
                end
            else
                Self.Bars[I]:Hide()
            end
        else
            Self.Bars[I]:Hide()
        end
    end
end

function HandleMeter()
    if GetConfiguration().Meter then
        local LoginTime = time()

        if not LogoutTime then
            LogoutTime = 0
        end

        if (LoginTime - LogoutTime) >= 180 then
            MeterData.Absorbs = {}
            MeterData.Pets = {}
        end

        if not MeterData.Mode then
            MeterData.Mode = "Damage"
        end

        if not MeterData.Position then
            MeterData.Position = 1
        end

        local Class = select(2, UnitClass("Player"))
        local Meter = CreateFrame("Frame", nil, UIParent)

        Meter:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        Meter:RegisterEvent("PLAYER_LOGOUT")
        Meter:RegisterEvent("PLAYER_REGEN_DISABLED")
        Meter:RegisterEvent("PLAYER_REGEN_ENABLED")
        Meter:SetPoint(GetConfiguration().Meter.Anchor, GetConfiguration().Meter.X, GetConfiguration().Meter.Y)
        Meter:SetSize(GetConfiguration().Meter.Width - 6, GetConfiguration().Meter.Height - 6)
        Meter:SetScript("OnEvent",
            function(Self, Event, ...)
                if Event == "PLAYER_REGEN_DISABLED" then
                    MeterData.CombatTime = 0
                    MeterData.Data = {}
                    MeterData.InCombat = true
                    MeterData.Position = 1
                    MeterData.TotalDamage = 0
                    MeterData.TotalHealing = 0

                    AddPet(MeterData.Pets, UnitGUID("Player"), UnitGUID("Pet"))

                    if GetNumGroupMembers() > 0 then
                        local InRaid = IsInRaid()
                        local Frame

                        if InRaid then
                            Frame = "Raid"
                        else
                            Frame = "Party"
                        end

                        for I = 1, GetNumGroupMembers() do
                            AddPet(MeterData.Pets, UnitGUID(Frame .. I), UnitGUID(Frame .. I .. "Pet"))
                        end
                    end

                    RefreshMeter(Meter)
                    Meter:SetScript("OnUpdate",
                        function(Self, ElapsedTime)
                            if not Self.Time then
                                Self.Time = 0
                            end

                            if (Self.Time + ElapsedTime) >= 1 then
                                RefreshMeter(Self)
                                Self.Time = 0
                            else
                                Self.Time = Self.Time + ElapsedTime
                            end
                        end
                    )
                elseif Event == "PLAYER_REGEN_ENABLED" then
                    MeterData.CombatTime = GetTime()
                    MeterData.InCombat = nil
                    Meter:SetScript("OnUpdate", nil)

                    RefreshMeter(Meter)
                elseif Event == "PLAYER_LOGOUT" then
                    LogoutTime = time()
                elseif Event == "COMBAT_LOG_EVENT_UNFILTERED" then
                    local CombatEvent = select(2, ...)

                    if (select(3, ...) == false) then
                        if string.find(CombatEvent, "_MISSED") then
                            local Amount
                            local Flags = select(10, ...)
                            local Type

                            if string.find(CombatEvent, "SWING") then
                                Amount = select(14, ...)
                                Type = select(12, ...)
                            else
                                Amount = select(17, ...)
                                Type = select(15, ...)
                            end

                            if Amount and (Amount > 0) and MeterData.InCombat and (Type == "ABSORB") and ((bit.band(Flags, COMBATLOG_OBJECT_TYPE_GUARDIAN) ~= 0) or (bit.band(Flags, COMBATLOG_OBJECT_TYPE_PET) ~= 0) or (bit.band(Flags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0)) then
                                local Class
                                local Data
                                local GUID = select(8, ...)
                                local IsPet
                                local Name
                                local Realm

                                if (bit.band(Flags, COMBATLOG_OBJECT_TYPE_GUARDIAN) ~= 0) or (bit.band(Flags, COMBATLOG_OBJECT_TYPE_PET) ~= 0) then
                                    GUID = GetPetOwner(MeterData.Pets, GUID)

                                    if not GUID then
                                        GUID = select(8, ...)
                                        IsPet = true
                                    end
                                end

                                Data = GetData(MeterData.Data, GUID)

                                if not IsPet then
                                    _, Class, _, _, _, Name, Realm = GetPlayerInfoByGUID(GUID)
                                end

                                if not Name then
                                    Name = select(9, ...)
                                end

                                if not Data then
                                    MeterData.Data[#MeterData.Data + 1] =
                                    {
                                        Class = Class or "UNKNOWN",
                                        Damage = 0,
                                        EndTime = 0,
                                        GUID = GUID,
                                        Healing = 0,
                                        Name = Name or "UNKNOWN",
                                        Realm = Realm or "",
                                        StartTime = GetTime()
                                    }

                                    Data = MeterData.Data[#MeterData.Data]
                                end

                                if not MeterData.Absorbs then
                                    MeterData.Absorbs = {}
                                end

                                if MeterData.Absorbs[GUID] then
                                    for _, Info in pairs(MeterData.Absorbs[GUID]) do
                                        local SpellName = select(1, GetSpellInfo(Info.Spell))

                                        for I = 1, 40 do
                                            local BuffName, _, _, _, _, _, _, BuffCasterUnit, _, _, _, _, _, _, BuffAmount = UnitBuff(Name, I)

                                            if BuffName and BuffCasterUnit then
                                                local BuffCasterGUID = UnitGUID(BuffCasterUnit)
                                                local SourceGUID = Info.SourceGUID

                                                if BuffAmount and BuffCasterGUID and (BuffCasterGUID == SourceGUID) and (BuffName == SpellName) and (Info.Amount ~= BuffAmount) then
                                                    local IsPet
                                                    
                                                    if (bit.band(Info.SourceFlags, COMBATLOG_OBJECT_TYPE_GUARDIAN) ~= 0) or (bit.band(Info.SourceFlags, COMBATLOG_OBJECT_TYPE_PET) ~= 0) then
                                                        SourceGUID = GetPetOwner(MeterData.Pets, SourceGUID)

                                                        if not GUID then
                                                            SourceGUID = Info.SourceGUID
                                                            IsPet = true
                                                        end
                                                    end

                                                    local SourceData = GetData(MeterData.Data, SourceGUID)

                                                    if not SourceData then
                                                        local SourceClass
                                                        local SourceName
                                                        local SourceRealm

                                                        if not IsPet then
                                                            _, SourceClass, _, _, _, SourceName, SourceRealm = GetPlayerInfoByGUID(SourceGUID)
                                                        end

                                                        if not SourceName then
                                                            SourceName = Info.SourceName
                                                        end

                                                        MeterData.Data[#MeterData.Data + 1] =
                                                        {
                                                            Class = SourceClass or "UNKNOWN",
                                                            Damage = 0,
                                                            EndTime = 0,
                                                            GUID = SourceGUID,
                                                            Healing = 0,
                                                            Name = SourceName or "UNKNOWN",
                                                            Realm = SourceRealm or "",
                                                            StartTime = GetTime()
                                                        }

                                                        SourceData = MeterData.Data[#MeterData.Data]
                                                    end

                                                    SourceData.Healing = SourceData.Healing + math.floor(Info.Amount - BuffAmount)
                                                    MeterData.TotalHealing = MeterData.TotalHealing + math.floor(Info.Amount - BuffAmount)
                                                    Info.Amount = BuffAmount

                                                    if MeterData.InCombat then
                                                        SourceData.EndTime = GetTime()
                                                    else
                                                        if SourceData.EndTime == 0 then
                                                            SourceData.EndTime = MeterData.CombatTime
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        elseif (CombatEvent == "DAMAGE_SHIELD") or (CombatEvent == "DAMAGE_SPLIT") or string.find(CombatEvent, "_AURA_APPLIED") or string.find(CombatEvent, "_AURA_REFRESH") or string.find(CombatEvent, "_AURA_REMOVED") or string.find(CombatEvent, "_DAMAGE") or string.find(CombatEvent, "_DRAIN") or string.find(CombatEvent, "_EXTRA_ATTACKS") or string.find(CombatEvent, "_HEAL") or string.find(CombatEvent, "_LEECH") then
                            local Data
                            local Flags

                            if string.find(CombatEvent, "_AURA_APPLIED") or string.find(CombatEvent, "_AURA_REFRESH") or string.find(CombatEvent, "_AURA_REMOVED") then
                                Flags = select(10, ...)
                            else
                                Flags = select(6, ...)
                            end

                            if (MeterData.InCombat or ((string.find(CombatEvent, "_AURA_APPLIED") or string.find(CombatEvent, "_AURA_REFRESH") or string.find(CombatEvent, "_AURA_REMOVED")))) and ((bit.band(Flags, COMBATLOG_OBJECT_TYPE_GUARDIAN) ~= 0) or (bit.band(Flags, COMBATLOG_OBJECT_TYPE_PET) ~= 0) or (bit.band(Flags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0)) then
                                local Class
                                local GUID
                                local IsPet
                                local Name
                                local Realm

                                if string.find(CombatEvent, "_AURA_APPLIED") or string.find(CombatEvent, "_AURA_REFRESH") or string.find(CombatEvent, "_AURA_REMOVED") then
                                    GUID = select(8, ...)
                                else
                                    GUID = select(4, ...)
                                end

                                if (bit.band(Flags, COMBATLOG_OBJECT_TYPE_GUARDIAN) ~= 0) or (bit.band(Flags, COMBATLOG_OBJECT_TYPE_PET) ~= 0) then
                                    GUID = GetPetOwner(MeterData.Pets, GUID)

                                    if not GUID then
                                        if string.find(CombatEvent, "_AURA_APPLIED") or string.find(CombatEvent, "_AURA_REFRESH") or string.find(CombatEvent, "_AURA_REMOVED") then
                                            GUID = select(8, ...)
                                        else
                                            GUID = select(4, ...)
                                        end

                                        IsPet = true
                                    end
                                end

                                Data = GetData(MeterData.Data, GUID)

                                if not Data then
                                    if not IsPet then
                                        _, Class, _, _, _, Name, Realm = GetPlayerInfoByGUID(GUID)
                                    end

                                    if not Name then
                                        if string.find(CombatEvent, "_AURA_APPLIED") or string.find(CombatEvent, "_AURA_REFRESH") or string.find(CombatEvent, "_AURA_REMOVED") then
                                            Name = select(9, ...)
                                        else
                                            Name = select(5, ...)
                                        end
                                    end

                                    MeterData.Data[#MeterData.Data + 1] =
                                    {
                                        Class = Class or "UNKNOWN",
                                        Damage = 0,
                                        EndTime = 0,
                                        GUID = GUID,
                                        Healing = 0,
                                        Name = Name or "UNKNOWN",
                                        Realm = Realm or "",
                                        StartTime = GetTime()
                                    }

                                    Data = MeterData.Data[#MeterData.Data]
                                end

                                local Amount

                                if string.find(CombatEvent, "_AURA_APPLIED") or string.find(CombatEvent, "_AURA_REFRESH") or string.find(CombatEvent, "_AURA_REMOVED") then
                                    Amount = select(16, ...)

                                    if Amount and (select(15, ...) == "BUFF") then
                                        if not MeterData.Absorbs then
                                            MeterData.Absorbs = {}
                                        end

                                        local SourceFlags = select(6, ...)
                                        local SourceGUID = select(4, ...)
                                        local SourceName = select(5, ...)
                                        local Spell = select(12, ...)

                                        if string.find(CombatEvent, "_AURA_APPLIED") or string.find(CombatEvent, "_AURA_REFRESH") then
                                            local Absorb = GetAbsorb(MeterData.Absorbs, GUID, Spell, SourceGUID)

                                            if Absorb then
                                                Absorb.Amount = Amount
                                                Absorb.SourceFlags = SourceFlags
                                                Absorb.SourceName = SourceName
                                            else
                                                MeterData.Absorbs[GUID][#MeterData.Absorbs[GUID] + 1] =
                                                {
                                                    Amount = Amount,
                                                    SourceFlags = SourceFlags,
                                                    SourceGUID = SourceGUID,
                                                    SourceName = SourceName,
                                                    Spell = Spell
                                                }
                                            end
                                        elseif string.find(CombatEvent, "_AURA_REMOVED") then
                                            local Absorb, AbsorbIndex = GetAbsorb(MeterData.Absorbs, GUID, Spell, SourceGUID)

                                            if Absorb then
                                                if Absorb.Amount > Amount then
                                                    local SourceClass
                                                    local SourceIsPet
                                                    local SourceRealm

                                                    if (bit.band(SourceFlags, COMBATLOG_OBJECT_TYPE_GUARDIAN) ~= 0) or (bit.band(SourceFlags, COMBATLOG_OBJECT_TYPE_PET) ~= 0) then
                                                        SourceGUID = GetPetOwner(MeterData.Pets, SourceGUID)

                                                        if not SourceGUID then
                                                            SourceGUID = select(4, ...)
                                                            SourceIsPet = true
                                                        end
                                                    end

                                                    local SourceData = GetData(MeterData.Data, SourceGUID)

                                                    if not SourceData then
                                                        if not SourceIsPet then
                                                            _, SourceClass, _, _, _, SourceName, SourceRealm = GetPlayerInfoByGUID(SourceGUID)
                                                        end

                                                        if not SourceName then
                                                            SourceName = select(5, ...)
                                                        end

                                                        MeterData.Data[#MeterData.Data + 1] =
                                                        {
                                                            Class = SourceClass or "UNKNOWN",
                                                            Damage = 0,
                                                            EndTime = 0,
                                                            GUID = SourceGUID,
                                                            Healing = 0,
                                                            Name = SourceName or "UNKNOWN",
                                                            Realm = SourceRealm or "",
                                                            StartTime = GetTime()
                                                        }

                                                        SourceData = MeterData.Data[#MeterData.Data]
                                                    end

                                                    if MeterData.InCombat then
                                                        Data.EndTime = GetTime()
                                                    else
                                                        if Data.EndTime == 0 then
                                                            Data.EndTime = MeterData.CombatTime
                                                        end
                                                    end

                                                    Data.Healing = Data.Healing + math.floor(Absorb.Amount - Amount)
                                                    MeterData.TotalHealing = MeterData.TotalHealing + math.floor(Absorb.Amount - Amount)

                                                    if not MeterData.InCombat then
                                                        RefreshMeter(Meter)
                                                    end
                                                end

                                                MeterData.Absorbs[GUID][AbsorbIndex] = nil

                                                table.sort(MeterData.Absorbs[GUID],
                                                    function(A, B)
                                                        if A and B then
                                                            return A.Amount > B.Amount
                                                        end

                                                        return nil
                                                    end
                                                )

                                                if #MeterData.Absorbs[GUID] == 0 then
                                                    MeterData.Absorbs[GUID] = nil
                                                end
                                            end
                                        end
                                    end
                                elseif MeterData.InCombat then
                                    Data.EndTime = GetTime()

                                    if bit.band(Flags, COMBATLOG_OBJECT_REACTION_HOSTILE) ~= 0 then
                                        Data.Hostile = true
                                    else
                                        Data.Hostile = nil
                                    end

                                    if string.find(CombatEvent, "_HEAL") then
                                        Amount = ((select(15, ...) or 0) + (select(17, ...) or 0)) - (select(16, ...) or 0)
                                        Data.Healing = Data.Healing + Amount
                                        MeterData.TotalHealing = MeterData.TotalHealing + Amount
                                    else
                                        if string.find(CombatEvent, "SWING") then
                                            Amount = (select(12, ...) or 0)
                                        else
                                            Amount = (select(15, ...) or 0)

                                            if string.find(CombatEvent, "_DRAIN") or string.find(CombatEvent, "_LEECH") then
                                                if select(16, ...) ~= -2 then
                                                    Amount = 0
                                                end
                                            end
                                        end                                        

                                        Data.Damage = Data.Damage + Amount
                                        MeterData.TotalDamage = MeterData.TotalDamage + Amount
                                    end
                                end
                            end
                        elseif string.find(CombatEvent, "_SUMMON") then
                            AddPet(MeterData.Pets, select(4, ...), select(8, ...))
                        end
                    end
                end
            end
        )

        Meter:SetScript("OnMouseWheel",
            function(Self, Direction)
                if Direction > 0 then
                    if MeterData.Position > 1 then
                        MeterData.Position = MeterData.Position - 1
                        RefreshMeter(Self)
                    end
                else
                    if MeterData.Position < (GetCount(MeterData.Data, MeterData.Mode) - (#Self.Bars - 1)) then
                        MeterData.Position = MeterData.Position + 1
                        RefreshMeter(Self)
                    end
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

        local Bars = CreateFrame("Frame", nil, Meter)
        Meter.Bars = Bars

        for I = 0, #GetConfiguration().Meter do
            if I == 0 then
                Bars[I] = CreateFrame("Frame", nil, Meter)

                Bars[I].LeftText = Bars[I]:CreateFontString(nil, "OVERLAY")
                Bars[I].LeftText:Hide()
                Bars[I].LeftText:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                Bars[I].LeftText:SetJustifyH("LEFT")
                Bars[I].LeftText:SetPoint("LEFT", 5, 0)
                Bars[I].LeftText:SetText("<")
                Bars[I].LeftText:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                Bars[I].LeftTextButton = CreateFrame("Button", nil, Bars[I])
                Bars[I].LeftTextButton:RegisterForClicks("AnyUp")
                Bars[I].LeftTextButton:SetAllPoints(Bars[I].LeftText)
                Bars[I].LeftTextButton:SetScript("OnClick",
                    function(Self)
                        if MeterData.Mode == "Healing" then
                            MeterData.Mode = "Damage"
                            MeterData.Position = 1

                            local Bar = Self:GetParent()

                            Bar.LeftText:Hide()
                            Bar.LeftTextButton:Hide()

                            Bar.RightText:Show()
                            Bar.RightTextButton:Show()

                            Bar.Text:SetText(MeterData.Mode)
                            RefreshMeter(Bar:GetParent())
                        end
                    end
                )

                Bars[I].RightText = Bars[I]:CreateFontString(nil, "OVERLAY")
                Bars[I].RightText:Hide()
                Bars[I].RightText:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                Bars[I].RightText:SetJustifyH("RIGHT")
                Bars[I].RightText:SetPoint("RIGHT", -2, 0)
                Bars[I].RightText:SetText(">")
                Bars[I].RightText:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                Bars[I].RightTextButton = CreateFrame("Button", nil, Bars[I])
                Bars[I].RightTextButton:RegisterForClicks("AnyUp")
                Bars[I].RightTextButton:SetAllPoints(Bars[I].RightText)
                Bars[I].RightTextButton:SetScript("OnClick",
                    function(Self)
                        if MeterData.Mode == "Damage" then
                            MeterData.Mode = "Healing"
                            MeterData.Position = 1

                            local Bar = Self:GetParent()

                            Bar.LeftText:Show()
                            Bar.LeftTextButton:Show()

                            Bar.RightText:Hide()
                            Bar.RightTextButton:Hide()

                            Bar.Text:SetText(MeterData.Mode)
                            RefreshMeter(Bar:GetParent())
                        end
                    end
                )

                Bars[I].Text = Bars[I]:CreateFontString(nil, "OVERLAY")
                Bars[I].Text:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                Bars[I].Text:SetPoint("CENTER", 1, 0)
                Bars[I].Text:SetText(MeterData.Mode)
                Bars[I].Text:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                Bars[I].TextButton = CreateFrame("Button", nil, Bars[I])
                Bars[I].TextButton:RegisterForClicks("AnyUp")
                Bars[I].TextButton:SetAllPoints(Bars[I].Text)
                Bars[I].TextButton:SetScript("OnClick",
                    function(Self)
                        if GetCount(MeterData.Data, MeterData.Mode) > 0 then
                            local Type

                            if GetNumGroupMembers() > 0 then
                                if IsInRaid() then
                                    if UnitInBattleground("Player") then
                                        Type = "BATTLEGROUND"
                                    else
                                        Type = "RAID"
                                    end
                                else
                                    Type = "PARTY"
                                end
                            end

                            SendChatMessage("SnailUI / " .. MeterData.Mode, Type)
                            local Count = GetCount(MeterData.Data, MeterData.Mode)

                            if Count > 10 then
                                Count = 10
                            end

                            for I = 1, Count do
                                local Percent

                                if (MeterData.Data[I].EndTime - MeterData.Data[I].StartTime) > 0 then
                                    Percent = ShortNumber(math.floor((MeterData.Data[I][MeterData.Mode] / (MeterData.Data[I].EndTime - MeterData.Data[I].StartTime)) + 0.05))
                                else
                                    Percent = ShortNumber(math.floor(MeterData.Data[I][MeterData.Mode] + 0.05))
                                end

                                if MeterData.Data[I].Realm:len() > 0 then
                                    SendChatMessage(I .. ". " .. MeterData.Data[I].Name .. "-" .. MeterData.Data[I].Realm .. " " .. ShortNumber(MeterData.Data[I][MeterData.Mode]) .. " (" .. Percent .. ")", Type)
                                else
                                    SendChatMessage(I .. ". " .. MeterData.Data[I].Name .. " " .. ShortNumber(MeterData.Data[I][MeterData.Mode]) .. " (" .. Percent .. ")", Type)
                                end
                            end
                        end
                    end
                )

                if MeterData.Mode == "Damage" then
                    Bars[I].RightText:Show()
                elseif MeterData.Mode == "Healing" then
                    Bars[I].LeftText:Show()
                end
            else
                Bars[I] = CreateFrame("StatusBar", nil, Meter)
                Bars[I]:Hide()
                Bars[I]:SetStatusBarTexture(Configuration.Texture)

                Bars[I].LeftText = Bars[I]:CreateFontString(nil, "OVERLAY")
                Bars[I].LeftText:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                Bars[I].LeftText:SetJustifyH("LEFT")
                Bars[I].LeftText:SetPoint("LEFT", 5, 0)

                Bars[I].RightText = Bars[I]:CreateFontString(nil, "OVERLAY")
                Bars[I].RightText:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                Bars[I].RightText:SetJustifyH("RIGHT")
                Bars[I].RightText:SetPoint("RIGHT", -2, 0)
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

        RefreshMeter(Meter)
    end
end
