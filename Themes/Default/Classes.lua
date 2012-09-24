-- Classes.lua
-- Written by Snail

Configuration['DEATHKNIGHT'] = DefaultWithClassBar
Configuration['DEATHKNIGHT']['UNHOLY'] = DefaultWithClassBarWithPet
Configuration['DRUID'] = Default
Configuration['DRUID']['BALANCE'] = DefaultWithClassBar
Configuration['DRUID']['FERAL'] = DefaultWithClassBar
Configuration['DRUID']['RESTORATION'] = DefaultHealer
Configuration['HUNTER'] = DefaultWithPet
Configuration['MAGE'] = Default
Configuration['MAGE']['FROST'] = DefaultWithPet
Configuration['PALADIN'] = DefaultWithClassBar
Configuration['PALADIN']['HOLY'] = DefaultHealerWithClassBar
Configuration['PRIEST'] = DefaultHealer
Configuration['PRIEST']['SHADOW'] = DefaultWithClassBar
Configuration['ROGUE'] = DefaultWithClassBar
Configuration['SHAMAN'] = Default
Configuration['SHAMAN']['RESTORATION'] = DefaultHealer
Configuration['WARLOCK'] = DefaultWithClassBarWithPet

function warlockCheckForSacrifice()
    _, _, _, _, selected = GetTalentInfo(15)

    if selected == true then
        Configuration['WARLOCK'] = DefaultWithClassBar
    end
end
