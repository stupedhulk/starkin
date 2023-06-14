extends StaticBody3D



@export var render_distance = 10
@export var debug = true
@export var deep_debug = false
@export var show_boundaries = false
@export var benchmark = true
@export var benchmark_per_block = true
var override_chunk = false
var chunk_override = ["semirealistic"]
@export var chunk_threads = 1
@export var override_player_pos = true
@export var player_pos_override = Vector3(0,0,0)




var chunk_handler_thread = Thread.new()
var chunk_load_threads = [Thread.new(), Thread.new(), Thread.new(), Thread.new(), Thread.new(), Thread.new(), Thread.new(), Thread.new(), Thread.new(), Thread.new()]
var busy_chunk_threads = [false, false, false, false, false, false, false, false, false, false]
var block_place_threads = []



@onready var player = get_parent().get_node("Player")



var player_chunk
var vr = false
var startup_time
var last_benchmark_time


const STRUCTURES = {
	'tree_1' : 'res://structures/tree_1.struct'
}



func _ready():
	print("amount of processors: " + str(OS.get_processor_count()))
	override_chunk = Generation.override_chunk
	chunk_override = Generation.chunk_override
#	RenderingServer.set_debug_generate_wireframes(true)
#	get_viewport().debug_draw = Viewport.DEBUG_DRAW_WIREFRAME
	
	
	print("testing vector: (16, 18, 17)")
	var output = Generation.vector_to_array_pos(Vector3(16, 18, 17))
	print(output)
	output = Generation.array_pos_to_vector(output)
	print(output)
	
	print("testing number: 1761")
	output = Generation.array_pos_to_vector(1761)
	print(output)
	output =  Generation.vector_to_array_pos(output)
	print(output)
	
	if debug: print("ready")
	
	#pregen()
	#Generation.generate_stucture(Vector3(-24,1307,13), "test", debug, deep_debug)
	
	if !deep_debug: chunk_handler_thread.start(Callable(self,"chunk_handler").bind(Generation.world_seed),Thread.PRIORITY_HIGH)
	else: chunk_handler(Generation.world_seed)
	
	
	var noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.fractal_octaves = 9
	noise.seed = Generation.world_seed
	
	player.position.y = round(noise.get_noise_2d(player.position.x/Generation.smooth,\
			player.position.z/Generation.smooth)*Generation.scale) + 1320
	if override_chunk and "flat" in chunk_override:
		player.position.y = 1000
		
	if override_player_pos: player.position = player_pos_override
	
	if FileAccess.file_exists("user://worlds/" + Generation.world_name + "/player properties.txt"):
		var file = FileAccess.open("user://worlds/" + Generation.world_name + "/player properties.txt", FileAccess.READ)
		var data = file.get_as_text()
		data = data.replace("(", '"Vector3(')
		data = data.replace(')', ')"')
		print(data)
		data = JSON.parse_string(data)
		print(data)
		if data != null:
			player.position = str_to_var(data["player position"])
	
	
	
	get_parent().get_node("Pregen Screen").visible = false


func _physics_process(delta):
	clean_block_threads()


func pregen():
	if debug: print("pregen started")
	var chunk_pos = Vector3(-2,40,-2)
	var type = ["test"]
	
	while chunk_pos.x <= 2:
		while chunk_pos.y <= 42:
			while chunk_pos.z <= 2:
				var chunk_y = floor(chunk_pos.y)
				if benchmark: type = ['dank uncle chunky']
				elif override_chunk: type = chunk_override
				elif chunk_y > 7: type = ['semirealistic']
				elif 5 < chunk_y and chunk_y <= 7: type = ['semirealistic', 'pillars']
				elif -5 < chunk_y and chunk_y < 5: type = ['pillars']
				elif chunk_y < 10: type = ['cake']
				elif chunk_y <= 5: type = ['cake', 'pillars']
				
				type = ["test"]
				
				Generation.save_chunk_to_file(chunk_pos,
					Generation.generate_chunk(chunk_pos, Generation.world_seed, type, debug, deep_debug))
				chunk_pos.z += 1
			chunk_pos.z = -2
			
			chunk_pos.y += 1
		chunk_pos.y = 40
		
		chunk_pos.x += 1
	if debug: print("pregen ended")


func get_inactive_chunk_thread():
	if debug: print("getting inactive thread")
	for x in range(chunk_load_threads.size()):
		if typeof(busy_chunk_threads[x]) != TYPE_VECTOR3 and !chunk_load_threads[x].is_alive():
			if debug: print("found: " + str(x))
			return chunk_load_threads[x]
	if debug: print("no active threads")
	return false


func clean_chunk_threads():
	if debug: print("cleaning threads")
	for x in range(chunk_load_threads.size()):
		if !chunk_load_threads[x].is_alive() and chunk_load_threads[x].is_started():
			chunk_load_threads[x].wait_to_finish()
			busy_chunk_threads[x] = false
			if debug: print("cleaned thread: " + str(x))
		


func chunk_handler(Seed):
	if benchmark: startup_time = Time.get_ticks_msec()
	if benchmark: print("startup time: " + str(startup_time))
	if debug: print('chunks started')
	var type = 'test'
	var origin_offset = Vector3(0,0,0)
	var start_pos = Vector3(0,1,0) + origin_offset
	var chunk_pos = start_pos
	
	var player_old_chunk = null
	
	if benchmark: last_benchmark_time = Time.get_ticks_msec()
	if benchmark: print("Setup Time: " + str(last_benchmark_time - startup_time))
	
	var load_chunks = true
	while(load_chunks):
		if Generation.get_block_chunk(player.position) != player_old_chunk:
			player_old_chunk = Generation.get_block_chunk(player.position)

			type = ['semirealistic']
			var j = 0; var a = render_distance; while Generation.get_block_chunk(player.position) == player_old_chunk and load_chunks and j < a*2:
				var i = 0; while Generation.get_block_chunk(player.position) == player_old_chunk and load_chunks and i < j:
					for x in Generation.generate_ring((j-i)*2-1, "x"):
						if Input.is_action_just_pressed("update"):
							load_chunks = false
						chunk_pos = x + Generation.get_block_chunk(player.position) + Vector3(-j+i+1, -j+i+1, i)
						if get_node_or_null(str(chunk_pos)) == null and not i > a and Generation.get_block_chunk(player.position) == player_old_chunk and load_chunks:
							if debug: print("checking for existing chunk at " + str(chunk_pos))
							if Generation.get_chunk_data(chunk_pos) != null:
								if debug: print("chunk found")
								if deep_debug: print(Generation.get_chunk_data(chunk_pos))
								
								#getting availible thread. If there is none it keeps trying until there is one
								clean_chunk_threads()
								var thread = get_inactive_chunk_thread()
								if debug: print("thread = " + str(thread))
								while typeof(thread) != TYPE_OBJECT:
									if debug: print("trying to get active thread again")
									clean_chunk_threads()
									thread = get_inactive_chunk_thread()
								if debug: print("recieved thread: " + str(thread))
								
								#using the available thread to generate the chunk if the chunk isnt already being generated by another thread
								if not chunk_pos in busy_chunk_threads:
									if debug: print("no threads creating this chunk, starting now")
									busy_chunk_threads[chunk_load_threads.find(thread, 0)] = chunk_pos
									var function = create_chunk.bind(chunk_pos, Seed, type)
									thread.start(function, Thread.PRIORITY_NORMAL)
							else:
								if benchmark: type = ['dank uncle chunky']
								elif override_chunk: type = chunk_override
								else: type = ['starkin']

								#getting availible thread. If there is none it keeps trying until there is one
								clean_chunk_threads()
								var thread = get_inactive_chunk_thread()
								if debug: print("thread = " + str(thread))
								while typeof(thread) != TYPE_OBJECT:
									if debug: print("trying to get active thread again")
									clean_chunk_threads()
									thread = get_inactive_chunk_thread()
								if debug: print("recieved thread: " + str(thread))
								
								#using the available thread to generate the chunk if the chunk isnt already being generated by another thread
								if not chunk_pos in busy_chunk_threads:
									if debug: print("no threads creating this chunk, starting now")
									busy_chunk_threads[chunk_load_threads.find(thread, 0)] = chunk_pos
									var function = create_chunk.bind(chunk_pos, Seed, type)
									thread.start(function, Thread.PRIORITY_NORMAL)
								#create_chunk(chunk_pos, Seed, type)
					for x in Generation.generate_ring((j-i)*2-1, "x"):
						if Input.is_action_just_pressed("update"):
							load_chunks = false
						var player_pos = Generation.get_block_chunk(player.position)
						chunk_pos = x + player_pos + Vector3(-j+i+1, -j+i+1, -i)
						if get_node_or_null(str(chunk_pos)) == null and not i > a \
								and Generation.get_block_chunk(player.position) == player_old_chunk \
								and load_chunks and (chunk_pos - player_pos).z != 0:
							if debug: print("checking for existing chunk at " + str(chunk_pos))
							if Generation.get_chunk_data(chunk_pos) != null:
								if debug: print("chunk found")
								if deep_debug: print(Generation.get_chunk_data(chunk_pos))
								
								var block_info = Generation.generate_chunk(chunk_pos, Seed, type, debug, deep_debug)
								
								#getting availible thread. If there is none it keeps trying until there is one
								clean_chunk_threads()
								var thread = get_inactive_chunk_thread()
								if debug: print("thread = " + str(thread))
								while typeof(thread) != TYPE_OBJECT:
									if debug: print("trying to get active thread again")
									clean_chunk_threads()
									thread = get_inactive_chunk_thread()
								if debug: print("recieved thread: " + str(thread))
								
								#using the available thread to generate the chunk if the chunk isnt already being generated by another thread
								if not chunk_pos in busy_chunk_threads:
									if debug: print("no threads creating this chunk, starting now")
									busy_chunk_threads[chunk_load_threads.find(thread, 0)] = chunk_pos
									var function = create_chunk.bind(chunk_pos, Seed, type)
									thread.start(function, Thread.PRIORITY_NORMAL)
							else:
								if benchmark: type = ['dank uncle chunky']
								elif override_chunk: type = chunk_override
								else: type = ['starkin']
								
								#getting availible thread. If there is none it keeps trying until there is one
								clean_chunk_threads()
								var thread = get_inactive_chunk_thread()
								if debug: print("thread = " + str(thread))
								while typeof(thread) != TYPE_OBJECT:
									if debug: print("trying to get active thread again")
									clean_chunk_threads()
									thread = get_inactive_chunk_thread()
								if debug: print("recieved thread: " + str(thread))
								
								#using the available thread to generate the chunk if the chunk isnt already being generated by another thread
								if not chunk_pos in busy_chunk_threads:
									if debug: print("no threads creating this chunk, starting now")
									busy_chunk_threads[chunk_load_threads.find(thread, 0)] = chunk_pos
									var function = create_chunk.bind(chunk_pos, Seed, type)
									thread.start(function, Thread.PRIORITY_NORMAL)
#								create_chunk(chunk_pos, Seed, type)
					i += 1
				j += 1





#   create_chunk() automaticly generates builds and loads the chunk all in one function.
#   to have more control, use generate_chunk() build_chunk() and load_chunk() indevidually
#   create_chunk is designed to be used safely in threads so it it recommended to use
#   the other functions seperatly when not using it for world building
func create_chunk(chunk_pos, Seed, type):
	var block_info = Generation.generate_chunk(chunk_pos, Seed, type, debug, deep_debug)
	load_chunk(
		Generation.build_chunk_edgeless(block_info[0], block_info[1],  chunk_pos, Seed, debug, deep_debug),
		false
		)


func load_chunk(data, save):
	var chunk = CSGMesh3D.new()
	chunk.name = str(data[0])
	chunk.material_override = load("res://chunk.tres")
	chunk.position = data[0]*Generation.chunk_size
	chunk.mesh = data[1]
	chunk.set_process(true)
	chunk.set_physics_process(true)
	if !get_node_or_null(str(data[0])): add_child.call_deferred(chunk)
	
	var collision = CollisionShape3D.new()
	collision.shape = data[2]
	collision.position = data[0]*Generation.chunk_size
	collision.name = str(data[0]) + "C"
	if !get_node_or_null(str(data[0]) + "C"): add_child.call_deferred(collision)
	
	if save: 
		Generation.save_chunk_data(data[0], data[3])



func place_block(global_pos, type):
	var thread = Thread.new()
	thread.start(place_block_threaded.bind(global_pos, type), Thread.PRIORITY_HIGH)
	block_place_threads.append(thread)
	
	#update(chunk_pos)


func place_block_threaded(global_pos, type):
	var chunk_pos = floor(global_pos/Generation.chunk_size)
	var pos = global_pos-chunk_pos*Generation.chunk_size
	var chunk_data = Generation.get_chunk_data(chunk_pos)
	if chunk_data != null:
		if type != null:
			var temp = chunk_data
			temp[pos] = type
			Generation.save_chunk_data(chunk_pos, temp)
		else:
			chunk_data.erase(pos)
			Generation.save_chunk_data(chunk_pos, chunk_data)
	
	update(chunk_pos)


func clean_block_threads():
	for x in block_place_threads:
		if !x.is_alive():
			x.wait_to_finish()
			block_place_threads.erase(x)


func update(chunk_pos):
	var collision
	var chunk
	if get_node_or_null(str(chunk_pos)):
		chunk = get_node(str(chunk_pos))
		collision = get_node(str(chunk_pos) + "C")
	var chunk_data = Generation.get_chunk_data(chunk_pos)
	if chunk_data != null:
		var data = Generation.build_chunk_edgeless(Generation.get_chunk_data(chunk_pos), null, chunk_pos, Generation.world_seed, debug, deep_debug) #implement new generation here later
		chunk.mesh = data[1]
		collision.shape = data[2]
	print("failed to update chunk, chunk is non existant")

func clean_chunks():
	var cleaned = false
	for x in get_children():
		if "@" in x.name:
			x.queue_free()
			cleaned = true
	return cleaned



#ring size is the length of each side of the ring. 
#|
#|  This value can be 1-inf
#|
#|  so a ring size of 3 will look like this:
#|     0  0  0
#|     0     0
#|     0  0  0
#|
#|  or if you set it to 6 it will look like this:
#|     0  0  0  0  0  0
#|     0              0
#|     0              0
#|     0              0
#|     0              0
#|     0  0  0  0  0  0
#|
#direction is the direction the ring will generate towards. 
#|  
#|  this value can be "x" or "z"
#|
#|  if it is set to "x" it will look like this:
#|
#|       +y
#|        |  0  0  0  0
#|        |  0        0
#|        |  0        0
#|        |  0  0  0  0
#|  -x ---+------------- +x
#|        |
#|       -y
#|  if it is set to "x" it will look like this:
#|
#|       +y
#|        |  0  0  0  0
#|        |  0        0
#|        |  0        0
#|        |  0  0  0  0
#|  -z ---+------------- +z
#|        |
#|       -y

func generate_ring(ring_size, direction):
	var positions = []
	
	var pos = Vector3(0, 0, 0)
	
	var x = 1; x=x
	var z = 1; z=z
	
	if direction == 'x':
		while x <= ring_size:
			x += 1 
			pos.x += 1
			
			positions.append(pos)
		var y = 1
		while y <= ring_size:
			y += 1
			pos.y += 1
			positions.append(pos)
			
		x = 1
		while x <= ring_size:
			x += 1
			pos.x -= 1
			positions.append(pos)
			
		y = 1
		while y <= ring_size:
			y += 1
			pos.y -= 1
			positions.append(pos)
	
	
	
	elif direction == 'z':
		while z <= ring_size:
			z += 1 
			pos.z += 1
			
			positions.append(pos)
		var y = 1
		while y <= ring_size:
			y += 1
			pos.y += 1
			positions.append(pos)
			
		z = 1
		while z <= ring_size:
			z += 1
			pos.z -= 1
			positions.append(pos)
			
		y = 1
		while y <= ring_size:
			y += 1
			pos.y -= 1
			positions.append(pos)
	
	
	
	elif direction == 'z':
		while z <= ring_size:
			z += 1 
			pos.z += 1
			
			positions.append(pos)
		var y = 1
		while y <= ring_size:
			y += 1
			pos.y += 1
			positions.append(pos)
			
		z = 1
		while z <= ring_size:
			z += 1
			pos.z -= 1
			positions.append(pos)
			
		y = 1
		while y <= ring_size:
			y += 1
			pos.y -= 1
			positions.append(pos)
	
	return positions



func _on_FPController_initialised():
	vr = true
