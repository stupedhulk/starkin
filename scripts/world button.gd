extends Button

@onready var play_button = get_parent().get_parent().get_parent().get_node("Button")
var delete_world_button



func _ready():
	var new = Button.new()
	new.name = "delete"
	new.text = "delete world"
	new.position.x = -109
	new.set_script(load("res://scripts/delete world button.gd"))
	add_child(new)
	delete_world_button = get_node("delete")


func _pressed():
	Generation.world_name = text
	
	for x in get_parent().get_children():
		if x.text != text:
			x.button_pressed = false
	play_button.disabled = !button_pressed

func _process(delta):
	
	delete_world_button.visible = button_pressed
