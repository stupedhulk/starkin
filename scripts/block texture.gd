extends CSGBox3D


func _ready():
	material = get_material().duplicate()
	material.albedo_color = Color((randi()%100)/100.0,(randi()%100)/100.0,(randi()%100)/100.0,1)
	print(material.albedo_color)
