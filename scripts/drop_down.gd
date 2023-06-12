@tool
extends Control

@onready var label = $Label
@onready var button = $OptionButton

@export var text = ""
@export var items = ["default"]
@export var selection = 0
@export var minimal_distance = 0
@export var maximum_distnace = 100
@export var spacing = 10
@export var dropdown_length = 246

signal changed

func _ready():
	update_items()

func _process(delta):
	label.text = text
	update_items()
	
	button.size.x = dropdown_length
	button.position.x = clamp(label.size.x + label.position.x + spacing, minimal_distance, maximum_distnace)
	size.x = button.position.x + button.size.x

func update_items():
	for x in range(button.item_count):
		button.remove_item(0)
	for x in items:
		button.add_item(str(x))
	button.selected = selection

func _on_option_button_item_selected(index):
	emit_signal("changed", items[index])
	selection = index
