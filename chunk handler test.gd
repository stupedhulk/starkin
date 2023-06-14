extends Node3D

var chunk_pos = Vector3(0, 0 ,0)
var debug = false
var deep_debug = false
var type = 'test'
var origin_offset = Vector3(0,0,0)

var player_old_chunk = null

signal generate_next

var load_chunks = true

@export var generate_per_layer = false
@export var generate_per_ring = false
@export var generate_per_chunk = false

func _ready():
	if generate_per_layer:
		generate_per_ring = false
		generate_per_chunk = false
		
	elif generate_per_ring:
		generate_per_chunk = false
		
	elif !generate_per_chunk:
		generate_per_chunk = true
	
	var thread = Thread.new()
	thread.start(handler, Thread.PRIORITY_HIGH)


func handler():
	var j = 0; var a = 10000; while j < a*2:
		if generate_per_layer: await self.generate_next
		var i = 0; while i < j:
			if generate_per_ring: await self.generate_next
			for x in Generation.generate_ring((j-i)*2-1, "x"):
				chunk_pos = x + Vector3(-j+i+1, -j+i+1, i)
				if generate_per_chunk: await self.generate_next
				generate_cube(chunk_pos)
			if generate_per_ring: await self.generate_next
			for x in Generation.generate_ring((j-i)*2-1, "x"):
				chunk_pos = x + Vector3(-j+i+1, -j+i+1, -i)
				if chunk_pos.z != 0: #change made here
					if generate_per_chunk: await self.generate_next
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



func _on_button_pressed():
	emit_signal("generate_next")
