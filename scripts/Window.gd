extends Window

@onready var player = get_parent().get_node("Player")
@onready var cameraNode = get_node("Node3D")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cameraNode.position = player.position + player.camera.position
	cameraNode.rotation_degrees = player.camera.rotation_degrees


func _on_close_requested():
	self.queue_free()
	

