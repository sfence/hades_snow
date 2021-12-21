
hades_snow = {
  translator = minetest.get_translator("hades_snow")
}

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

dofile(modpath.."/functions.lua")

dofile(modpath.."/snow_ball.lua")
dofile(modpath.."/snow.lua")
dofile(modpath.."/dirt.lua")

dofile(modpath.."/snow_cannon.lua")

dofile(modpath.."/craftitems.lua")
dofile(modpath.."/crafting.lua")

dofile(modpath.."/abm.lua")

