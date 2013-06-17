-- GarbageCollector.lua
-- Written by Snail

function HandleGarbageCollector()
	local EventCount = 0
	local GarbageCollector = CreateFrame("Frame", nil, UIParent)

	GarbageCollector:RegisterAllEvents()
	GarbageCollector:SetScript("OnEvent",
		function(Self, Event)
			EventCount = EventCount + 1

			if (InCombatLockdown() and (EventCount > 25000)) or ((not InCombatLockdown()) and (EventCount > 10000)) or (Event == "PLAYER_ENTERING_WORLD") then
				collectgarbage("collect")
				EventCount = 0
			end
		end
	)
end
