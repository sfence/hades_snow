
local items = {
  metal_ingot = "hades_core:steel_ingot",
  metal_block = "hades_core:steelblock",
  
  pipe = "pipeworks:pipe_1_empty",
  
  copper_wire = "hades_extramaterials:copper_wire",
  empty_spool = "hades_extramaterials:empty_spool",
  controller = "hades_extramaterials:ic",
  
  electric_motor = "hades_extramaterials:motor",
  transformer = "hades_extramaterials:gold_wire",
  
  bar = "hades_extramaterials:steel_bar",
  
  freezer = "hades_core:mese",
}

if minetest.get_modpath("hades_technic") then
  items.metal_ingot = "hades_technic:carbon_steel_ingot"
  items.metal_block = "hades_technic:carbon_steel_block"
  items.controller = "hades_technic:control_logic_unit"
  
  items.transformer = "hades_technic:lv_transformer"
  
  items.freezer = "hades_technic:mv_freezer"
end

if minetest.get_modpath("power_generators") then
end

minetest.register_craft({
  output = "hades_snow:cannon_blower",
  recipe = {{items.metal_ingot, "dye:black", items.metal_ingot},
            {"", items.electric_motor, ""},
            {items.metal_ingot, "", items.metal_ingot}},
})

minetest.register_craft({
  output = "hades_snow:snow_cannon",
  recipe = {{items.copper_wire, "hades_snow:cannon_blower", items.pipe},
            {items.transformer, items.freezer, items.pipe},
            {items.bar, items.metal_block, items.bar}},
  replacements = {{items.copper_wire, items.empty_spool}},
})

