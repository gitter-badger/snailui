local _, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, "oUF_WarlockSpecBars was unable to locate oUF install")

if select(2, UnitClass("player")) ~= "WARLOCK" then return end

local MAX_POWER_PER_EMBER = 10
local SPELL_POWER_DEMONIC_FURY = SPELL_POWER_DEMONIC_FURY
local SPELL_POWER_BURNING_EMBERS = SPELL_POWER_BURNING_EMBERS
local SPELL_POWER_SOUL_SHARDS = SPELL_POWER_SOUL_SHARDS
local SPEC_WARLOCK_DESTRUCTION = SPEC_WARLOCK_DESTRUCTION
local SPEC_WARLOCK_DESTRUCTION_GLYPH_EMBERS = 63304
local SPEC_WARLOCK_AFFLICTION = SPEC_WARLOCK_AFFLICTION
local SPEC_WARLOCK_AFFLICTION_GLYPH_SHARDS = 63302
local SPEC_WARLOCK_DEMONOLOGY = SPEC_WARLOCK_DEMONOLOGY
local LATEST_SPEC = 0

local Colors = { 
	[1] = {148/255, 130/255, 201/255, 1},
	[2] = {95/255, 222/255,  95/255, 1},
	[3] = {222/255, 95/255,  95/255, 1},
}

local Update = function(self, event, unit, powerType)
	if(self.unit ~= unit or (powerType and powerType ~= "BURNING_EMBERS" and powerType ~= "SOUL_SHARDS" and powerType ~= "DEMONIC_FURY")) then return end

	local wsb = self.WarlockSpecBars
	if(wsb.PreUpdate) then wsb:PreUpdate(unit) end
	
	local spec = GetSpecialization()
	
	if spec then
		if (spec == SPEC_WARLOCK_DESTRUCTION) then	
			local maxPower = UnitPowerMax("player", SPELL_POWER_BURNING_EMBERS, true)
			local power = UnitPower("player", SPELL_POWER_BURNING_EMBERS, true)
			local numEmbers = power / MAX_POWER_PER_EMBER
			local numBars = floor(maxPower / MAX_POWER_PER_EMBER)
			
			for i = 1, #wsb do
				wsb[i]:SetMinMaxValues((MAX_POWER_PER_EMBER * i) - MAX_POWER_PER_EMBER, MAX_POWER_PER_EMBER * i)
				wsb[i]:SetValue(power)
			end
		elseif ( spec == SPEC_WARLOCK_AFFLICTION ) then
			local numShards = UnitPower("player", SPELL_POWER_SOUL_SHARDS)
			local maxShards = UnitPowerMax("player", SPELL_POWER_SOUL_SHARDS)
			
			for i = 1, #wsb do
				if i <= numShards then
					wsb[i]:SetAlpha(1)
				else
					wsb[i]:SetAlpha(0)
				end
			end
		elseif spec == SPEC_WARLOCK_DEMONOLOGY then
			local power = UnitPower("player", SPELL_POWER_DEMONIC_FURY)
			local maxPower = UnitPowerMax("player", SPELL_POWER_DEMONIC_FURY)
						
			wsb[1]:SetMinMaxValues(0, maxPower)
			wsb[1]:SetValue(power)
		end
	end

	if(wsb.PostUpdate) then
		return wsb:PostUpdate(spec)
	end
end

local function Visibility(self, event, unit)
	local wsb = self.WarlockSpecBars
	local w = wsb:GetWidth()
	local s = 0
	
	local spec = GetSpecialization()
	if spec then
		if not wsb:IsShown() then 
			wsb:Show()
		end
		
		if LATEST_SPEC ~= spec then
			for i = 1, #wsb do
				local max = select(2, wsb[i]:GetMinMaxValues())
				if spec == SPEC_WARLOCK_AFFLICTION then
					wsb[i]:SetValue(max)
				else
					wsb[i]:SetValue(0)
				end
				wsb[i]:Show()
				if wsb[i].bg then wsb[i].bg:SetAlpha(0.15) end
			end	
		end
		
		-- force an update each time we respec
		Update(self, nil, "player")
	else
		if wsb:IsShown() then 
			wsb:Hide()
		end
	end
	
	LATEST_SPEC = spec
end

local Path = function(self, ...)
	return (self.WarlockSpecBars.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, "ForceUpdate", element.__owner.unit, "SOUL_SHARDS")
end

local function Enable(self)
	local wsb = self.WarlockSpecBars
	if(wsb) then
		wsb.__owner = self
		wsb.ForceUpdate = ForceUpdate

		self:RegisterEvent("UNIT_POWER", Path)
		self:RegisterEvent("UNIT_DISPLAYPOWER", Path)

		-- why the fuck does PLAYER_TALENT_UPDATE doesnt trigger on initial login if we register to: self or self.PluginName
		wsb.Visibility = CreateFrame("Frame", nil, wsb)
		wsb.Visibility:RegisterEvent("PLAYER_TALENT_UPDATE")
		wsb.Visibility:SetScript("OnEvent", function(frame, event, unit) Visibility(self, event, unit) end)

		for i = 1, #wsb do
			local Point = wsb[i]
			if not Point:GetStatusBarTexture() then
				Point:SetStatusBarTexture([=[Interface\TargetingFrame\UI-StatusBar]=])
			end
			
			Point:SetFrameLevel(wsb:GetFrameLevel() + 1)
			Point:GetStatusBarTexture():SetHorizTile(false)
			
			if Point.bg then
				Point.bg:SetAllPoints()
			end	
		end
		
		wsb:Hide()

		return true
	end
end

local function Disable(self)
	local wsb = self.WarlockSpecBars
	if(wsb) then
		self:UnregisterEvent("UNIT_POWER", Path)
		self:UnregisterEvent("UNIT_DISPLAYPOWER", Path)
		wsb.Visibility:UnregisterEvent("PLAYER_TALENT_UPDATE")
	end
end

oUF:AddElement("WarlockSpecBars", Path, Enable, Disable)