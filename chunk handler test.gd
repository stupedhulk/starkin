extends Node3D

var chunk_pos = Vector3(0, 0 ,0)
var debug = false
var deep_debug = false
var type = 'test'
var origin_offset = Vector3(0,0,0)

var player_old_chunk = null

signal generate_next

var load_chunks = true

func _ready():
	var thread = Thread.new()
	thread.start(handler, Thread.PRIORITY_HIGH)


func handler():
	var j = 0; var a = 10000; while j < a*2:
		var i = 0; while i < j:
			for x in generate_ring((j-i)*2-1, "x"):
				chunk_pos = x + Vector3(-j+i+1, -j+i+1, i)
				await self.generate_next
				generate_cube(chunk_pos)
			
			for x in generate_ring((j-i)*2-1, "x"):
				chunk_pos = x + Vector3(-j+i+1, -j+i+1, -i)
				if chunk_pos.z != 0: #change made here
					await self.generate_next
					generate_cube(chunk_pos)
			i += 1
		j += 1

func generate_cube(chunk_pos):
	var new = CSGBox3D.new()
	var material = StandardMaterial3D.new()
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material.albedo_color = Color8(100, 100, 255, 50)
	new.position = chunk_pos
	new.material = material
	call_deferred("add_child", new)

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
	
	return positions



func _on_button_pressed():
	emit_signal("generate_next")
