extends Control

var flip = 1



func _on_button_pressed():
	print(Files.fix_world_properties(Generation.world_name))
	
	var data = Files.get_world_properties(Generation.world_name)
	
	Generation.world_seed = data["seed"]
	Generation.scale = data["scale"]
	Generation.smooth = data["smooth"]
	Generation.chunk_override = data["chunk override"]
	Generation.override_chunk = data["override chunk"]
	
	get_tree().change_scene_to_file("res://World.tscn")


func _physics_process(_delta):
	$Label.text = "world seed: " + str(Generation.world_seed) + \
			"\nscale: " + str(Generation.scale) + \
			"\nsmooth: " + str(Generation.smooth)
#	if randi()%25 == 10:
#		flip *= -1
#	if scale <= Vector2(1.587, 1.587):
#		flip = 1
#	$Image.rotate(0.01 * flip)
#	$Image.scale += Vector2(0.01*flip, 0.01*flip)


func _string_button_focus_exited():
	pass # Replace with function body.
