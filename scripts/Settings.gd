extends Control

@onready var Name = $Name
@onready var Seed = $Seed
@onready var Scale = $Scale
@onready var Smooth = $Smooth
@onready var override_chunk = $"Override Chunk"
@onready var generation_type = $"Generation Type"

@onready var int_buttons = [
	Seed,
	Scale,
	Smooth
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass




func _on_apply_pressed():
	
	
	Generation.world_seed = float(Seed.text)
	Generation.scale = float(Scale.text)
	Generation.smooth = float(Smooth.text)
	Generation.override_chunk = override_chunk.button_pressed
	Generation.chunk_override = [generation_type.items[generation_type.selection]]
	
	Files.create_world(Name.text,
	{
		"seed" : int(Seed.text),
		"scale" : int(Scale.text),
		"smooth" : int(Smooth.text),
		"override chunk" : override_chunk.button_pressed,
		"chunk override" : [generation_type.items[generation_type.selection]]
	})


func set_float(callable):
	if callable.text != "":
		if not "0" in callable.text:
			callable.text = str(float(callable.text))
			if callable.text == "0":
				callable.text = ""
		else:
			callable.text = str(float(callable.text))




func _int_button_focus_exited():
	for x in int_buttons:
		set_float(x)
