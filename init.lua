jukebox = {}
jukebox.registered_discs = {}

function jukebox.register_disc(name, def)
	def.stack_max = 1
	
	local music_name = def.music_name
	def.music_name = nil

	minetest.register_craftitem(":" .. name, def)

	jukebox.registered_discs[name] = music_name
end

-- +-----------+
-- |  The Box  |
-- +-----------+


local handlers = {}

minetest.register_node("jukebox:box", {
	description = "Jukebox",
	paramtype2 = "facedir",
	stack_max = 1,
	tiles = {
		"jukebox_top.png", "default_wood.png", "jukebox_side.png",
		"jukebox_side.png", "jukebox_front.png", "jukebox_front.png"
	},
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults(),

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("main", 1)
	end,

	on_destruct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()

		if inv:is_empty("main") then return end

		local drop_pos = minetest.find_node_near(pos, 1, "air")
		if not drop_pos then drop_pos = {x = pos.x, y = pos.y + 1, z = pos.z} end

		minetest.add_item(drop_pos, inv:get_stack("main", 1))
		inv:remove_item("main", inv:get_stack("main", 1))

		local pos_string = minetest.pos_to_string(pos)

		if handlers[pos_string] then
			minetest.sound_stop(handlers[pos_string])
		end
	end,

	on_rightclick = function(pos, node, clicker, itemstack)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()

		local pos_string = minetest.pos_to_string(pos)

		if inv:is_empty("main") then
			local item_name = itemstack:get_name()
			local music_name = jukebox.registered_discs[item_name]

			if not music_name then return end

			inv:set_stack("main", 1, itemstack:take_item())

			local handle = minetest.sound_play(music_name, {
				pos = pos,
				gain = 0.5,
				max_hear_distance = 25,
				loop = true
			})

			handlers[pos_string] = handle

			meta:set_string("music_name", music_name) -- for LBM
		else
			local drop_pos = minetest.find_node_near(pos, 1, "air")
			if not drop_pos then drop_pos = {x = pos.x, y = pos.y + 1, z = pos.z} end

			minetest.add_item(drop_pos, inv:get_stack("main", 1))
			inv:remove_item("main", inv:get_stack("main", 1))

			if handlers[pos_string] then
				minetest.sound_stop(handlers[pos_string])
			end
		end
	end
})

minetest.register_lbm({
	name = "jukebox:resume_playing",
	nodenames = "jukebox:box",
	action = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()

		local pos_string = minetest.pos_to_string(pos)

		if inv:is_empty("main") then return end
		if handlers[pos_string] then return end

		local music_name = meta:get_string("music_name")
		local handle = minetest.sound_play(music_name, {
			pos = pos,
			gain = 0.5,
			max_hear_distance = 25,
			loop = true
		})

		handlers[pos_string] = handle
	end
})

minetest.register_craft({
	output = "jukebox:box",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "default:mese_crystal", "group:wood"},
		{"group:wood", "group:wood", "group:wood"}
	}
})

-- +---------+
-- |  Discs  |
-- +---------+

for i = 1, 9 do
	local item_name = "jukebox:disc_" .. i
	local description = "Music Disc " .. i
	local inventory_image = "jukebox_disc_" .. i .. ".png"
	local music_name = "jukebox_disc_" .. i

	jukebox.register_disc(item_name, {
		description = description,
		inventory_image = inventory_image,
		music_name = music_name
	})
end

minetest.register_craft({
	output = "jukebox:disc_1",
	recipe = {
		{"", "default:coal_lump", ""},
		{"default:coal_lump", "default:gold_lump", "default:coal_lump"},
		{"", "default:coal_lump", ""}
	}
})
