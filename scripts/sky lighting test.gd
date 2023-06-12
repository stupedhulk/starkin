extends Node3D


func _process(delta):
	global_position = get_parent().get_node("Camera Orbit Point").get_node("Camera3D").global_position


func _on_sun_angle_value_changed(value, dragging):
	$Sun.rotation_degrees.x = 360 - value
