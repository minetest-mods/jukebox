minetest.register_node("jukebox:box", {
	description = "Jukebox",
	drawtype = "nodebox",
	tiles = {"jukebox_top.png", "default_wood.png", "jukebox_side.png",
		"jukebox_side.png", "jukebox_front.png", "jukebox_front.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	stack_max = 1,
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				
	},
	on_rightclick = function(pos, node, clicker, itemstack)
		
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		local item = nil
		if inv:is_empty("main") then
			item = clicker:get_wielded_item():get_name()
			if item == "jukebox:disc_1" then
				inv:set_stack("main",1, itemstack:take_item())
				meta:set_string("hwnd",minetest.sound_play("jukebox_disc_1", {gain = 0.5, max_hear_distance = 25}))
			elseif item == "jukebox:disc_2" then
				inv:set_stack("main",1, itemstack:take_item())
				meta:set_string("hwnd",minetest.sound_play("jukebox_disc_2", {gain = 0.5, max_hear_distance = 25}))
			elseif item == "jukebox:disc_3" then
				inv:set_stack("main",1, itemstack:take_item())
				meta:set_string("hwnd",minetest.sound_play("jukebox_disc_3", {gain = 0.5, max_hear_distance = 25}))
			elseif item == "jukebox:disc_4" then
				inv:set_stack("main",1, itemstack:take_item())
				meta:set_string("hwnd",minetest.sound_play("jukebox_disc_4", {gain = 0.5, max_hear_distance = 25}))
			elseif item == "jukebox:disc_5" then
				inv:set_stack("main",1, itemstack:take_item())
				meta:set_string("hwnd",minetest.sound_play("jukebox_disc_5", {gain = 0.5, max_hear_distance = 25}))
			elseif item == "jukebox:disc_6" then
				inv:set_stack("main",1, itemstack:take_item())
				meta:set_string("hwnd",minetest.sound_play("jukebox_disc_6", {gain = 0.5, max_hear_distance = 25}))
			elseif item == "jukebox:disc_7" then
				inv:set_stack("main",1, itemstack:take_item())
				meta:set_string("hwnd",minetest.sound_play("jukebox_disc_7", {gain = 0.5, max_hear_distance = 25}))
			elseif item == "jukebox:disc_8" then
				inv:set_stack("main",1, itemstack:take_item())
				meta:set_string("hwnd",minetest.sound_play("jukebox_disc_8", {gain = 0.5, max_hear_distance = 25}))
			elseif item == "jukebox:disc_9" then
				inv:set_stack("main",1, itemstack:take_item())
				meta:set_string("hwnd",minetest.sound_play("jukebox_disc_9", {gain = 0.5, max_hear_distance = 25}))
			end
		else
			local drop_pos = minetest.env:find_node_near(pos, 1, "air")
			if drop_pos == nil then drop_pos = {x=pos.x, y=pos.y+1,z=pos.z} end
			minetest.env:add_item(drop_pos, inv:get_stack("main",1))
			if meta:get_string("hwnd") then minetest.sound_stop(meta:get_string("hwnd")) end
			inv:remove_item("main",inv:get_stack("main",1))
		end

	end,
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("main", 1)
	end,	
	on_destruct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		if not inv:is_empty("main") then
			local drop_pos = minetest.env:find_node_near(pos, 1, "air")
			if drop_pos == nil then drop_pos = {x=pos.x, y=pos.y+1,z=pos.z} end
			minetest.env:add_item(drop_pos, inv:get_stack("main",1))
			if meta:get_string("hwnd") then minetest.sound_stop(meta:get_string("hwnd")) end
		end
	end,
})

minetest.register_craftitem("jukebox:disc_1", {
	description = "Music Disc 1",
	inventory_image = "jukebox_disc_1.png",
	stack_max = 1
})
minetest.register_craftitem("jukebox:disc_2", {
	description = "Music Disc 2",
	inventory_image = "jukebox_disc_2.png",
	stack_max = 1
})
minetest.register_craftitem("jukebox:disc_3", {
	description = "Music Disc 3",
	inventory_image = "jukebox_disc_3.png",
	stack_max = 1
})
minetest.register_craftitem("jukebox:disc_4", {
	description = "Music Disc 4",
	inventory_image = "jukebox_disc_4.png",
	stack_max = 1
})
minetest.register_craftitem("jukebox:disc_5", {
	description = "Music Disc 5",
	inventory_image = "jukebox_disc_5.png",
	stack_max = 1
})
minetest.register_craftitem("jukebox:disc_6", {
	description = "Music Disc 6",
	inventory_image = "jukebox_disc_6.png",
	stack_max = 1
})
minetest.register_craftitem("jukebox:disc_7", {
	description = "Music Disc 7",
	inventory_image = "jukebox_disc_7.png",
	stack_max = 1
})
minetest.register_craftitem("jukebox:disc_8", {
	description = "Music Disc 8",
	inventory_image = "jukebox_disc_8.png",
	stack_max = 1
})
minetest.register_craftitem("jukebox:disc_9", {
	description = "Music Disc 9",
	inventory_image = "jukebox_disc_9.png",
	stack_max = 1
})

minetest.register_craft({
	output = "jukebox:box",
	recipe = {
		{"group:wood", "group:wood", "group:wood", },
		{"group:wood", "default:mese_crystal", "group:wood", },
		{"group:wood", "group:wood", "group:wood", }
	}
})

minetest.register_craft({
	output = "jukebox:disc_1",
	recipe = {
		{"", "default:coal_lump", "", },
		{"default:coal_lump", "default:gold_lump", "default:coal_lump", },
		{"", "default:coal_lump", "", }
	}
})
