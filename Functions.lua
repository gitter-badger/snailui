-- Functions.lua
-- Written by Snail

function Blank()
end

function DeepCopy(Object)
    local Table = {}

    local function Copy(Object)
        if type(Object) ~= "table" then
            return Object
        elseif Table[Object] then
            return Table[Object]
        end

        local NewTable = {}
        Table[Object] = NewTable

        for Key, Value in pairs(Object) do
            NewTable[Copy(Key)] = Copy(Value)
        end

        return setmetatable(NewTable, getmetatable(Object))
    end

    return Copy(Object)
end

function GetConfiguration()
    local Class = select(2, UnitClass("Player"))
    local Specialization = GetSpecialization()

    if Specialization then
        Specialization = select(2, GetSpecializationInfo(Specialization))
        Specialization = Specialization:gsub("(.)", string.upper)
    else
        Specialization = nil
    end

    if Configuration.Themes[Theme] then
        if Configuration.Themes[Theme][Class] then
            if Specialization then
                if Configuration.Themes[Theme][Class][Specialization] then
                    return Configuration.Themes[Theme][Class][Specialization]
                end
            end

            return Configuration.Themes[Theme][Class]
        end

        return Configuration.Themes[Theme]
    end

    return Configuration.Themes[Configuration.Theme]
end

function Trim(String1, String2)
    if String2 then
        if (String1:len() + String2:len()) > 12 then
            return String1:sub(1, 9 - String2:len()) .. "..." .. String2
        end

        return String1 .. String2
    end

    if String1:len() > 12 then
        return String1:sub(1, 9) .. "..."
    end

    return String1
end

function Trim2(String)
    if String:len() > 3 then
        return String:sub(1, 3)
    end

    return String
end
