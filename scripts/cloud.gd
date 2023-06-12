extends CSGMesh3D

var wind_speed = 10
@onready var player = get_parent().get_parent().get_node("Player")


func _process(delta):
	position.z += wind_speed * delta
	
	if Vector2(0, position.z).distance_squared_to(Vector2(0, player.position.z)) > 500 * 500:
		self.queue_free()
