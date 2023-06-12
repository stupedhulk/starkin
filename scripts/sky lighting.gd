extends Node3D


func _ready():
	for x in get_children():
		if x.name != "Sun":
			x.queue_free()
	
	var rotateion = 0
	while rotateion <= 90:
		rotateion += 10
		var light = DirectionalLight3D.new()
		light.rotation_degrees.y = rotateion
		light.name = str(light.rotation_degrees.y)
		add_child(light)
