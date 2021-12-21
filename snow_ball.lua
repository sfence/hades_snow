
minetest.register_entity("hades_snow:snow_ball", {
    initial_properties = {
    physical = true,
    collisionbox = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
    selectionbox = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
    visual = "sprite",
    textures = {
      "default_snowball.png"
    },
  },
  textures = {},
  static_save = false,
  hp = 1,
  timeout = 0;
  max_hp = 1,

  on_activate = function(self, staticdata, dtime_s)
    self.object:set_acceleration(vector.new(0,-10,0))
  end,

  on_step = function(self, dtime, moveresult)
    if moveresult.collides then
      local pos = self.object:get_pos()
      self.object:remove()
      local node = minetest.get_node(pos)
      if node.name=="hades_snow:snow" then
        node.param2 = node.param2 + 1
        if node.param2 >= 64 then
          node.name = "hades_snow:snowblock"
        end
        minetest.swap_node(pos, node)
        minetest.check_for_falling(pos)
      else
        pos.y = pos.y + 1
        local node = minetest.get_node(pos)
        local def = minetest.registered_nodes[node.name]
        if def and def.buildable_to then
          minetest.set_node(pos, {name="hades_snow:snow", param2 = 1})
          minetest.check_for_falling(pos)
        end
      end
    end
  end,
})
