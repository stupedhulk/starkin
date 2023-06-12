extends Node3D

@onready var chunks = get_parent().get_node("chunks")
@onready var player = get_parent().get_node("Player")

var timer

var cloud_thread
var cloud_height = 1400
var cloud_height_spread = 40
var cloud_spawn_rate = 0.1
var cloud_distance = 500

@export var debug = true
@export var deep_debug = true

func _ready():
	#timer setup
	var new = Timer.new()
	new.name = "Timer"
	new.wait_time = float(cloud_spawn_rate)/(float(cloud_distance)/100.0)
	new.autostart = true
	add_child(new)
	timer = get_node("Timer")
	timer.timeout.connect(cloud_timer_timeout)
	cloud_thread = Thread.new()
	


#func cloud_handler():
#	if true:
#		load_cloud(Generation.build_chunk(Generation.cloud, player.position, Generation.world_seed, debug, deep_debug))



func cloud_timer_timeout():
	pass
	#if cloud_thread.is_started(): cloud_thread.wait_to_finish()
	#Thread.new().start(Callable(self,"cloud_handler"),Thread.PRIORITY_HIGH)
	
	
func load_cloud(data):
	var cloud = CSGMesh3D.new()
	cloud.material_override = load("res://chunk.tres")
	cloud.position = data[0]
	cloud.position.z -= 500
	cloud.position.x += randi()%cloud_distance * 2 - cloud_distance
	cloud.position.y = cloud_height + randi() % cloud_height_spread - cloud_height_spread/2
	cloud.mesh = data[1]
	cloud.set_script(load("res://scripts/cloud.gd"))
	cloud.set_process(true)
	cloud.set_physics_process(true)
	add_child.call_deferred(cloud)
