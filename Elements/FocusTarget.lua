--
-- Copyright (C) 2012-2015 Snailsoft <http://www.snailsoft.me/>
--
-- This program is free software; you can redistribute it and/or modify it
-- under the terms of the GNU General Public License as published by the
-- Free Software Foundation; either version 2 of the License, or (at your
-- option) any later version.
--
-- This program is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details.
--
-- You should have received a copy of the GNU General Public License along
-- with this program. If not, see <http://www.gnu.org/licenses/>.
--

function HandleFocusTarget(Self)
	if GetConfiguration().FocusTarget then
		local FocusTarget = Self:Spawn("FocusTarget")

		FocusTarget:SetPoint(GetConfiguration().FocusTarget.Anchor, GetConfiguration().FocusTarget.X, GetConfiguration().FocusTarget.Y)
	end
end
