extends Control

var items = {
	1 : ["", 1]
}

func _ready():
	seed(8634)

func _physics_process(_delta):
	if randi()%1000 == 0:
		if randi()%3 == 0:
			var rand = randi()%3
			if rand == 0:
				for x in get_child(0).get_children():
					x.glitch = true
			if rand == 1:
				get_child(0).get_children()
			
