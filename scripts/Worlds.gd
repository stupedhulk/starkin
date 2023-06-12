extends Control

@onready var buttons = $"world buttons"



func _ready():
	update()

func update():
	for x in buttons.get_children():
		buttons.remove_child(x)
		x.queue_free()
		
	for x in Files.get_worlds():
		var button = Button.new()
		button.text = x
		button.toggle_mode = true
		button.set_script(load("res://scripts/world button.gd"))
		buttons.add_child(button)
