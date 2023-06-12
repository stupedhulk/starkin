extends Control


@onready var text = get_child(0)
@onready var value = get_child(1)
@onready var slider = get_child(2)

@export var label = ""
@export var value_display_begining = ""
@export var value_display_end= ""

@export var min_value = 0
@export var max_value = 0
@export var step = 1
@export var default_value = 0

signal value_changed
signal drag_ended

var dragging = false

func _ready():
	set_values(min_value, max_value)
	slider.step = step
	slider.value = default_value
	text.text = label

func set_values(min, max):
	max_value = max
	min_value = min
	slider.max_value = max
	slider.min_value = min

func get_value():
	return slider.value

func _physics_process(delta):
	value.text = value_display_begining + str(slider.value) + value_display_end


func _on_slider_value_changed(value):
	emit_signal("value_changed", value, dragging)


func _on_slider_drag_ended(value_changed):
	emit_signal("drag_ended", slider.value)
	dragging = false


func _on_h_slider_drag_started():
	dragging = true
