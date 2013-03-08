-- SpellRange.lua
-- Written by Snail

function HandleSpellRange(Self)
	Self.SpellRange =
	{
		Update = function(Self, InRange)
			if Configuration.InactiveAlpha then
				if UnitIsUnit(Self.unit, "Player") then
					InRange = true
				end

				if InRange then
					Self:SetAlpha(1)
					Self.InRange = InRange

					if GetConfiguration()[Self.Frame].HealthThreshold then
						if (not Self.ShowFull) and (math.floor(((UnitHealth(Self.unit) / UnitHealthMax(Self.unit)) * 100) + 0.5) >= GetConfiguration()[Self.Frame].HealthThreshold) then
							Self:SetAlpha(Configuration.InactiveAlpha)
						end
					end
				else
					Self:SetAlpha(Configuration.InactiveAlpha)
					Self.InRange = nil
				end
			end
		end
	}

	if GetConfiguration()[Self.Frame].HealthThreshold then
		Self:RegisterEvent("UNIT_HEALTH",
			function(Self)
				Self:SetAlpha(Configuration.InactiveAlpha)

				if Self.ShowFull or (math.floor(((UnitHealth(Self.unit) / UnitHealthMax(Self.unit)) * 100) + 0.5) < GetConfiguration()[Self.Frame].HealthThreshold) then
					if Self.InRange then
						Self:SetAlpha(1)
					end
				end
			end
		)
	end
end
