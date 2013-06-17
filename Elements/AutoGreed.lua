-- AutoGreed.lua
-- Written by Snail

function HandleAutoGreed()
	local AutoGreed = CreateFrame("Frame", nil, UIParent)
	
	AutoGreed:RegisterEvent("START_LOOT_ROLL",
		function(Self, Event, Id)
			local _, _, _, Quality, BoP = GetLootRollItemInfo(Id)

			if Id and (Quality == ITEM_QUALITY_UNCOMMON) and (not BoP) then
				RollOnLoot(Id, 2)
			end
		end
	)
end
