-- Snail.lua
-- Written by Snail

local Version = "0.3.4"

oUF:RegisterStyle("SnailUI", 
    local function(Self, Unit)
        Unit = Unit:gsub("(.)", string.upper, 1)
        
        if GetConfiguration()[Unit] then
            Self.Frame = Unit

            HandleUnit(Self)
            HandleBackgroundColors(Self)
            HandleBattlegroundAutoRelease(Self)
            HandleBurningEmbersBar(Self)
            HandleCastingBar(Self)
            HandleChiBar(Self)
            HandleComboPointsBar(Self)
            HandleEclipseBar(Self)
            HandleDemonicFuryBar(Self)
            HandleHealthBar(Self)
            HandleHolyPowerBar(Self)
            HandlePowerBar(Self)
            HandleRunesBar(Self)
            HandleShadowOrbsBar(Self)
            HandleSoulShardsBar(Self)
            HandleSpellRange(Self) 
        end
    end
)

oUF:Factory(
    function(Self)
        if GetConfiguration().Initialize then
            GetConfiguration():Initialize()
        end

        HandleActionBars()
        HandleBag()
        HandleBlizzardFrames()
        HandleBuffs()
        HandleChat()
        HandleConsoleVariables()
        HandleExperience()
        HandleExtraButton()
        HandleFocus()
        HandleFocusTarget()
        HandleInterfaceOptions(Version)
        HandleMinimap()
        HandlePet()
        HandlePlayer()
        HandleRaid()
        HandleTarget()
        HandleTargetTarget()

        Self:SetActiveStyle("SnailUI")
    end
)
