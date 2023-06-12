extends CSGMesh3D

var chunk_pos = Vector3(-1, 41, 0)
var Seed = 279
var generation_type = ["starkin"]
var debug = false
var deep_debug = false
var algorithm = "basic"


func _ready():
	generate_chunk()

func generate_chunk():
	var block_info = Generation.generate_chunk(chunk_pos, Seed, generation_type, debug, deep_debug)
	var info
	
	if algorithm == "edgeless":
		info = Generation.build_chunk_edgeless(block_info[0], block_info[1],  chunk_pos, Seed, debug, deep_debug)
	if algorithm == "basic":
		info = Generation.build_chunk_basic(block_info[0], block_info[1],  chunk_pos, Seed, debug, deep_debug)
	
	mesh = info[1]
	material = load("res://chunk.tres")


func _on_chunk_pos_x_drag_ended(value):
	chunk_pos.x = value
	generate_chunk()


func _on_chunk_pos_y_drag_ended(value):
	chunk_pos.y = value
	generate_chunk()


func _on_chunk_pos_z_drag_ended(value):
	chunk_pos.z = value
	generate_chunk()


func _on_chunk_pos_x_value_changed(value, dragging):
	if !dragging:
		chunk_pos.x = value
		generate_chunk()


func _on_chunk_pos_y_value_changed(value, dragging):
	if !dragging:
		chunk_pos.y = value
		generate_chunk()


func _on_chunk_pos_z_value_changed(value, dragging):
	if !dragging:
		chunk_pos.z = value
		generate_chunk()


func _on_generation_type_changed(type):
	generation_type[0] = type
	generate_chunk()


func _on_build_type_changed(type):
	algorithm = type
	generate_chunk()
