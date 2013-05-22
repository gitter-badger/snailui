-- Snail.lua
-- Written by Snail

local Version = "0.7.3"

oUF:RegisterStyle("SnailUI", 
	function(Self, Unit)
		Unit = Unit:gsub("(.)", string.upper, 1)
		
		if GetConfiguration()[Unit] then
			Self.Frame = Unit
			
			HandleBattlegroundAutoRelease(Self)
			HandleBurningEmbersBar(Self)
			HandleCastingBar(Self)
			HandleChiBar(Self)
			HandleColors(Self)
			HandleComboPointsBar(Self)
			HandleDebuffIndicators(Self)
			HandleDemonicFuryBar(Self)
			HandleEclipseBar(Self)			
			HandleHealingIndicators(Self)
			HandleHealthBar(Self)
			HandleHolyPowerBar(Self)
			HandlePortrait(Self)
			HandlePowerBar(Self)
			HandleRunesBar(Self)
			HandleShadowOrbsBar(Self)
			HandleSoulShardsBar(Self)
			HandleSpellRange(Self)
			HandleUnit(Self)
			HandleVendorAutoRepair(Self)
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
		HandleBank()
		HandleBlizzardFrames()
		HandleBuffs()
		HandleChat()
		HandleConsoleVariables()
		HandleExperienceBar()
		HandleExtraButton()
		HandleFocus(Self)
		HandleFocusTarget(Self)
		HandleInterfaceOptions(Version)
		HandleMeter()
		HandleMinimap()
		HandlePet(Self)
		HandlePlayer(Self)
		HandleRaid(Self)
		HandleTarget(Self)
		HandleTargetTarget(Self)
		HandleTimers()
		HandleTooltip()

		Self:SetActiveStyle("SnailUI")
	end
)
