-- Functions.lua
-- Written by Snail

function AddPet(Pets, PlayerGUID, PetGUID)
    if PlayerGUID and PetGUID then
        if not Pets[PlayerGUID] then
            Pets[PlayerGUID] = {}
        end

        Pets[PlayerGUID][#Pets[PlayerGUID] + 1] = PetGUID
    end
end

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

function GetData(Data, GUID)
    if Data and GUID then
        for _, Unit in ipairs(Data) do
            if Unit.GUID == GUID then
                return Unit
            end
        end
    end

    return nil
end

function GetDuration(Time)
    if Time >= 3600 then
        return math.ceil((Time / 60) / 60) .. "H"
    elseif Time >= 60 then
        return math.ceil(Time / 60) .. "M"
    end

    return math.ceil(Time)
end

function GetPetOwner(Pets, GUID)
    if Pets and GUID then
        for PlayerGUID, Player in pairs(Pets) do
            for _, PetGUID in ipairs(Player) do
                if PetGUID == GUID then
                    return PlayerGUID
                end
            end
        end
    end

    return nil
end

function ShortNumber(Number)
    if Number > 999999 then
        return string.format("%.1fM", Number / 1000000)
    elseif Number > 9999 then
        return string.format("%.1fK", Number / 1000)
    end

    return Number
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

function Trim3(String1)
    if String1:len() > 9 then
        return String1:sub(1, 7) .. "..."
    end

    return String1
end
