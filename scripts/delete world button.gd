extends Node





func _pressed():
	Files.delete_world(get_parent().text)
	get_parent().get_parent().get_parent().update()
