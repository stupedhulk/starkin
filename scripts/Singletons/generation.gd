extends Node

var chunk_size = Vector3(32,32,32)
var smooth = 50
var scale = 1000
var pillar_scale = 50.0
var cave_size = 1
var cave_rarity  = 2
var world_seed = 743
var world_name = ""
var chunk_override = ["semirealistic"]
var override_chunk = false


var block_models = BlockModels

var cloud = {
	Vector3(-1, -1, -2):"cloud",Vector3(-1, -1, -3):"cloud",Vector3(-1, 0, -1):"cloud",
	Vector3(-1, 0, -2) :"cloud",Vector3(-1, 0, -3) :"cloud",Vector3(-1, 0, -4):"cloud",
	Vector3(-1, 0, -5) :"cloud",Vector3(-1, 0, -6) :"cloud",Vector3(-1, 0, 0) :"cloud",
	Vector3(-1, 1, -1) :"cloud",Vector3(-1, 1, -2) :"cloud",Vector3(-1, 1, -3):"cloud",
	Vector3(-1, 1, -4) :"cloud",Vector3(-1, 1, -5) :"cloud",Vector3(-1, 1, 0) :"cloud",
	Vector3(-1, 2, -1) :"cloud",Vector3(-1, 2, -2) :"cloud",Vector3(-1, 2, -3):"cloud",
	Vector3(-2, 0, -2) :"cloud",Vector3(-2, 0, -3) :"cloud",Vector3(-2, 0, -4):"cloud",
	Vector3(-2, 1, -2) :"cloud",Vector3(-2, 1, -3) :"cloud",Vector3(0, -1, -1):"cloud",
	Vector3(0, -1, -2) :"cloud",Vector3(0, -1, -3) :"cloud",Vector3(0, -1, -4):"cloud",
	Vector3(0, -1, -5) :"cloud",Vector3(0, 0, -1)  :"cloud",Vector3(0, 0, -2) :"cloud",
	Vector3(0, 0, -3)  :"cloud",Vector3(0, 0, -4)  :"cloud",Vector3(0, 0, -5) :"cloud",
	Vector3(0, 0, -6)  :"cloud",Vector3(0, 0, -7)  :"cloud",Vector3(0, 0, -8) :"cloud",
	Vector3(0, 0, -9)  :"cloud",Vector3(0, 0, 0)   :"cloud",Vector3(0, 0, 1)  :"cloud",
	Vector3(0, 0, 2)   :"cloud",Vector3(0, 1, -1)  :"cloud",Vector3(0, 1, -2) :"cloud",
	Vector3(0, 1, -3)  :"cloud",Vector3(0, 1, -4)  :"cloud",Vector3(0, 1, -5) :"cloud",
	Vector3(0, 1, -6)  :"cloud",Vector3(0, 1, -7)  :"cloud",Vector3(0, 1, -8) :"cloud",
	Vector3(0, 1, 0)   :"cloud",Vector3(0, 1, 1)   :"cloud",Vector3(0, 2, -1) :"cloud",
	Vector3(0, 2, -2)  :"cloud",Vector3(0, 2, -3)  :"cloud",Vector3(0, 2, -4) :"cloud",
	Vector3(0, 2, -5)  :"cloud",Vector3(0, 2, 0)   :"cloud",Vector3(1, -1, -3):"cloud",
	Vector3(1, 0, -1)  :"cloud",Vector3(1, 0, -2)  :"cloud",Vector3(1, 0, -3) :"cloud",
	Vector3(1, 0, -4)  :"cloud",Vector3(1, 0, -5)  :"cloud",Vector3(1, 0, -6) :"cloud",
	Vector3(1, 0, -7)  :"cloud",Vector3(1, 0, 0)   :"cloud",Vector3(1, 1, -1) :"cloud",
	Vector3(1, 1, -2)  :"cloud",Vector3(1, 1, -3)  :"cloud",Vector3(1, 1, -4) :"cloud",
	Vector3(1, 1, -5)  :"cloud",Vector3(1, 1, -6)  :"cloud",Vector3(1, 2, -2) :"cloud",
	Vector3(1, 2, -3)  :"cloud",Vector3(1, 2, -4)  :"cloud",Vector3(2, 0, -1) :"cloud",
	Vector3(2, 0, -2)  :"cloud",Vector3(2, 0, -3)  :"cloud",Vector3(2, 0, -4) :"cloud",
	Vector3(2, 1, -2)  :"cloud",Vector3(2, 1, -3)  :"cloud"
}

const block_ids = {
	null : null,
	"279" : 279,
	"test" : 743,
	"dirt" : 0,
	"grass" : 1,
	"stone" : 2,
	"cobblestone" : 3,
	"leaves" : 4,
	"log" : 5,
	"block o' rocks" : 6,
	"cloud" : 7,
}

const structures = {
	"test" : {
		Vector3(0,-1,0) : "test",
		Vector3(0,-2,0) : "test",
		Vector3(0,-3,0) : "test",
		Vector3(0,-4,0) : "test",
		Vector3(0,-5,0) : "test",
		Vector3(0,-6,0) : "test",
		Vector3(0,-7,0) : "test",
		Vector3(0,-8,0) : "test",
		Vector3(0,-9,0) : "test",
		Vector3(0,-10,0) : "test",
		Vector3(0,-11,0) : "test",
		Vector3(0,-12,0) : "test",
		Vector3(0,-13,0) : "test",
		Vector3(0,-14,0) : "test",
		Vector3(0,-15,0) : "test",
		Vector3(0,-16,0) : "test",
		Vector3(0,-17,0) : "test",
		Vector3(0,-18,0) : "test",
		Vector3(0,-19,0) : "test",
		Vector3(0,-20,0) : "test",
		Vector3(0,-21,0) : "test",
		Vector3(0,-22,0) : "test",
		Vector3(0,-23,0) : "test",
		Vector3(0,-24,0) : "test",
		Vector3(0,-25,0) : "test",
		Vector3(0,-26,0) : "test",
		Vector3(0,-27,0) : "test",
		Vector3(0,-28,0) : "test",
		Vector3(0,0,0) : "test",
		Vector3(0,1,0) : "test",
		Vector3(0,2,0) : "test",
		Vector3(0,3,0) : "test",
		Vector3(0,4,0) : "test",
		Vector3(0,5,0) : "test",
		Vector3(0,6,0) : "test",
		Vector3(0,7,0) : "test",
		Vector3(0,8,0) : "test",
		Vector3(0,9,0) : "test",
		Vector3(0,10,0) : "test",
		Vector3(0,11,0) : "test",
		Vector3(0,12,0) : "test",
		Vector3(0,13,0) : "test",
		Vector3(0,14,0) : "test",
		Vector3(0,15,0) : "test",
		Vector3(0,16,0) : "test",
		Vector3(0,17,0) : "test",
		Vector3(0,18,0) : "test",
		Vector3(0,19,0) : "test",
		Vector3(0,20,0) : "test",
		Vector3(0,21,0) : "test",
		Vector3(0,22,0) : "test",
		Vector3(0,23,0) : "test",
		Vector3(0,24,0) : "test",
		Vector3(0,25,0) : "test",
		Vector3(0,26,0) : "test",
		Vector3(0,27,0) : "test",
		Vector3(0,28,0) : "test",
		Vector3(0,29,0) : "test"
	},
	"tree" : {
		Vector3(-1, 3, -1) : "cloud",
		Vector3(-1, 3, 0) : "cloud",
		Vector3(-1, 3, 1) : "cloud",
		Vector3(-1, 4, -1) : "cloud",
		Vector3(-1, 4, 0) : "cloud",
		Vector3(-1, 4, 1) : "cloud",
		Vector3(-1, 5, -1) : "cloud",
		Vector3(-1, 5, 0) : "cloud",
		Vector3(-1, 5, 1) : "cloud",
		Vector3(-1, 6, 0) : "cloud",
		Vector3(-1, 7, 0) : "cloud",
		Vector3(-1, 8, 0) : "cloud",
		Vector3(0, 0, 0) : "dirt",
		Vector3(0, 1, 0) : "stone",
		Vector3(0, 10, 0) : "cloud",
		Vector3(0, 2, 0) : "stone",
		Vector3(0, 3, -1) : "cloud",
		Vector3(0, 3, 0) : "stone",
		Vector3(0, 3, 1) : "cloud",
		Vector3(0, 4, -1) : "cloud",
		Vector3(0, 4, 0) : "stone",
		Vector3(0, 4, 1) : "cloud",
		Vector3(0, 5, -1) : "cloud",
		Vector3(0, 5, 0) : "stone",
		Vector3(0, 5, 1) : "cloud",
		Vector3(0, 6, -1) : "cloud",
		Vector3(0, 6, 0) : "stone",
		Vector3(0, 6, 1) : "cloud",
		Vector3(0, 7, -1) : "cloud",
		Vector3(0, 7, 0) : "stone",
		Vector3(0, 7, 1) : "cloud",
		Vector3(0, 8, -1) : "cloud",
		Vector3(0, 8, 0) : "cloud",
		Vector3(0, 8, 1) : "cloud",
		Vector3(0, 9, 0) : "cloud",
		Vector3(1, 3, -1) : "cloud",
		Vector3(1, 3, 0) : "cloud",
		Vector3(1, 3, 1) : "cloud",
		Vector3(1, 4, -1) : "cloud",
		Vector3(1, 4, 0) : "cloud",
		Vector3(1, 4, 1) : "cloud",
		Vector3(1, 5, -1) : "cloud",
		Vector3(1, 5, 0) : "cloud",
		Vector3(1, 5, 1) : "cloud",
		Vector3(1, 6, 0) : "cloud",
		Vector3(1, 7, 0) : "cloud",
		Vector3(1, 8, 0) : "cloud"
	}
}

var chunk_data = {}

func generate_chunk(chunk_pos, Seed, type, debug, deep_debug):
	
	if debug: print('chunk generating at: ' + str(chunk_pos))
	
	var noise = FastNoiseLite.new()
	var noise2 = FastNoiseLite.new()
	var noise3 = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.seed = Seed
	noise.fractal_octaves = 9
	noise2.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise2.seed = Seed
	noise2.fractal_octaves = 9
	noise3.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise3.seed = Seed
	noise3.fractal_octaves = 9
	var caves= FastNoiseLite.new()
	caves.noise_type = FastNoiseLite.TYPE_SIMPLEX
	caves.seed = Seed
	caves.fractal_octaves = 5
	var block
	var blocks = {}
	var reference_blocks = {}
	var pos = Vector3(-1,-1,-1)
	var relative_pos = chunk_pos*chunk_size
	
	
	var block_list = []
	
	if debug: print("type list: " + str(type))
	for i in type:
		if debug: print("running: " + i)
		
		if i == "starkin":
			#setup

			noise.fractal_octaves = 9
			noise2.fractal_octaves = 1
			caves.fractal_octaves = 5
			
			
			#Pass 1
			#looping through each position in the chunk
			while pos.z < chunk_size.z + 1:
				if pos.x < chunk_size.x + 1 and pos.y < chunk_size.y + 1:



					#Write Generation code here
					
					var surface = round(noise.get_noise_2d((pos.x + chunk_pos.x*chunk_size.x)/smooth,\
							(pos.z + chunk_pos.z*chunk_size.z)/smooth)*scale) + 1320
					
					var low = round(noise.get_noise_2d((pos.x + chunk_pos.x*chunk_size.x)/0.2,\
							(pos.z + chunk_pos.z*chunk_size.z)/0.2)*10) + \
							round(noise.get_noise_2d((pos.x + chunk_pos.x*chunk_size.x)/1,\
							(pos.z + chunk_pos.z*chunk_size.z)/1)*10) + 224
					
					var cave = round(caves.get_noise_3d((pos.x + chunk_pos.x*chunk_size.x)/cave_size,\
							(pos.y + chunk_pos.y*chunk_size.y)/cave_size, \
							(pos.z + chunk_pos.z*chunk_size.z)/cave_size) * cave_rarity)
					
					var pillar_surface = abs(clamp(noise.get_noise_2d((pos.x + relative_pos.x) * 1, 1 * \
					(pos.z + relative_pos.z)), 0 , 1)) * 10
					
					var world_edge = 15000
					#end of the world
					var test = abs(noise.get_noise_3d(pos.x + chunk_pos.x * chunk_size.x, pos.y + chunk_pos.y * chunk_size.y, pos.z + chunk_pos.z * chunk_size.z))
					var test2 = max(abs(pos.x + chunk_pos.x*chunk_size.x), abs(pos.z + chunk_pos.z*chunk_size.z))
					test -= (test2 - world_edge)/300.0
					if (abs(pos.x + chunk_pos.x*chunk_size.x) >= world_edge or abs(pos.z + chunk_pos.z*chunk_size.z) >= world_edge) and !test > 0.1:
						block = null
					
					#semirealistic
					elif pos.y < surface - chunk_pos.y*chunk_size.y and !cave == 1 and pos.y > low  - chunk_pos.y*chunk_size.y:
						if pos.y <= surface - chunk_pos.y*chunk_size.y - 5:
							block = 'stone'
						elif pos.y == surface - chunk_pos.y*chunk_size.y - 1:
							block = 'grass'
						else:
							block = 'dirt'
					
					#pillar
					elif pillar_surface > ((abs(pos.y/ 1.0 + relative_pos.y)) + pillar_scale*3.2) / pillar_scale and surface > 3:
						block = 'pillar_placeholder'
					
					
					else: block = null
						
					
					
					
					
					#adding block to dictionary (just set block = [block type] before here to change the block, leave null for nothing)

					if block != null:
						if pos.x >= 0 and pos.x < chunk_size.x \
						and pos.y >= 0 and pos.y < chunk_size.y\
						and pos.z >= 0 and pos.z < chunk_size.z:
							blocks[pos] = block
						else:
							reference_blocks[pos] = block
					
				#getting next position value
					pos.x += 1
				else:
					if pos.x >= chunk_size.x + 1:
						pos.x = -1
						pos.y += 1
					if pos.y >= chunk_size.y + 1:
						pos.y = -1
						pos.z += 1
			
			
			
			
			#pass 2
			pos = Vector3(-1,-1,-1)
			caves.fractal_octaves = 9
			noise.fractal_octaves = 1
			#looping through each position in the chunk
			while pos.z < chunk_size.z + 1:
				if pos.x < chunk_size.x + 1 and pos.y < chunk_size.y + 1:
					
					
					
					#creating grass patches on the surface of stone
					if pos in blocks and blocks[pos] == "stone" \
							and not (pos + Vector3(0,1,0) in blocks or pos + Vector3(0,1,0) in reference_blocks) \
							and caves.get_noise_3d(pos.x, pos.y, pos.z) > 0.5:
						blocks[pos] = "grass_stone"
					
					#adding patches of bongamite above the pillars
					if pos in blocks and blocks[pos] == "stone":
						var value = noise.get_noise_3d((pos.x + chunk_pos.x*chunk_size.x)*3, (pos.y + chunk_pos.y*chunk_size.y)*3, (pos.z + chunk_pos.z*chunk_size.z)*3)
							
						if value < 0.95:
							blocks[pos] = 'stone'
						else:
							blocks[pos] = 'bongamite_ore'
					
					#changing pillar_placeholder blocks into stone and munatite ore blocks
					if pos in blocks and blocks[pos] == "pillar_placeholder":
						var value = noise.get_noise_3d((pos.x + chunk_pos.x*chunk_size.x)*3, (pos.y + chunk_pos.y*chunk_size.y)*3, (pos.z + chunk_pos.z*chunk_size.z)*3)
							
						if value < 0.85:
							blocks[pos] = 'stone'
						elif value < 0.9:
							blocks[pos] = 'munatite_ore_sparce'
						elif value < 0.95:
							blocks[pos] = 'munatite_ore'
						else:
							blocks[pos] = 'munatite_ore_dence'
					
					#doing the same for reference blocks to avoid issues
					if pos in reference_blocks and reference_blocks[pos] == "pillar_placeholder":
						var value = noise.get_noise_3d((pos.x + chunk_pos.x*chunk_size.x)*3, (pos.y + chunk_pos.y*chunk_size.y)*3, (pos.z + chunk_pos.z*chunk_size.z)*3)
						
						if value < 0.85:
							reference_blocks[pos] = 'stone'
						elif value < 0.9:
							reference_blocks[pos] = 'munatite_ore_sparce'
						elif value < 0.95:
							reference_blocks[pos] = 'munatite_ore'
						else:
							reference_blocks[pos] = 'munatite_ore_dence'
					
					#getting next position value
					pos.x += 1
				else:
					if pos.x >= chunk_size.x + 1:
						pos.x = -1
						pos.y += 1
					if pos.y >= chunk_size.y + 1:
						pos.y = -1
						pos.z += 1
				
			if debug: print("ran: " + i)
		
		
		if i == "semirealistic":
			noise.fractal_octaves = 9
			caves.fractal_octaves = 5
		
			while pos.z < chunk_size.z + 1:
				if pos.x < chunk_size.x + 1 and pos.y < chunk_size.y + 1:
					
					var surface = round(noise.get_noise_2d((pos.x + chunk_pos.x*chunk_size.x)/smooth,\
							(pos.z + chunk_pos.z*chunk_size.z)/smooth)*scale) + 1320
					
					var cave = round(caves.get_noise_3d((pos.x + chunk_pos.x*chunk_size.x)/cave_size,\
							(pos.y + chunk_pos.y*chunk_size.y)/cave_size, \
							(pos.z + chunk_pos.z*chunk_size.z)/cave_size) * cave_rarity)
					
					if pos.y < surface - chunk_pos.y*chunk_size.y and !cave == 1:
						if pos.y <= surface - chunk_pos.y*chunk_size.y - 5:
							if randi()%1+1 == 1: block = 'stone'
							else: block = 'cobblestone'
						elif pos.y == surface - chunk_pos.y*chunk_size.y - 1:
							block = 'grass'
						else:
							block = 'dirt'
						if pos.x >= 0 and pos.x < chunk_size.x \
						and pos.y >= 0 and pos.y < chunk_size.y\
						and pos.z >= 0 and pos.z < chunk_size.z:
							blocks[pos] = block
						else:
							reference_blocks[pos] = block
					pos.x += 1
				else:
					if pos.x >= chunk_size.x + 1:
						pos.x = -1
						pos.y += 1
					if pos.y >= chunk_size.y + 1:
						pos.y = -1
						pos.z += 1
			if debug: print("ran: " + i)
		
		
		elif i == "cake":
			noise.fractal_octaves = 9
			
			var fake_pos = Vector3.ZERO
			
			while pos.z < chunk_size.z + 1:
				
				fake_pos = pos
				if pos.y >= 32:
					relative_pos = (chunk_pos + Vector3(0, 0.5, 0 ))*chunk_size
					fake_pos += Vector3(0, -chunk_size.y, 0)
				elif pos.y <= -1:
					relative_pos = (chunk_pos + Vector3(0, -0.5, 0 ))*chunk_size
					fake_pos += Vector3(0, chunk_size.y, 0)
				else:
					chunk_pos*chunk_size
					fake_pos = pos
				
				
				
				
				if pos.x < chunk_size.x + 1 and pos.y < chunk_size.y + 1:
					
					var surface = (abs(noise.get_noise_2d((fake_pos.x + relative_pos.x) * 1, 1 * \
							(fake_pos.z + relative_pos.z)))) * 10
					
					if surface > ((fake_pos.y + 2400 ) / 10 + relative_pos.y) / 10 :
						if (int(fake_pos.y) % 2) == 0: block = 'stone'
						else: block = 'dirt'
						if pos.x >= 0 and pos.x < chunk_size.x \
						and pos.y >= 0 and pos.y < chunk_size.y\
						and pos.z >= 0 and pos.z < chunk_size.z:
							blocks[pos] = block
						else:
							reference_blocks[pos] = block
					pos.x += 1
				else:
					if pos.x >= chunk_size.x + 1:
						pos.x = -1
						pos.y += 1
					if pos.y >= chunk_size.y + 1:
						pos.y = -1
						pos.z += 1
					
					
			if debug: print("ran: " + i)
		
		
		elif i == "pillars":
			noise.fractal_octaves = 9

			while pos.z < chunk_size.z + 1:
				if pos.x < chunk_size.x + 1 and pos.y < chunk_size.y + 1:
					
					var surface = abs(clamp(noise.get_noise_2d((pos.x + relative_pos.x) * 1, 1 * \
							(pos.z + relative_pos.z)), 0 , 1)) * 10
					
					if surface > ((abs(pos.y/ 1.0 + relative_pos.y)) + pillar_scale*3.2) / pillar_scale and surface > 3:
						if (int(pos.y) % 2) == 0: block = 'stone'
						else: block = 'dirt'
						if pos.x >= 0 and pos.x < chunk_size.x \
						and pos.y >= 0 and pos.y < chunk_size.y\
						and pos.z >= 0 and pos.z < chunk_size.z:
							blocks[pos] = block
						else:
							reference_blocks[pos] = block
					pos.x += 1
				else:
					if pos.x >= chunk_size.x + 1:
						pos.x = -1
						pos.y += 1
					if pos.y >= chunk_size.y + 1:
						pos.y = -1
						pos.z += 1
			if debug: print("ran: " + i)
		
		
		elif i == "lava lamp":
			noise.fractal_octaves = 1

			while pos.z < chunk_size.z + 1:
				if pos.x < chunk_size.x + 1 and pos.y < chunk_size.y + 1:
					
					var surface = noise.get_noise_3d(\
							pos.x + chunk_pos.x*chunk_size.x ,\
							pos.y + relative_pos.y,\
							pos.z + chunk_pos.z*chunk_size.z)
					
					if surface > 0.2:
						block = 'stone'
						if pos.x >= 0 and pos.x < chunk_size.x \
						and pos.y >= 0 and pos.y < chunk_size.y\
						and pos.z >= 0 and pos.z < chunk_size.z:
							blocks[pos] = block
						else:
							reference_blocks[pos] = block
					pos.x += 1
				else:
					if pos.x >= chunk_size.x + 1:
						pos.x = -1
						pos.y += 1
					if pos.y >= chunk_size.y + 1:
						pos.y = -1
						pos.z += 1
			if debug: print("ran: " + i)
		
		
		elif i == "This One Seems Interesting":
			noise.fractal_octaves = 6

		
			while pos.z < chunk_size.z + 1:
				if pos.x < chunk_size.x + 1 and pos.y < chunk_size.y + 1:
					
					var surface = noise.get_noise_3d(\
							(pos.x + relative_pos.x) / abs(pos.y + relative_pos.y) * 10 ,\
							(pos.y + relative_pos.y) / abs(pos.y + relative_pos.y) * 10 ,\
							(pos.z + chunk_pos.z * chunk_size.z) / abs(pos.y + relative_pos.y) * 10  )
					
					if surface > 0.3:
						block = 'stone'
						if pos.x >= 0 and pos.x < chunk_size.x \
						and pos.y >= 0 and pos.y < chunk_size.y\
						and pos.z >= 0 and pos.z < chunk_size.z:
							blocks[pos] = block
						else:
							reference_blocks[pos] = block
					pos.x += 1
				else:
					if pos.x >= chunk_size.x + 1:
						pos.x = -1
						pos.y += 1
					if pos.y >= chunk_size.y + 1:
						pos.y = -1
						pos.z += 1
			if debug: print("ran: " + i)
		
		
		elif i == "blobs":
			noise.fractal_octaves = 6

		
			while pos.z < chunk_size.z + 1:
				if pos.x < chunk_size.x + 1 and pos.y < chunk_size.y + 1:
					
					var surface = noise.get_noise_3d(\
							(pos.x + relative_pos.x) / abs((pos.y + relative_pos.y) / 1000) ,\
							(pos.y + relative_pos.y) / abs((pos.y + relative_pos.y) / 1000) ,\
							(pos.z + chunk_pos.z * chunk_size.z) / abs((pos.y + relative_pos.y) / 1000)  )
					
					if surface > 0.3:
						block = 'stone'
						if pos.x >= 0 and pos.x < chunk_size.x \
						and pos.y >= 0 and pos.y < chunk_size.y\
						and pos.z >= 0 and pos.z < chunk_size.z:
							blocks[pos] = block
						else:
							reference_blocks[pos] = block
					pos.x += 1
				else:
					if pos.x >= chunk_size.x + 1:
						pos.x = -1
						pos.y += 1
					if pos.y >= chunk_size.y + 1:
						pos.y = -1
						pos.z += 1
			if debug: print("ran: " + i)
		
		
		if i == "clouds":
			noise.fractal_octaves = 9
			caves.fractal_octaves = 5
		
			while pos.z < chunk_size.z + 1:
				if pos.x < chunk_size.x + 1 and pos.y < chunk_size.y + 1:
					
					var surface = round(noise.get_noise_2d((pos.x + chunk_pos.x*chunk_size.x)/smooth,\
							(pos.z + chunk_pos.z*chunk_size.z)/smooth)*scale) + 1320
					
					var cave = round(caves.get_noise_3d((pos.x + chunk_pos.x*chunk_size.x)/cave_size,\
							(pos.y + chunk_pos.y*chunk_size.y)/cave_size, \
							(pos.z + chunk_pos.z*chunk_size.z)/cave_size) * cave_rarity)
					
					if pos.y < surface - chunk_pos.y*chunk_size.y and !cave == 1:
						if pos.y <= surface - chunk_pos.y*chunk_size.y - 5:
							if randi()%1+1 == 1: block = 'cloud'
							else: block = 'cloud'
						elif pos.y == surface - chunk_pos.y*chunk_size.y - 1:
							block = 'cloud'
						else:
							block = 'cloud'
						if pos.x >= 0 and pos.x < chunk_size.x \
						and pos.y >= 0 and pos.y < chunk_size.y\
						and pos.z >= 0 and pos.z < chunk_size.z:
							blocks[pos] = block
						else:
							reference_blocks[pos] = block
					pos.x += 1
				else:
					if pos.x >= chunk_size.x + 1:
						pos.x = -1
						pos.y += 1
					if pos.y >= chunk_size.y + 1:
						pos.y = -1
						pos.z += 1
			if debug: print("ran: " + i)
		
		
		
		
		
		elif i == 'dank uncle chunky':
		
			while pos.z < chunk_size.z + 1:
				if pos.x < chunk_size.x + 1 and pos.y < chunk_size.y + 1:
					block = 'stone'
					if pos.x >= 0 and pos.x < chunk_size.x \
					and pos.y >= 0 and pos.y < chunk_size.y\
					and pos.z >= 0 and pos.z < chunk_size.z:
						blocks[pos] = block
					else:
						reference_blocks[pos] = block
					pos.x += 1
				else:
					if pos.x >= chunk_size.x + 1:
						pos.x = -1
						pos.y += 1
					if pos.y >= chunk_size.y + 1:
						pos.y = -1
						pos.z += 1
			if debug: print("ran: " + i)
		
		
		elif i == "random seed":
			noise.fractal_octaves = 9
			caves.fractal_octaves = 5
			
			Seed = randi()
			
			while pos.z < chunk_size.z + 1:
				if pos.x < chunk_size.x + 1 and pos.y < chunk_size.y + 1:
					
					var surface = round(noise.get_noise_2d((pos.x + chunk_pos.x*chunk_size.x)/smooth,\
							(pos.z + chunk_pos.z*chunk_size.z)/smooth)*scale) + 1320
					
					var cave = round(caves.get_noise_3d((pos.x + chunk_pos.x*chunk_size.x)/cave_size,\
							(pos.y + chunk_pos.y*chunk_size.y)/cave_size, \
							(pos.z + chunk_pos.z*chunk_size.z)/cave_size) * cave_rarity)
					
					if pos.y < surface - chunk_pos.y*chunk_size.y and !cave == 1:
						if pos.y <= surface - chunk_pos.y*chunk_size.y - 5:
							block = 'stone'
						elif pos.y == surface - chunk_pos.y*chunk_size.y - 1:
							block = 'grass'
						else:
							block = 'dirt'
						if pos.x >= 0 and pos.x < chunk_size.x \
						and pos.y >= 0 and pos.y < chunk_size.y\
						and pos.z >= 0 and pos.z < chunk_size.z:
							blocks[pos] = block
						else:
							reference_blocks[pos] = block
					pos.x += 1
				else:
					if pos.x >= chunk_size.x + 1:
						pos.x = -1
						pos.y += 1
					if pos.y >= chunk_size.y + 1:
						pos.y = -1
						pos.z += 1
			if debug: print("ran: " + i)
		
		
		elif i == "flat": 
			while pos.z < chunk_size.z + 1:
				if pos.x < chunk_size.x + 1 and pos.y < chunk_size.y + 1:
					
					if pos.y < 1000 - chunk_pos.y*chunk_size.y:
						if pos.y <= 1000 - chunk_pos.y*chunk_size.y - 5:
							block = 'stone'
						elif pos.y == 1000 - chunk_pos.y*chunk_size.y - 1:
							block = 'grass'
						else:
							block = 'dirt'
						if pos.x >= 0 and pos.x < chunk_size.x \
						and pos.y >= 0 and pos.y < chunk_size.y\
						and pos.z >= 0 and pos.z < chunk_size.z:
							blocks[pos] = block
						else:
							reference_blocks[pos] = block
					pos.x += 1
				else:
					if pos.x >= chunk_size.x + 1:
						pos.x = -1
						pos.y += 1
					if pos.y >= chunk_size.y + 1:
						pos.y = -1
						pos.z += 1
			if debug: print("ran: " + i)
		block_list.append(blocks)
		if deep_debug: print(block_list)
	
	
		elif i == "stone world":
			noise.fractal_octaves = 9
			caves.fractal_octaves = 5
		
			while pos.z < chunk_size.z + 1:
				if pos.x < chunk_size.x + 1 and pos.y < chunk_size.y + 1:
					
					var surface = round(noise.get_noise_2d((pos.x + chunk_pos.x*chunk_size.x)/smooth,\
							(pos.z + chunk_pos.z*chunk_size.z)/smooth)*scale) + 1320
					
					var cave = round(caves.get_noise_3d((pos.x + chunk_pos.x*chunk_size.x)/cave_size,\
							(pos.y + chunk_pos.y*chunk_size.y)/cave_size, \
							(pos.z + chunk_pos.z*chunk_size.z)/cave_size) * cave_rarity)
					
					if pos.y < surface - chunk_pos.y*chunk_size.y and !cave == 1:
						if pos.y <= surface - chunk_pos.y*chunk_size.y - 5:
							if randi()%1+1 == 1: block = 'stone'
							else: block = 'cobblestone'
						elif pos.y == surface - chunk_pos.y*chunk_size.y - 1:
							block = 'grass_stone'
						else:
							block = 'stone'
						if pos.x >= 0 and pos.x < chunk_size.x \
						and pos.y >= 0 and pos.y < chunk_size.y\
						and pos.z >= 0 and pos.z < chunk_size.z:
							blocks[pos] = block
						else:
							reference_blocks[pos] = block
					pos.x += 1
				else:
					if pos.x >= chunk_size.x + 1:
						pos.x = -1
						pos.y += 1
					if pos.y >= chunk_size.y + 1:
						pos.y = -1
						pos.z += 1
			if debug: print("ran: " + i)
	
	
		elif i == "munatite dream":
			noise.fractal_octaves = 9
			noise2.fractal_octaves = 1
			caves.fractal_octaves = 5
		
			while pos.z < chunk_size.z + 1:
				if pos.x < chunk_size.x + 1 and pos.y < chunk_size.y + 1:
					
					var surface = round(noise.get_noise_2d((pos.x + chunk_pos.x*chunk_size.x)/smooth,\
							(pos.z + chunk_pos.z*chunk_size.z)/smooth)*scale) + 1320
					
					var cave = round(caves.get_noise_3d((pos.x + chunk_pos.x*chunk_size.x)/cave_size,\
							(pos.y + chunk_pos.y*chunk_size.y)/cave_size, \
							(pos.z + chunk_pos.z*chunk_size.z)/cave_size) * cave_rarity)
					
					if pos.y < surface - chunk_pos.y*chunk_size.y and !cave == 1:
						var value = noise2.get_noise_3d((pos.x + chunk_pos.x*chunk_size.x)*3, (pos.y + chunk_pos.y*chunk_size.y)*3, (pos.z + chunk_pos.z*chunk_size.z)*3)
						
						if value < 0.85:
							block = 'stone'
						elif value < 0.9:
							block = 'munatite_ore_sparce'
						elif value < 0.95:
							block = 'munatite_ore'
						else:
							block = 'munatite_ore_dence'
							
							
						if pos.x >= 0 and pos.x < chunk_size.x \
						and pos.y >= 0 and pos.y < chunk_size.y\
						and pos.z >= 0 and pos.z < chunk_size.z:
							blocks[pos] = block
						else:
							reference_blocks[pos] = block
					pos.x += 1
				else:
					if pos.x >= chunk_size.x + 1:
						pos.x = -1
						pos.y += 1
					if pos.y >= chunk_size.y + 1:
						pos.y = -1
						pos.z += 1
			if debug: print("ran: " + i)
	
	
		elif i == "chatGPT": #Elevated Wilderness
			# setup

			noise.fractal_octaves = 6
			noise2.fractal_octaves = 6
			noise3.fractal_octaves = 6
			caves.fractal_octaves = 4
			# Pass 1
			# looping through each position in the chunk
			while pos.z < chunk_size.z + 1:
				if pos.x < chunk_size.x + 1 and pos.y < chunk_size.y + 1:
					var rel_pos = pos + chunk_pos*chunk_size

					# Write Generation code here
					# Pass 1: Generate terrain structure
					var height = 40
					var surface_level = noise.get_noise_3d(rel_pos.x, rel_pos.y, rel_pos.z) * 10.0 + height
					var cave_noise = caves.get_noise_3d(rel_pos.x, rel_pos.y, rel_pos.z)

					if rel_pos.y <= surface_level:
						if rel_pos.y <= surface_level - 5:
							block = "stone"
						else:
							block = "dirt"
					elif rel_pos.y <= surface_level + 3:
						if rel_pos.y <= surface_level + 2:
							if cave_noise > 0.3:
								block = "cobblestone"
							else:
								block = "grass"
						else:
							block = null
					else:
						block = null

					# adding block to dictionary (just set block = [block type] before here to change the block, leave null for nothing)
					if block != null:
						if pos.x >= 0 and pos.x < chunk_size.x \
								and pos.y >= 0 and pos.y < chunk_size.y \
								and pos.z >= 0 and pos.z < chunk_size.z:
							blocks[pos] = block
						else:
							reference_blocks[pos] = block

					# getting next position value
					pos.x += 1
				else:
					if pos.x >= chunk_size.x + 1:
						pos.x = -1
						pos.y += 1
					if pos.y >= chunk_size.y + 1:
						pos.y = -1
						pos.z += 1

			# pass 2 (set noise variables to what is needed here, in this pass just set blocks[pos] = the block)

			noise.fractal_octaves = 6
			noise2.fractal_octaves = 6
			noise3.fractal_octaves = 6
			caves.fractal_octaves = 4

			# looping through each position in the chunk
			while pos.z < chunk_size.z + 1:
				if pos.x < chunk_size.x + 1 and pos.y < chunk_size.y + 1:

					# EXAMPLE
					# if pos in blocks and blocks[pos] == "stone" \
					#         and not (pos + Vector3(0,1,0) in blocks or pos + Vector3(0,1,0) in reference_blocks) \
					#         and caves.get_noise_3d(pos.x, pos.y, pos.z) > 0.5:
					#     blocks[pos] = "grass_stone"

					# write code here
					# Pass 2: Modify terrain (e.g., add decorations, ores)
					if pos in blocks and blocks[pos] == "stone" and pos.z >= 30:
						var noise_value = noise2.get_noise_3d(pos.x, pos.y, pos.z)
						if noise_value > 0.6:
							blocks[pos] = "cobblestone"
						elif noise_value < -0.4:
							blocks[pos] = "block o' rocks"

					# getting next position value
					pos.x += 1
				else:
					if pos.x >= chunk_size.x + 1:
						pos.x = -1
						pos.y += 1
					if pos.y >= chunk_size.y + 1:
						pos.y = -1
						pos.z += 1

			if debug: print("ran: " + i)
	
	
		if i == "chatGPT2": #Frozen Peaks
			# setup

			noise.fractal_octaves = 8
			noise2.fractal_octaves = 6
			noise3.fractal_octaves = 7
			caves.fractal_octaves = 4
			
			
			# Pass 1
			# looping through each position in the chunk
			while pos.z < chunk_size.z + 1:
				if pos.x < chunk_size.x + 1 and pos.y < chunk_size.y + 1:
					var rel_pos = pos + chunk_pos*chunk_size
					# Write Generation code here
					# Pass 1: Generate terrain structure
					var height = 80
					var surface_level = noise.get_noise_3d(rel_pos.x, rel_pos.y, rel_pos.z) * 10.0 + height
					var cave_noise = caves.get_noise_3d(rel_pos.x, rel_pos.y, rel_pos.z)
					
					if rel_pos.y <= surface_level:
						if rel_pos.y <= surface_level - 5:
							block = "stone"
						else:
							block = "dirt"
					elif rel_pos.y <= surface_level + 3:
						if rel_pos.y <= surface_level + 2:
							if cave_noise > 0.3:
								block = "cobblestone"
							else:
								block = "cloud"
						else:
							block = null
					else:
						block = null
					
					
					# adding block to dictionary
					if block != null:
						if pos.x >= 0 and pos.x < chunk_size.x \
						and pos.y >= 0 and pos.y < chunk_size.y\
						and pos.z >= 0 and pos.z < chunk_size.z:
							blocks[pos] = block
						else:
							reference_blocks[pos] = block
					
					# getting next position value
					pos.x += 1
				else:
					if pos.x >= chunk_size.x + 1:
						pos.x = -1
						pos.y += 1
					if pos.y >= chunk_size.y + 1:
						pos.y = -1
						pos.z += 1
			
			
			# Pass 2 (set noise variables to what is needed here, in this pass just set blocks[pos] = the block)
			
			noise.fractal_octaves = 8
			noise2.fractal_octaves = 6
			noise3.fractal_octaves = 7
			caves.fractal_octaves = 4
			
			# looping through each position in the chunk
			while pos.z < chunk_size.z + 1:
				if pos.x < chunk_size.x + 1 and pos.y < chunk_size.y + 1:
					
					# Write code here
					# Pass 2: Modify terrain (e.g., add decorations, ores)
					if pos in blocks and blocks[pos] == "stone" and pos.z >= 40:
						var noise_value = noise2.get_noise_3d(pos.x, pos.y, pos.z)
						if noise_value > 0.6:
							blocks[pos] = "cobblestone"
						elif noise_value < -0.4:
							blocks[pos] = "block o' rocks"
					
					# getting next position value
					pos.x += 1
				else:
					if pos.x >= chunk_size.x + 1:
						pos.x = -1
						pos.y += 1
					if pos.y >= chunk_size.y + 1:
						pos.y = -1
						pos.z += 1
				
			if debug: print("ran: " + i)
	
	
	
	if deep_debug: print(blocks)
	
	var block_array = []
	block_array.resize(32768)
	
	for x in blocks.keys():
		block_array[vector_to_array_pos(x)] = blocks[x]
	
	var info = [block_array, reference_blocks]
	
	return info



func generate_stucture(pos, structure, debug, deep_debug):
	print("generating structure at " + str(pos))
	print("in chunk " + str(get_block_chunk(pos)))
	
	
	
	var min_vector = structures[structure].keys()[0] + pos
	var max_vector = structures[structure].keys()[0] + pos
	var relative = {}
	
	
	for x in structures[structure].keys():
		relative[x + pos] = structures[structure][x]
	
	for x in relative.keys():
		if x.x < min_vector.x:
			min_vector.x = x.x
		if x.y < min_vector.y:
			min_vector.y = x.y
		if x.z < min_vector.z:
			min_vector.z = x.z
		
		if x.x > max_vector.x:
			max_vector.x = x.x
		if x.y > max_vector.y:
			max_vector.y = x.y
		if x.z > max_vector.z:
			max_vector.z = x.z
	
	
	var chunk_overspill_min = get_block_chunk(min_vector)
	var chunk_overspill_max = get_block_chunk(max_vector)
	
	print("generated min/max values")
	print(min_vector)
	print(max_vector)
	print(chunk_overspill_min)
	print(chunk_overspill_max)
	
	var block_data = {}
	var chunk_check_process = chunk_overspill_min
	
	print("generating missing chunks and moving everything to block_data")
	
	while chunk_check_process.x <= chunk_overspill_max.x:
		while chunk_check_process.y <= chunk_overspill_max.y:
			while chunk_check_process.z <= chunk_overspill_max.z:
				
				print("checking: " + str(chunk_check_process))
				
				if chunk_data.has(chunk_check_process):
					block_data[chunk_check_process] = decode_chunk(get_chunk_data(get_block_chunk(chunk_check_process)))
					
				
				
				else:
					var type
					var chunk_y = chunk_check_process.y
					
					if chunk_y > 7: type = ['semirealistic']
					elif 5 < chunk_y and chunk_y <= 7: type = ['semirealistic', 'pillars']
					elif -5 < chunk_y and chunk_y < 5: type = ['pillars']
					elif chunk_y < 10: type = ['cake']
					elif chunk_y <= 5: type = ['cake', 'pillars']
					
					chunk_data[chunk_check_process] = \
							encode_chunk(generate_chunk(chunk_check_process, world_seed, type, debug, deep_debug))
					
					block_data[chunk_check_process] = decode_chunk(get_chunk_data(chunk_check_process))
				
				chunk_check_process.z += 1
			chunk_check_process.z = chunk_overspill_min.z
			chunk_check_process.y += 1
		chunk_check_process.y = chunk_overspill_min.y
		chunk_check_process.x += 1
	
	print("done generating missing chunks")
	
	print("placing structure into artificial chunks")
	
	
	for x in structures[structure]:
		if deep_debug: print("placing " + str(x))
		var block_chunk = Vector3.ZERO
		var block_process = x + pos
		
#		var block_chunk = get_block_chunk(x + pos)
#		var block_process = Vector3(int(x.x + pos.x) % int(chunk_size.x), \
#									int(x.y + pos.y) % int(chunk_size.y), \
#									int(x.z + pos.z) % int(chunk_size.z))
		
		while block_process.x > chunk_size.x-1:
			block_chunk.x += 1
			block_process.x -= chunk_size.y
			if deep_debug: print("shifting +1 x")
			if deep_debug: print("current pos in chunk" + str(block_process))
			if deep_debug: print("current chunk_pos" + str(block_chunk))
		while block_process.y > chunk_size.y-1:
			block_chunk.y += 1
			block_process.y -= chunk_size.y
			if deep_debug: print("shifting +1 y")
			if deep_debug: print("current pos in chunk" + str(block_process))
			if deep_debug: print("current chunk_pos" + str(block_chunk))
		while block_process.z > chunk_size.z-1:
			block_chunk.z += 1
			block_process.z -= chunk_size.z
			if deep_debug: print("shifting +1 z")
			if deep_debug: print("current pos in chunk" + str(block_process))
			if deep_debug: print("current chunk_pos" + str(block_chunk))
		
		
		while block_process.x < 0:
			block_chunk.x -= 1
			block_process.x += chunk_size.x
			if deep_debug: print("shifting -1 x")
			if deep_debug: print("current pos in chunk" + str(block_process))
			if deep_debug: print("current chunk_pos" + str(block_chunk))
		while block_process.y < 0:
			block_chunk.y -= 1
			block_process.y += chunk_size.y
			if deep_debug: print("shifting -1 y")
			if deep_debug: print("current pos in chunk" + str(block_process))
			if deep_debug: print("current chunk_pos" + str(block_chunk))
		while block_process.z < 0:
			block_chunk.z -= 1
			block_process.z += chunk_size.z
			if deep_debug: print("shifting -1 z")
			if deep_debug: print("current pos in chunk" + str(block_process))
			if deep_debug: print("current chunk_pos" + str(block_chunk))
		

		print("pos in chunk" + str(block_process))
		print("chunk_pos" + str(block_chunk))
		
		
		
		block_data[block_chunk][block_process] = structures[structure][x]

	print("replacing chunks with artificial chunks")
	
	for x in block_data.keys():
		print(x)
		chunk_data[x] = encode_chunk(block_data[x])


func build_chunk_edgeless(blocks, reference_blocks, chunk_pos, Seed, debug, deep_debug):
	var noise = FastNoiseLite.new()
	noise.seed = Seed
	
	if debug: print('building chunk')
	
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	var mesh = ArrayMesh.new()
	
	if debug: print('start mesh creation')
	
	var array_pos = -1
	for x in blocks:
		array_pos += 1
		var block_pos = array_pos_to_vector(array_pos)
		if x != null and x != "air":
			if deep_debug: print("creating mesh for: " + str(x))
			
			var side = Vector3(0,1,0)
			if  (vector_to_array_pos(block_pos + side) == null
					and not block_pos + side in reference_blocks) \
					or (vector_to_array_pos(block_pos + side) != null
					and blocks[vector_to_array_pos(block_pos + side)] == null):
				var a = Vector3(-.5,.5,.5) + block_pos
				var b = Vector3(.5,.5,-.5) + block_pos
				var c = Vector3(.5,.5,.5) + block_pos
				var d = Vector3(-.5,.5,-.5) + block_pos
				
				var block = BlockModels.TEXTURES[x + '_top']
				
				var ta = Vector2((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*block.y)
				var tb = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*(block.y-1))
				var tc = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*block.y)
				var td = Vector2 ((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*(block.y-1))
				st.add_triangle_fan(([a,b,c]), ([ta,tb,tc]))
				st.add_triangle_fan(([b,a,d]), ([tb, ta, td]))
				
			side = Vector3(0,-1,0)
			if  (vector_to_array_pos(block_pos + side) == null
					and not block_pos + side in reference_blocks) \
					or (vector_to_array_pos(block_pos + side) != null
					and blocks[vector_to_array_pos(block_pos + side)] == null):
				var a = Vector3(-.5,-.5,.5) + block_pos
				var b = Vector3(.5,-.5,-.5) + block_pos
				var c = Vector3(.5,-.5,.5) + block_pos
				var d = Vector3(-.5,-.5,-.5) + block_pos
				
				var block = BlockModels.TEXTURES[x + '_bottom']
				
				var ta = Vector2((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*block.y)
				var tb = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*(block.y-1))
				var tc = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*block.y)
				var td = Vector2 ((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*(block.y-1))
				st.add_triangle_fan(([b,a,c]), ([ta,tb,tc]))
				st.add_triangle_fan(([a,b,d]), ([tb, ta, td]))
				
			side = Vector3(1,0,0)
			if  (vector_to_array_pos(block_pos + side) == null
					and not block_pos + side in reference_blocks) \
					or (vector_to_array_pos(block_pos + side) != null
					and blocks[vector_to_array_pos(block_pos + side)] == null):
				var a = Vector3(.5,.5,-.5) + block_pos
				var b = Vector3(.5,-.5,.5) + block_pos
				var c = Vector3(.5,.5,.5) + block_pos
				var d = Vector3(.5,-.5,-.5) + block_pos
				
				var block = BlockModels.TEXTURES[x + '_side_' + str(int(abs(noise.get_noise_3d(block_pos.x*100, block_pos.y*100, block_pos.z*100)*8))%8+1)]
				
				var ta = Vector2((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*block.y)
				var tb = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*(block.y-1))
				var tc = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*block.y)
				var td = Vector2 ((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*(block.y-1))
				st.add_triangle_fan(([a,b,c]), ([tb,ta,td]))
				st.add_triangle_fan(([b,a,d]), ([ta, tb, tc]))
				
			side = Vector3(-1,0,0)
			if  (vector_to_array_pos(block_pos + side) == null
					and not block_pos + side in reference_blocks) \
					or (vector_to_array_pos(block_pos + side) != null
					and blocks[vector_to_array_pos(block_pos + side)] == null):
				var a = Vector3(-.5,.5,-.5) + block_pos
				var b = Vector3(-.5,-.5,.5) + block_pos
				var c = Vector3(-.5,.5,.5) + block_pos
				var d = Vector3(-.5,-.5,-.5) + block_pos
				
				var block = BlockModels.TEXTURES[x + '_side_' + str(int(abs(noise.get_noise_3d(block_pos.x*100, block_pos.y*100, block_pos.z*100)*8))%8+1)]
				
				var ta = Vector2((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*block.y)
				var tb = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*(block.y-1))
				var tc = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*block.y)
				var td = Vector2 ((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*(block.y-1))
				st.add_triangle_fan(([b,a,c]), ([ta,tb,td]))
				st.add_triangle_fan(([a,b,d]), ([tb, ta, tc]))
				
			side = Vector3(0,0,1)
			if  (vector_to_array_pos(block_pos + side) == null
					and not block_pos + side in reference_blocks) \
					or (vector_to_array_pos(block_pos + side) != null
					and blocks[vector_to_array_pos(block_pos + side)] == null):
				var a = Vector3(.5,-.5,.5) + block_pos
				var b = Vector3(-.5,.5,.5) + block_pos
				var c = Vector3(.5,.5,.5) + block_pos
				var d = Vector3(-.5,-.5,.5) + block_pos
				
				var block = BlockModels.TEXTURES[x + '_side_' + str(int(abs(noise.get_noise_3d(block_pos.x*100, block_pos.y*100, block_pos.z*100)*8))%8+1)]
				
				var ta = Vector2((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*block.y)
				var tb = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*(block.y-1))
				var tc = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*block.y)
				var td = Vector2 ((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*(block.y-1))
				st.add_triangle_fan(([a,b,c]), ([ta,tb,td]))
				st.add_triangle_fan(([b,a,d]), ([tb, ta, tc]))
				
			side = Vector3(0,0,-1)
			if  (vector_to_array_pos(block_pos + side) == null
					and not block_pos + side in reference_blocks) \
					or (vector_to_array_pos(block_pos + side) != null
					and blocks[vector_to_array_pos(block_pos + side)] == null):
				var a = Vector3(.5,-.5,-.5) + block_pos
				var b = Vector3(-.5,.5,-.5) + block_pos
				var c = Vector3(.5,.5,-.5) + block_pos
				var d = Vector3(-.5,-.5,-.5) + block_pos
				
				var block = BlockModels.TEXTURES[x + '_side_' + str(int(abs(noise.get_noise_3d(block_pos.x*100, block_pos.y*100, block_pos.z*100)*8))%8+1)]
				
				var ta = Vector2((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*block.y)
				var tb = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*(block.y-1))
				var tc = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*block.y)
				var td = Vector2 ((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*(block.y-1))
				st.add_triangle_fan(([b,a,c]), ([tb,ta,td]))
				st.add_triangle_fan(([a,b,d]), ([ta, tb, tc]))
			
		
			
	if debug: print('end mesh creation')
			
	#st.generate_normals()
	if debug: print('start commit')
	#st.generate_normals()
	st.commit(mesh)
	if debug: print('end commit')
	
	
	var data = []
	
	data.append(chunk_pos)
	data.append(mesh)
		
	if debug: print('start collison')
	var collision_shape = mesh.create_trimesh_shape()
	data.append(collision_shape)
	if debug: print('end collison')
	
	data.append(blocks)
	
	return data

func build_chunk_basic(blocks, reference_blocks, chunk_pos, Seed, debug, deep_debug):
	var noise = FastNoiseLite.new()
	noise.seed = Seed
	
	if debug: print('building chunk')
	
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	var mesh = ArrayMesh.new()
	
	if debug: print('start mesh creation')
	
	var array_pos = -1
	for x in blocks:
		array_pos += 1
		var block_pos = array_pos_to_vector(array_pos)
		if x != null:
			if x != "air":
				if deep_debug: print("creating mesh for: " + str(x))
				
				var side = Vector3(0,1,0)
				if  vector_to_array_pos(block_pos + side) == null \
						or blocks[vector_to_array_pos(block_pos + side)] == null:
					var a = Vector3(-.5,.5,.5) + block_pos
					var b = Vector3(.5,.5,-.5) + block_pos
					var c = Vector3(.5,.5,.5) + block_pos
					var d = Vector3(-.5,.5,-.5) + block_pos
					
					var block = BlockModels.TEXTURES[x + '_top']
					
					var ta = Vector2((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*block.y)
					var tb = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*(block.y-1))
					var tc = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*block.y)
					var td = Vector2 ((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*(block.y-1))
					st.add_triangle_fan(([a,b,c]), ([ta,tb,tc]))
					st.add_triangle_fan(([b,a,d]), ([tb, ta, td]))
					
				side = Vector3(0,-1,0)
				if  vector_to_array_pos(block_pos + side) == null \
						or blocks[vector_to_array_pos(block_pos + side)] == null:
					var a = Vector3(-.5,-.5,.5) + block_pos
					var b = Vector3(.5,-.5,-.5) + block_pos
					var c = Vector3(.5,-.5,.5) + block_pos
					var d = Vector3(-.5,-.5,-.5) + block_pos
					
					var block = BlockModels.TEXTURES[x + '_bottom']
					
					var ta = Vector2((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*block.y)
					var tb = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*(block.y-1))
					var tc = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*block.y)
					var td = Vector2 ((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*(block.y-1))
					st.add_triangle_fan(([b,a,c]), ([ta,tb,tc]))
					st.add_triangle_fan(([a,b,d]), ([tb, ta, td]))
					
				side = Vector3(1,0,0)
				if  vector_to_array_pos(block_pos + side) == null \
						or blocks[vector_to_array_pos(block_pos + side)] == null:
					var a = Vector3(.5,.5,-.5) + block_pos
					var b = Vector3(.5,-.5,.5) + block_pos
					var c = Vector3(.5,.5,.5) + block_pos
					var d = Vector3(.5,-.5,-.5) + block_pos
					
					var block = BlockModels.TEXTURES[x + '_side_' + str(int(abs(noise.get_noise_3d(block_pos.x*100, block_pos.y*100, block_pos.z*100)*8))%8+1)]
					
					var ta = Vector2((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*block.y)
					var tb = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*(block.y-1))
					var tc = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*block.y)
					var td = Vector2 ((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*(block.y-1))
					st.add_triangle_fan(([a,b,c]), ([tb,ta,td]))
					st.add_triangle_fan(([b,a,d]), ([ta, tb, tc]))
					
				side = Vector3(-1,0,0)
				if  vector_to_array_pos(block_pos + side) == null \
						or blocks[vector_to_array_pos(block_pos + side)] == null:
					var a = Vector3(-.5,.5,-.5) + block_pos
					var b = Vector3(-.5,-.5,.5) + block_pos
					var c = Vector3(-.5,.5,.5) + block_pos
					var d = Vector3(-.5,-.5,-.5) + block_pos
					
					var block = BlockModels.TEXTURES[x + '_side_' + str(int(abs(noise.get_noise_3d(block_pos.x*100, block_pos.y*100, block_pos.z*100)*8))%8+1)]
					
					var ta = Vector2((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*block.y)
					var tb = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*(block.y-1))
					var tc = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*block.y)
					var td = Vector2 ((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*(block.y-1))
					st.add_triangle_fan(([b,a,c]), ([ta,tb,td]))
					st.add_triangle_fan(([a,b,d]), ([tb, ta, tc]))
					
				side = Vector3(0,0,1)
				if  vector_to_array_pos(block_pos + side) == null \
						or blocks[vector_to_array_pos(block_pos + side)] == null:
					var a = Vector3(.5,-.5,.5) + block_pos
					var b = Vector3(-.5,.5,.5) + block_pos
					var c = Vector3(.5,.5,.5) + block_pos
					var d = Vector3(-.5,-.5,.5) + block_pos
					
					var block = BlockModels.TEXTURES[x + '_side_' + str(int(abs(noise.get_noise_3d(block_pos.x*100, block_pos.y*100, block_pos.z*100)*8))%8+1)]
					
					var ta = Vector2((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*block.y)
					var tb = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*(block.y-1))
					var tc = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*block.y)
					var td = Vector2 ((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*(block.y-1))
					st.add_triangle_fan(([a,b,c]), ([ta,tb,td]))
					st.add_triangle_fan(([b,a,d]), ([tb, ta, tc]))
					
				side = Vector3(0,0,-1)
				if  vector_to_array_pos(block_pos + side) == null \
						or blocks[vector_to_array_pos(block_pos + side)] == null:
					var a = Vector3(.5,-.5,-.5) + block_pos
					var b = Vector3(-.5,.5,-.5) + block_pos
					var c = Vector3(.5,.5,-.5) + block_pos
					var d = Vector3(-.5,-.5,-.5) + block_pos
					
					var block = BlockModels.TEXTURES[x + '_side_' + str(int(abs(noise.get_noise_3d(block_pos.x*100, block_pos.y*100, block_pos.z*100)*8))%8+1)]
					
					var ta = Vector2((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*block.y)
					var tb = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*(block.y-1))
					var tc = Vector2((1.0/(576.0/16))*block.x, (1.0/(576.0/16))*block.y)
					var td = Vector2 ((1.0/(576.0/16))*(block.x-1), (1.0/(576.0/16))*(block.y-1))
					st.add_triangle_fan(([b,a,c]), ([tb,ta,td]))
					st.add_triangle_fan(([a,b,d]), ([ta, tb, tc]))
			
		
			
	if debug: print('end mesh creation')
			
	#st.generate_normals()
	if debug: print('start commit')
	#st.generate_normals()
	st.commit(mesh)
	if debug: print('end commit')
	
	
	var data = []
	
	data.append(chunk_pos)
	data.append(mesh)
		
	if debug: print('start collison')
	var collision_shape = mesh.create_trimesh_shape()
	data.append(collision_shape)
	if debug: print('end collison')
	
	data.append(blocks)

	return data


func encode_chunk(input):
	if typeof(input) == TYPE_ARRAY:
		var output = {}
		for x in input:
			output.append = block_ids[x]
		return output
	print("ERROR: unable to encode chunk, type is not an array")
	return null

func decode_chunk(input):
	if typeof(input) == TYPE_ARRAY:
		var swapped_ids = {}
		
		for x in block_ids.keys():
			swapped_ids[block_ids[x]] = x
		
		var output = {}
		for x in input:
			output.append = swapped_ids[int(x)]
		return output
	print("ERROR: unable to decode chunk, type is not an array")
	return null

func array_pos_to_vector(pos):
	if pos < 0 or pos > 32767:
		#print("ERROR: Array pos " + str(pos) + " is out of range (0 - 32767)")
		return null
	var vector = Vector3.ZERO
	vector.x = pos % 32
	vector.y = int(floor(float(pos) / 32.0)) % 32
	vector.z = int(floor(float(pos) / 1024.0)) % 32
	return vector

func vector_to_array_pos(vector):
	if vector.x < 0 or vector.x > 31\
	or vector.y < 0 or vector.y > 31\
	or vector.z < 0 or vector.z > 31:
		#print("ERROR: vector " + str(vector) + " is out of range (0 - 31)")
		return null
	var pos = vector.x + vector.y * 32 + vector.z * 1024
	pos = int(pos)
	return pos

func get_block_chunk(block_pos):
	return Main.round_vector(block_pos/Generation.chunk_size, Main.FLOOR)


func get_chunk_data(chunk_pos):
	if chunk_pos in chunk_data:
		return decode_chunk(chunk_data[chunk_pos])
	else:
		var data = Files.load_chunk_from_file(chunk_pos)
		if data != null:
			return decode_chunk(data)

func save_chunk_data(chunk_pos, chunk_info):
	chunk_data[chunk_pos] = encode_chunk(chunk_info)

func generate_ring(ring_size, direction):
	var positions = []
	
	var pos = Vector3(0, 0, 0)
	
	var x = 1; x=x
	var z = 1; z=z
	
	if ring_size == 1:
		positions.append(pos)
	
	
	elif direction == 'x':
		while x <= ring_size - 1:
			x += 1 
			pos.x += 1
			
			positions.append(pos)
		var y = 1
		while y <= ring_size - 1:
			y += 1
			pos.y += 1
			positions.append(pos)
			
		x = 1
		while x <= ring_size - 1:
			x += 1
			pos.x -= 1
			positions.append(pos)
			
		y = 1
		while y <= ring_size - 1:
			y += 1
			pos.y -= 1
			positions.append(pos)
	
	
	
	elif direction == 'z':
		while z <= ring_size - 1:
			z += 1 
			pos.z += 1
			
			positions.append(pos)
		var y = 1
		while y <= ring_size - 1:
			y += 1
			pos.y += 1
			positions.append(pos)
			
		z = 1
		while z <= ring_size - 1:
			z += 1
			pos.z -= 1
			positions.append(pos)
			
		y = 1
		while y <= ring_size - 1:
			y += 1
			pos.y -= 1
			positions.append(pos)
	
	
	
	elif direction == 'xz' or direction == 'zx':
		while z <= ring_size - 1:
			z += 1 
			pos.z += 1
			
			positions.append(pos)
		x = 1
		while x <= ring_size - 1:
			x += 1
			pos.x += 1
			positions.append(pos)
			
		z = 1
		while z <= ring_size - 1:
			z += 1
			pos.z -= 1
			positions.append(pos)
			
		x = 1
		while x <= ring_size - 1:
			x += 1
			pos.x -= 1
			positions.append(pos)
	#print(ring_size)
	#print(positions)
	return positions
