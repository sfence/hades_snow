
local S = hades_snow.translator

minetest.register_node("hades_snow:dirt_with_snow", {
	description = S("Dirt with Snow"),
	tiles = {"default_snow.png", "default_dirt.png",
		{name = "default_dirt.png^default_snow_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1, snowy = 1},
	drop = "hades_snow:dirt",
	sounds = hades_sounds.node_sound_dirt_defaults({
		footstep = {name = "default_snow_footstep", gain = 0.2},
	}),
})

minetest.register_node("hades_snow:permafrost", {
	description = S("Permafrost"),
	tiles = {"default_permafrost.png"},
	groups = {cracky = 3},
	sounds = hades_sounds.node_sound_dirt_defaults(),
})

minetest.register_node("hades_snow:permafrost_with_moss", {
	description = S("Permafrost with Moss"),
	tiles = {"default_moss.png", "default_permafrost.png",
		{name = "default_permafrost.png^default_moss_side.png",
			tileable_vertical = false}},
	groups = {cracky = 3},
	sounds = hades_sounds.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

