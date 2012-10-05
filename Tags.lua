-- Tags.lua
-- Written by Snail

oUF.Tags.Events["SnailUI:EclipseDirection"] = "ECLIPSE_DIRECTION_CHANGE"
oUF.Tags.Events["SnailUI:Health"] = "UNIT_HEALTH UNIT_HEAL_PREDICTION"
oUF.Tags.Events["SnailUI:SmallHealth"] = "UNIT_HEALTH UNIT_HEAL_PREDICTION"

oUF.Tags.Methods["SnailUI:EclipseDirection"] = function(Unit)
    local Direction = GetEclipseDirection()

    if Direction == "moon" then
        return "<-"
    elseif Direction == "sun" then
        return "->"
    end

    return nil
end

oUF.Tags.Methods["SnailUI:Health"] = function(Unit)
    local Health = Trim(GetUnitName(Unit, false))

    if math.floor(((UnitHealth(Unit) / UnitHealthMax(Unit)) * 100) + 0.5) < 100 then
        if UnitGetIncomingHeals(Unit) then
            Health = math.floor((((UnitHealth(Unit) + UnitGetIncomingHeals(Unit)) / UnitHealthMax(Unit)) * 100) + 0.5) .. "%"
        else
            Health = math.floor(((UnitHealth(Unit) / UnitHealthMax(Unit)) * 100) + 0.5) .. "%"
        end
    end

    if UnitIsDead(Unit) then
        Health = Trim(GetUnitName(Unit, false), " | Dead")
    end

    if UnitIsGhost(Unit) then
        Health = Trim(GetUnitName(Unit, false), " | Ghost")
    end

    if UnitIsAFK(Unit) then
        Health = Trim(GetUnitName(Unit, false), " | AFK")
    end

    if not UnitIsConnected(Unit) then
        Health = Trim(GetUnitName(Unit, false), " | D/C")
    end

    return Health
end

oUF.Tags.Methods["SnailUI:SmallHealth"] = function(Unit)
    local Health = Trim2(GetUnitName(Unit, false))

    if math.floor(((UnitHealth(Unit) / UnitHealthMax(Unit)) * 100) + 0.5) < 100 then
        if UnitGetIncomingHeals(Unit) then
            Health = math.floor((((UnitHealth(Unit) + UnitGetIncomingHeals(Unit)) / UnitHealthMax(Unit)) * 100) + 0.5) .. "%"
        else
            Health = math.floor(((UnitHealth(Unit) / UnitHealthMax(Unit)) * 100) + 0.5) .. "%"
        end
    end

    if UnitIsDead(Unit) then
        Health = "DEA"
    end

    if UnitIsGhost(Unit) then
        Health = "GHO"
    end

    if UnitIsAFK(Unit) then
        Health = "AFK"
    end

    if not UnitIsConnected(Unit) then
        Health = "D/C"
    end

    return Health
end
