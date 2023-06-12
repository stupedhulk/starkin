extends Button

@onready var player = get_parent().get_parent().get_parent().get_parent()

func _pressed():
	player.position = Vector3(int(get_parent().get_node("X Input").text), int(get_parent().get_node("Y Input").text), int(get_parent().get_node("Z Input").text))
