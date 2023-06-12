extends Node3D

@onready var camera = $Camera3D
var sensitivity = 30

func _input(event):
	if event is InputEventMouseMotion and Input.is_action_pressed("update"):
		rotation_degrees.x += -event.relative.y * sensitivity / 100
		rotation_degrees.y += -event.relative.x * sensitivity / 100
		rotation_degrees.x = clamp(rotation_degrees.x, -90, 90)
		if rotation_degrees.y > 180:
			rotation_degrees.y -= 360
		elif rotation_degrees.y < -180:
			rotation_degrees.y += 360


func _process(delta):
	camera.position.z = get_parent().get_node("VSlider").max_value - get_parent().get_node("VSlider").value
	
	if Input.is_action_just_released("hotslot left"): get_parent().get_node("VSlider").value += 1
	if Input.is_action_just_released("hotslot right"): get_parent().get_node("VSlider").value -= 1
	
