
minetest.register_abm({
    label = "Snow sublimation",
    nodenames = {"group:snowy"},
    neighbors = {"air"},
    interval = 51,
    chance = 23,
    action = function(pos, node)
      pos.y = pos.y + 1
      local node_above = minetest.get_node(pos)
      if (minetest.get_item_group(node_above.name, "snow")==0) 
          and (minetest.get_item_group(node_above.name, "ice")==0) then
        pos.y = pos.y - 1
        node.param2 = node.param2 - 1
        if not minetest.find_node_near(pos, 1, {"group:snowy", "group:ice", "group:cooling"}) then
          node.param2 = node.param2 - 1
        end
        if node.param2>0 then
          if node.name=="hades_snow:snowblock" and node.param2<64 then
            node.name = "hades_snow:snow"
          end
          minetest.swap_node(pos, node)
        else
          minetest.remove_node(pos)
        end
      end
    end,
  })

minetest.register_abm({
    label = "Ice sublimation",
    nodenames = {"group:ice"},
    neighbors = {"air"},
    interval = 71,
    chance = 23,
    action = function(pos, node)
      pos.y = pos.y + 1
      local node_above = minetest.get_node(pos)
      if (minetest.get_item_group(node_above.name, "snow")==0) 
          and (minetest.get_item_group(node_above.name, "ice")==0) then
        pos.y = pos.y - 1
        if minetest.find_node_near(pos, 1, {"group:cooling"}) then
          return
        end
        node.param2 = node.param2 - 1
        if not minetest.find_node_near(pos, 1, {"group:snowy", "group:ice"}) then
          node.param2 = node.param2 - 1
        end
        if node.param2>0 then
          minetest.swap_node(pos, node)
        else
          minetest.remove_node(pos)
        end
      end
    end,
  })

minetest.register_abm({
    label = "Snow/Ice sublimation by lava",
    nodenames = {"group:snowy", "group:ice"},
    neighbors = {"group:lava"},
    interval = 1,
    chance = 1,
    action = function(pos, node)
      minetest.remove_node(pos)
    end,
  })

minetest.register_abm({
    label = "Snow near water",
    nodenames = {"group:snowy", "group:ice"},
    neighbors = {"group:water"},
    interval = 23,
    chance = 7,
    action = function(pos, node)
      pos.y = pos.y + 1
      local node_above = minetest.get_node(pos)
      if (minetest.get_item_group(node_above.name, "snow")==0) 
          and (minetest.get_item_group(node_above.name, "ice")==0) then
        pos.y = pos.y - 1
        node.param2 = node.param2 - 1
        if not minetest.find_node_near(pos, 1, {"group:snowy", "group:ice"}) then
          node.param2 = node.param2 - 1
        end
        if node.param2>0 then
          if node.name=="hades_snow:snowblock" and node.param2<64 then
            node.name = "hades_snow:snow"
          end
          minetest.swap_node(pos, node)
        else
          minetest.remove_node(pos)
        end
      end
    end,
  })

minetest.register_abm({
    label = "Snow/Ice sublimation by lava",
    nodenames = {"group:snowy", "group:ice"},
    neighbors = {"group:lava"},
    interval = 1,
    chance = 1,
    action = function(pos, node)
      minetest.remove_node(pos)
    end,
  })

minetest.register_abm({
    label = "Snow/Ice forcing by preassure",
    nodenames = {"group:snowy", "group:ice"},
    neighbors = {"group:snowy", "group:ice"},
    interval = 111,
    chance = 31,
    action = function(pos, node)
      if node.param2>=255 then
        return
      end
      pos.y = pos.y + 1
      local node_above = minetest.get_node(pos)
      if (minetest.get_item_group(node_above.name, "snow")~=0) then
        if node_above.param2>64 then
          node_above.param2 = node_above.param2 - 1
          minetest.swap_node(pos, node_above)
          pos.y = pos.y - 1
          node.param2 = node.param2 + 1
          if node.param2>254 then
            node.param2 = hades_snow.snow_strengthen[node.name].param2
            node.name = hades_snow.snow_strengthen[node.name].name
          end
          minetest.swap_node(pos, node)
        end
      elseif (minetest.get_item_group(node_above.name, "ice")~=0) then
        if node_above.param2>128 then
          node_above.param2 = node_above.param2 - 1
          minetest.swap_node(pos, node_above)
          pos.y = pos.y - 1
          node.param2 = node.param2 + 1
          if node.param2>254 then
            node.param2 = hades_snow.snow_strengthen[node.name].param2
            node.name = hades_snow.snow_strengthen[node.name].name
          end
          minetest.swap_node(pos, node)
        end
      end
    end,
  })
