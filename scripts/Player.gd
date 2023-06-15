extends CharacterBody3D

#---physics---#
var input = Vector2(0,0)
var rotated_input = Vector2(0,0)
var move = Vector3(0,0,0)
var speed = 450
var max_speed = 5
#var velocity = Vector3(0,0,0)
var acceleration = Vector3(0,0,0)
var control_acceleration = Vector3(0,0,0)
var floor_resistance = Vector3(0.5, 0.5, 0.5)
var air_resistance = Vector3(0.1, 0.001, 0.1)
var sensitivity = 30
var flying = false

#---items---#
var hotslot = 0
var hotbar = [
	"dirt",
	"grass",
	"stone",
	"cobblestone",
	null,
	null,
	null,
	null,
	null
]

#---temp---#
var pressed = false

#---node stuff---#
@onready var chunks = get_parent().get_node("chunks")
@onready var loading_chunks_label = $"Loading Chunks"
@onready var info_label = $"Info"
@onready var camera = $Camera3D
@onready var ray = $Camera3D/RayCast3D
@onready var left_hand = $XROrigin3D/LeftHand
@onready var right_hand = $XROrigin3D/RightHand
@onready var menu = $Menu
@onready var double_jump_timer = $"double jump"

#---internal---#
var vr = false
var inventory_open = false
var menu_open = false
var block_break_pos = Vector3(0,0,0)
var block_place_pos = Vector3(0,0,0)
var block_highlight_visible = true
var interface: XRInterface
var pressed_actions = []

#---debug---#
@export var ignore_chunks = false

#vr controlls here https://github.com/GodotVR/godot_openvr/issues/4
func _input(event):
	if event is InputEventMouseMotion and !inventory_open and !menu_open:
		camera.rotation_degrees.x += -event.relative.y * sensitivity / 100
		camera.rotation_degrees.y += -event.relative.x * sensitivity / 100
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)
		if camera.rotation_degrees.y > 180:
			camera.rotation_degrees.y -= 360
		elif camera.rotation_degrees.y < -180:
			camera.rotation_degrees.y += 360
	


func _ready():
	
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	interface = XRServer.find_interface("OpenXR")
	if interface and interface.is_initialized():
		print("OpenXR initialised successfully")

		# Turn off v-sync!
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

		# Change our main viewport to output to the HMD
		get_viewport().use_xr = true
		
		vr = true
		
		
	else:
		print("OpenXR not initialised, please check if your headset is connected")
	
	
	
	if vr:
		ray = right_hand.get_node("RayCast3D")
		loading_chunks_label.visible = false
		info_label.visible = false
		$Hotbar.visible = false
		$Camera3D/ColorRect.visible = false
		
		if chunks != null:
			var parent = get_parent()
			parent.get_node("GUI").visible = false
	
	else:
		$XROrigin3D.visible = false

func _physics_process(delta):
#	var distance = max(position.x, position.z)
#	var material = camera.get_node("CSGBox3D").get_material()
#	material.albedo_color = Color8(0, 0, 0, int(clamp(sin(((distance-15000)/200)*(PI/2)), 0, 1)*255))
	
	
	
	var file = FileAccess.open("user://worlds/" + Generation.world_name + "/player properties.txt", FileAccess.WRITE)
	file.store_string(str({
		"player position" : position
	}))
	
	
	
	
	
	
	#print("first_click" + str(is_button_just_pressed(right_hand, "trigger_click")))
	
	
	#---Controlls---#
	if Input.is_action_just_pressed("Flashlight"):
		print("flashlight toggle")
		$"Camera3D/Flash light".visible = !$"Camera3D/Flash light".visible
	
	if Input.is_action_just_pressed("ui_cancel") and !inventory_open and !menu_open:
		menu.visible = true
		menu_open = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif Input.is_action_just_pressed("ui_cancel") and menu_open:
		menu.visible = false
		menu_open = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if Input.is_action_just_pressed("Inventory") and !get_node("Inventory").visible and !menu_open:
		inventory_open = true
		get_node("Inventory").visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	elif (Input.is_action_just_pressed("ui_cancel")
			or Input.is_action_just_pressed("Inventory")) \
			and get_node("Inventory").visible:
		inventory_open = false
		get_node("Inventory").visible = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if Input.is_action_just_pressed("Block placement"):
		block_highlight_visible = !block_highlight_visible
	
	if Input.is_action_just_released("hotslot right"):
		hotslot += 1
		if hotslot > hotbar.size()-1: hotslot -= hotbar.size() 
		print(hotslot)
	if Input.is_action_just_released("hotslot left"):
		hotslot -= 1
		if hotslot < 0: hotslot += hotbar.size() 
	
	#---movement---#
	if chunks != null:
		if (chunks.get_node_or_null(str(Generation.get_block_chunk(position))) 
				and chunks.get_node_or_null(str(Generation.get_block_chunk(position) + Vector3(1,-1, 0)))
				and chunks.get_node_or_null(str(Generation.get_block_chunk(position) + Vector3(0,-1, 0)))
				and chunks.get_node_or_null(str(Generation.get_block_chunk(position) + Vector3(-1,-1,0)))
				and chunks.get_node_or_null(str(Generation.get_block_chunk(position) + Vector3(1, 0, 0)))
				and chunks.get_node_or_null(str(Generation.get_block_chunk(position) + Vector3(-1,0, 0)))
				and chunks.get_node_or_null(str(Generation.get_block_chunk(position) + Vector3(1, 1, 0)))
				and chunks.get_node_or_null(str(Generation.get_block_chunk(position) + Vector3(0, 1, 0)))
				and chunks.get_node_or_null(str(Generation.get_block_chunk(position) + Vector3(-1,1,0)))) \
				or ignore_chunks:
			loading_chunks_label.visible = false
			move_physics(delta)
		else: 
			loading_chunks_label.visible = true
			
	else: move_physics(delta)
	
	#---dev controlls---#
	if Input.is_key_pressed(KEY_F1) and !pressed:
		pressed = true
		$CollisionShape3D.disabled = !$CollisionShape3D.disabled
	elif !Input.is_key_pressed(KEY_F1) and pressed:
		pressed = false
		
	if Input.is_action_just_pressed("update"):
		#chunks.clear_chunks()
		chunks.update(Generation.get_block_chunk(position))
	
	#---internal---#
	$MeshInstance3D.visible = vr
	
	for x in get_node("Hotbar/GridContainer").get_children():
		if int(str(x.name)) -1 == hotslot:
			x.get_node("ColorRect").visible = false
		else: 
			x.get_node("ColorRect").visible = true
	
	
	#---ui---#
	if chunks != null:
		info_label.text  =  "FPS: " + str(Engine.get_frames_per_second()) + "\n" +\
							"position: " + str(Main.round_vector(position, Main.ROUND)) + "\n" +\
							"velocity: " + str(Main.round_vector(velocity, Main.ROUND)) + "\n" +\
							"acceleration: " + str(Main.round_vector(acceleration, Main.ROUND)) + "\n" +\
							"controll acceleration: " + str(Main.round_vector(control_acceleration, Main.ROUND)) + "\n" +\
							"input: " + str(Main.round_vector(input, Main.ROUND)) + "\n" +\
							"rotated input: " + str(rotated_input) + "\n" +\
							"chunk position: " + str(Generation.get_block_chunk(position)) + "\n" +\
							"RAM: " + str(OS. get_static_memory_usage()/1e9)
	
	
	#---block stuff---#
	if ray.is_colliding():
		$"block".visible = block_highlight_visible
		$"block side".visible = block_highlight_visible
		
		
		if int(ray.get_collision_point().y*2000)%1000 == 0:
			if camera.rotation.x > 0:
				block_place_pos = Vector3(round(ray.get_collision_point().x), ray.get_collision_point().y-0.5, round(ray.get_collision_point().z))
				block_break_pos = Vector3(round(ray.get_collision_point().x), ray.get_collision_point().y+0.5, round(ray.get_collision_point().z))
			else:
				block_place_pos = Vector3(round(ray.get_collision_point().x), ray.get_collision_point().y+0.5, round(ray.get_collision_point().z))
				block_break_pos = Vector3(round(ray.get_collision_point().x), ray.get_collision_point().y-0.5, round(ray.get_collision_point().z))
		elif int(ray.get_collision_point().x*2000)%1000 == 0:
			if camera.rotation.y < 0:
				block_place_pos = Vector3(ray.get_collision_point().x-0.5, round(ray.get_collision_point().y), round(ray.get_collision_point().z))
				block_break_pos = Vector3(ray.get_collision_point().x+0.5, round(ray.get_collision_point().y), round(ray.get_collision_point().z))
			else:
				block_place_pos = Vector3(ray.get_collision_point().x+0.5, round(ray.get_collision_point().y), round(ray.get_collision_point().z))
				block_break_pos = Vector3(ray.get_collision_point().x-0.5, round(ray.get_collision_point().y), round(ray.get_collision_point().z))
		elif int(ray.get_collision_point().z*2000)%1000 == 0:
			if camera.rotation.y > -PI/2 and camera.rotation.y < PI/2:
				block_place_pos = Vector3(round(ray.get_collision_point().x), round(ray.get_collision_point().y), ray.get_collision_point().z+0.5)
				block_break_pos = Vector3(round(ray.get_collision_point().x), round(ray.get_collision_point().y), ray.get_collision_point().z-0.5)
			else:
				block_place_pos = Vector3(round(ray.get_collision_point().x), round(ray.get_collision_point().y), ray.get_collision_point().z-0.5)
				block_break_pos = Vector3(round(ray.get_collision_point().x), round(ray.get_collision_point().y), ray.get_collision_point().z+0.5)
		
		
		
		$"block".global_position = block_break_pos
		$"block side".global_position = block_place_pos
		
		
		if Input.is_action_just_pressed("place") or is_button_just_pressed(right_hand, "trigger_click"):
			chunks.place_block(block_place_pos, hotbar[hotslot])

		if Input.is_action_just_pressed("break") or is_button_just_pressed(left_hand, "trigger_click"):
			chunks.place_block(block_break_pos, null)
	else:
		$"block".visible = false
		$"block side".visible = false


func move_physics(delta):
	
	if OS.get_name() != 'Android':
		#reset acceleration
		acceleration = Vector3(0,0,0)
		#---Move Input---#
		
		input = Input.get_vector("forward", "backward", "left", "right")
		#velocity.y = Input.get_action_strength("up") - Input.get_action_strength("down")
		if vr:
			input = left_hand.get_vector2("primary")
		
		#---input to move---#
		
		rotated_input = input.normalized().rotated(camera.rotation.y)
		
		if vr:
			rotated_input = input.normalized().rotated($XROrigin3D/XRCamera3D.rotation.y + PI/2)
		
		var speed_multiplier = 1
		if flying:
			speed_multiplier = 1.5
		
		if is_on_floor() or flying:
			control_acceleration.z = rotated_input.x * speed * speed_multiplier * delta * floor_resistance.z
			control_acceleration.x = rotated_input.y * speed * speed_multiplier * delta * floor_resistance.x
		else:
			control_acceleration.z = rotated_input.x * speed * delta * air_resistance.z
			control_acceleration.x = rotated_input.y * speed * delta * air_resistance.x

		acceleration += control_acceleration

		#---gravity---#
		if (Input.is_action_just_pressed("jump") or is_button_just_pressed(right_hand, "ax_button")) and double_jump_timer.is_stopped():
			double_jump_timer.start()
		elif Input.is_action_just_pressed("jump") or is_button_just_pressed(right_hand, "ax_button"):
			flying = !flying
		
		if (Input.is_action_pressed("jump") or right_hand.is_button_pressed("ax_button")) and is_on_floor() and !flying:
			if velocity.y <0: velocity.y = 0
			acceleration.y += 8
		
		if flying:
			velocity.y = lerp(velocity.y, (Input.get_action_strength("jump") - Input.get_action_strength("fly down")) * 3000 * delta, 0.1)
		
		if !flying:
			acceleration.y += -24 * delta
		
		
	#if vr: position = get_parent().get_node('VR').position
	
	set_velocity(velocity + acceleration + Vector3(0,0.0000001,0))
	set_up_direction(Vector3.UP)
	move_and_slide()
	velocity = velocity
	
	#resistance
	if is_on_floor() or flying:
		velocity = lerp(velocity, Vector3.ZERO, floor_resistance.x)
	else:
		velocity.x = lerp(velocity.x, 0.0, air_resistance.x)
		velocity.y = lerp(velocity.y, 0.0, air_resistance.y)
		velocity.z = lerp(velocity.z, 0.0, air_resistance.z)


func _on_FPController_initialised():
	vr = true
	get_node("CollisionShape3D").visible = false

func is_button_just_pressed(node, action):
	
#	print(pressed_actions)
#	print(action in pressed_actions)
#	print(action)
	
	if node.is_button_pressed(action) and not action in pressed_actions:
		pressed_actions.append(action)
		return true
		
	elif !node.is_button_pressed(action) and action in pressed_actions:
		pressed_actions.erase(action)
		return false
	
	return false
