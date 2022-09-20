local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setParameter(COMBAT_PARAM_CREATEITEM, ITEM_WILDGROWTH)

local function tile_timer(id, pos, delay, color)
	if not Tile(pos):getItemById(id) then
		return true
	end
	
	if delay ~= 1 then
		addEvent(tile_timer, 1000, id, pos, delay - 1, color)
	end
   
	local people = Game.getSpectators(pos, 7, 7, 5, 5, false, true)
	if not people then
		return true
	end
	
	for i = 1, #people do
		people[i]:sendTextMessage(MESSAGE_EXPERIENCE, "Wild growth will disappear in " .. delay .. " second" .. (delay > 1 and "s" or "") .. ".", pos, delay, color)
	end
end

function onCastSpell(creature, variant, isHotkey)
	local c = combat:execute(creature, variant)
	if c then
		tile_timer(ITEM_WILDGROWTH, variantToPosition(variant), 45, TEXTCOLOR_LIGHTGREEN)
	end
	return c
end