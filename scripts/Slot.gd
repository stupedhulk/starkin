extends Panel

var glitch = false
var prev_frame = 0 #0-12 for non glitch #13-15 for glitch
var current_frame = 0
var timer
var item_texture
const GLITCH_CHANCE = 1000 #higher value = less likely
const ANIMATION_SPEED = 0.1

func _ready():
	#seed setup
	seed(int(str(name)))
	#print(randi())
	
	#texture setup
	var stylebox = load("res://assets/slot stylebox.tres")
	stylebox = stylebox.duplicate()
	stylebox.texture = stylebox.texture.duplicate()
	add_theme_stylebox_override("panel", stylebox)
	
	#item display setup
	if not get_parent().get_parent().name == "Hotbar":
		item_texture = TextureRect.new()
		item_texture.name = "item"
		item_texture.size = Vector2(25, 25)
		item_texture.position = Vector2(7.5,7.5)
		item_texture.texture = AtlasTexture.new()
		item_texture.texture.atlas = load("res://Textures/blocks.png")
		item_texture.texture.region = Rect2(12*16, 0, 16, 16)
		add_child(item_texture)
		item_texture = get_node("item")
	
	#timer setup
	var new = Timer.new()
	new.name = "Timer"
	new.wait_time = ANIMATION_SPEED
	new.autostart = true
	add_child(new)
	timer = get_node("Timer")
	timer.timeout.connect(randomize_texture)
	

func randomize_texture():
	if name == "Panel" or name == "Panel2" or true:
		if randi()%GLITCH_CHANCE == 0 or Input.is_action_just_pressed("ui_accept"):
			glitch = true
		if glitch and prev_frame != 15:
			if prev_frame < 13:
				current_frame = 13
			else:
				current_frame += 1
		elif prev_frame == 15:
			glitch = false
			current_frame = 0
		else:
			current_frame = randi()%12
			while current_frame == prev_frame:
				current_frame = randi()%12
		prev_frame = current_frame
		var stylebox = get_theme_stylebox("panel", "")
		var texture = stylebox.texture
		texture.region = Rect2(current_frame*20, 0, 20, 20)
		stylebox.texture = texture
		add_theme_stylebox_override("panel", stylebox)
	
