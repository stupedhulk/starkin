extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	RenderingServer.set_debug_generate_wireframes(true)
	get_viewport().debug_draw = Viewport.DEBUG_DRAW_WIREFRAME

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
