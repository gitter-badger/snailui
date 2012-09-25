-- Classes.lua
-- Written by Snail

Configuration.Themes[Configuration.theme]['DEATHKNIGHT'] = DefaultWithClassBar
Configuration.Themes[Configuration.theme]['DEATHKNIGHT']['UNHOLY'] = DefaultWithClassBarWithPet
Configuration.Themes[Configuration.theme]['DRUID'] = Configuration.Themes.Default
Configuration.Themes[Configuration.theme]['DRUID']['BALANCE'] = DefaultWithClassBar
Configuration.Themes[Configuration.theme]['DRUID']['FERAL'] = DefaultWithClassBar
Configuration.Themes[Configuration.theme]['DRUID']['RESTORATION'] = DefaultHealer
Configuration.Themes[Configuration.theme]['HUNTER'] = DefaultWithPet
Configuration.Themes[Configuration.theme]['MAGE'] = Configuration.Themes.Default
Configuration.Themes[Configuration.theme]['MAGE']['FROST'] = DefaultWithPet
Configuration.Themes[Configuration.theme]['PALADIN'] = DefaultWithClassBar
Configuration.Themes[Configuration.theme]['PALADIN']['HOLY'] = DefaultHealerWithClassBar
Configuration.Themes[Configuration.theme]['PRIEST'] = DefaultHealer
Configuration.Themes[Configuration.theme]['PRIEST']['SHADOW'] = DefaultWithClassBar
Configuration.Themes[Configuration.theme]['ROGUE'] = DefaultWithClassBar
Configuration.Themes[Configuration.theme]['SHAMAN'] = Configuration.Themes.Default
Configuration.Themes[Configuration.theme]['SHAMAN']['RESTORATION'] = DefaultHealer
Configuration.Themes[Configuration.theme]['WARLOCK'] = DefaultWithClassBarWithPet

function warlockCheckForSacrifice()
    _, _, _, _, selected = GetTalentInfo(15)

    if selected == true then
        Configuration.Themes[Configuration.theme]['WARLOCK'] = DefaultWithClassBar
    end
end
