extends CharacterBody3D

var input = Vector2(0,0)
var move = Vector3(0,0,0)
var speed = 3000

@onready var Left_controller = $FPController/LeftHandController


func _physics_process(delta):
	#---View---#
	Left_controller.rotation_degrees.y += (Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")) * 2
	
	#---Move Input---#
	input.x = Input.get_action_strength("backward") - Input.get_action_strength("foreward")
	input.y = Input.get_action_strength("right") - Input.get_action_strength("left")
	move.y = Input.get_action_strength("up") - Input.get_action_strength("down")
	
	#---input to move---#
	move.z = ((cos(deg_to_rad(Left_controller.rotation_degrees.y)) * input.x) + (sin(-deg_to_rad(Left_controller.rotation_degrees.y)) * input.y)) * speed * delta
	move.x = ((sin(deg_to_rad(Left_controller.rotation_degrees.y)) * input.x) + (cos(-deg_to_rad(Left_controller.rotation_degrees.y)) * input.y)) * speed * delta
	move.y *= speed * delta
	
	
	
	set_velocity(move)
	move_and_slide()
	var _m = velocity
