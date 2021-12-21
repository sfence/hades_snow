
local S = hades_snow.translator

minetest.register_node("hades_snow:snow", {
	description = S("Snow"),
	tiles = {"default_snow.png"},
	inventory_image = "default_snowball.png",
	wield_image = "default_snowball.png",
	paramtype = "light",
	paramtype2 = "leveled",
	buildable_to = true,
	floodable = true,
	drawtype = "nodebox",
	node_box = {
		type = "leveled",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
	collision_box = {
		type = "leveled",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
	groups = {crumbly = 3, falling_node = 1, snowy = 1},
	sounds = hades_snow.node_sound_snow_defaults(),
  
  place_param2 = 1,
  drops = "hades_snow:snow",
  on_construct = function(pos)
    local node = minetest.get_node(pos)
    if node.param2>=64 then
      minetest.set_node(pos, {name="hades_snow:snowblock", param2=node.param2})
    end
  end,
  on_place = function(itemstack, placer, pointed_thing)
    if pointed_thing.type=="node" then
      local node = minetest.get_node(pointed_thing.under)
      if node.name=="hades_snow:snow" then
        node.param2 = node.param2 + 1
        if node.param2 >= 64 then
          node.name = "hades_snow:snowblock"
        end
        minetest.swap_node(pointed_thing.under, node)
        return itemstack:take_item()
      end
    end
    return minetest.item_place(itemstack, placer, pointed_thing, 1)
  end,
  on_use = function(itemstack, user, pointed_thing)
    if user then
      local pos = user:get_pos()
      pos.y = pos.y + 1
      local snow_ball = minetest.add_entity(pos, "hades_snow:snow_ball")
      if snow_ball then
        local dir = vector.multiply(user:get_look_dir(), 20)
        snow_ball:set_velocity(dir)
        itemstack:take_item()
      end
    end
    return itemstack
  end,
  preserve_metadata = function(pos, oldnode, oldmeta, drops)
    drops[1]:set_count(oldnode.param2)
  end,
})

minetest.register_node("hades_snow:snowblock", {
	description = S("Snow Block"),
	tiles = {"default_snow.png"},
	groups = {crumbly = 3, cools_lava = 1, snowy = 1},
	sounds = hades_snow.node_sound_snow_defaults(),
  place_param2 = 64,

	on_construct = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "hades_core:dirt_with_grass" then
			minetest.set_node(pos, {name = "hades_snow:dirt_with_snow"})
		end
	end,
})

minetest.register_node("hades_snow:neve", {
	description = S("Névé"),
	tiles = {"hades_snow_neve.png"},
	groups = {crumby = 1, cracky = 3, cools_lava = 1, snowy = 1},
	sounds = hades_snow.node_sound_snow_defaults(),
  place_param2 = 64,
})

minetest.register_node("hades_snow:firn", {
	description = S("Firn"),
	tiles = {"hades_snow_firn.png"},
	groups = {crumby = 1, cracky = 3, cools_lava = 1, snowy = 1},
	sounds = hades_snow.node_sound_snow_defaults(),
  place_param2 = 64,
})

minetest.register_node("hades_snow:ice", {
	description = S("Ice"),
	tiles = {"default_ice.png"},
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky = 2, cools_lava = 1, slippery = 3, ice = 1},
	sounds = hades_snow.node_sound_ice_defaults(),
  place_param2 = 128,
})

minetest.register_node("hades_snow:pure_ice", {
	description = S("Pure Ice"),
	tiles = {"default_ice.png^[opacity:200"},
	drawtype = "glasslike",
	paramtype = "light",
  use_texture_alpha = "blend",
	groups = {cracky = 2, cools_lava = 1, slippery = 6, ice = 1},
	sounds = hades_snow.node_sound_ice_defaults(),
  place_param2 = 128,
})

hades_snow.snow_strengthen = {
  ["hades_snow:snowblock"] = {name = "hades_snow:neve", param2 = 64},
  ["hades_snow:neve"] = {name = "hades_snow:firn", param2 = 64},
  ["hades_snow:firn"] = {name = "hades_snow:ice", param2 = 128},
  ["hades_snow:ice"] = {name = "hades_snow:pure_ice", param2 = 128},
  ["hades_snow:pure_ice"] = {name = "hades_snow:pure_ice", param2 = 255},
}


