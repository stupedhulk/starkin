@tool
extends MeshInstance3D

@export var debug = true
@export var show_boundaries = false
@export var generate = false
@export var type = "semi realistic"
@export var world_seed = 279
@export var pos = Vector3(0,0,0)
@export var CHUNK_SIZE = Vector3(32,32,32)


var benchmark = false
var startup_time = 0
var last_benchmark_time = 0
var benchmark_per_block = false
@onready var generation = Generation
@onready var block_models = BlockModels


var a = false

func _process(_delta):
	if visibility_changed:
		if !visible: 
			a = false
			mesh=ArrayMesh.new()
		else:
			if !a: 
				#generation.build_chunk_exp(generation.generate_chunk(pos, world_seed, type, false, false),pos)
				a = true
