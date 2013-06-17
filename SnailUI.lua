-- Snail.lua
-- Written by Snail

local Version = "0.8.1"

oUF:RegisterStyle("SnailUI", 
	function(Self, Unit)
		Unit = Unit:gsub("(.)", string.upper, 1)
		
		if GetConfiguration()[Unit] then
			Self.Frame = Unit
			
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
		end
	end
)

oUF:Factory(
	function(Self)
		if GetConfiguration().Initialize then
			GetConfiguration():Initialize()
		end

		HandleActionBars()
		HandleAutoGreed()
		HandleBag()
		HandleBank()
		HandleBattlegroundAutoRelease()
		HandleBlizzardFrames()
		HandleBuffs()
		HandleChat()
		HandleConsoleVariables()
		HandleExperienceBar()
		HandleExtraButton()
		HandleFocus(Self)
		HandleFocusTarget(Self)
		HandleGarbageCollector()
		HandleInterfaceOptions(Version)
		HandleMeter()
		HandleMinimap()
		HandlePet(Self)
		HandlePlayer(Self)
		HandleRaid(Self)
		HandleTarget(Self)
		HandleTargetTarget(Self)
		HandleTimers()
		HandleTimerTrackers()
		HandleTooltips()
		HandleVendorAutoRepair()

		Self:SetActiveStyle("SnailUI")
	end
)
