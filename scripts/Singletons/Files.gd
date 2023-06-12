extends Node

const file_setup = {
	"worlds" : "dir",
	"settings.txt" : "file"
	}

const default_world_properties = {
	"seed": 279.0,
	"scale": 1000.0,
	"smooth": 50.0,
	"override chunk": false,
	"chunk override": ["starkin"]
	}

var file_threads = []



func fix_files():
	
	for x in file_setup.keys():
		if file_setup[x] == "dir":
			if !DirAccess.dir_exists_absolute("user://" + x):
				DirAccess.make_dir_absolute("user://" + x)
		if file_setup[x] == "file":
			if !FileAccess.file_exists("user://" + x):
				var file = FileAccess.open("user://" + x, FileAccess.WRITE)
				file.store_string("")
				file.close()




func check_file_intergrety():
	var valid = true
	for x in file_setup.keys():
		if file_setup[x] == "dir":
			if !DirAccess.dir_exists_absolute("user://" + x):
				valid = false
		if file_setup[x] == "file":
			if !FileAccess.file_exists("user://" + x):
				valid = false
	return valid


func save_chunk_to_file(chunk_pos, chunk_data):
	var chunk = str(Generation.encode_chunk(chunk_data))
	var file = FileAccess.open("user://worlds/" + Generation.world_name + "/chunkdata/" + str(chunk_pos), FileAccess.WRITE)
	file.store_string(chunk)
	file.close()


func load_chunk_from_file(chunk_pos):
	if FileAccess.file_exists("user://worlds/" + Generation.world_name + "/chunkdata/" + str(chunk_pos)):
		var file = FileAccess.open("user://worlds/" + Generation.world_name + "/chunkdata/" + str(chunk_pos), FileAccess.READ)
		var chunk_data = file.get_as_text()
		chunk_data.replace("<", "")
		chunk_data.replace(">", "")
		chunk_data = JSON.parse_string(chunk_data)
		var output = {}
		output = Generation.decode_chunk(chunk_data)
		return output
	else: return null


func create_world(world_name, properties):
	while DirAccess.dir_exists_absolute("user://worlds/" + world_name):
		world_name = world_name+"-"
		print(world_name)
	
	DirAccess.make_dir_absolute("user://worlds/" + world_name)
	DirAccess.make_dir_absolute("user://worlds/" + world_name + "/chunkdata")
	var file = FileAccess.open("user://worlds/" + world_name + "/properties", FileAccess.WRITE)
	file.store_string(str(properties))



func delete_world(world_name):
	var path = "user://worlds/" + world_name
	print("deleting: " + world_name)
	
	if FileAccess.file_exists(path + "/properties"):
		DirAccess.remove_absolute(path + "/properties")
	print("properties deleted: " + str(!FileAccess.file_exists(path + "/properties")))
	
	if FileAccess.file_exists(path + "/player properties.txt"):
		DirAccess.remove_absolute(path + "/player properties.txt")
	print("player properties deleted: " + str(!FileAccess.file_exists(path + "/player properties.txt")))
	
	for x in DirAccess.get_files_at(path + "/chunkdata"):
		DirAccess.remove_absolute(path + "/chunkdata/" + x)
	DirAccess.remove_absolute(path + "/chunkdata")
	print("chunkdata deleted: " + str(!FileAccess.file_exists(path + "/chunkdata")))
	
	if DirAccess.dir_exists_absolute(path):
		DirAccess.remove_absolute("user://worlds/" + world_name)
	print("world deleted:" + str(!DirAccess.dir_exists_absolute(path)))
	



func get_world_properties(world_name):
	var file = FileAccess.open("user://worlds/" + world_name + "/properties", FileAccess.READ)
	var info = file.get_as_text()
	file.close()
	var properties = JSON.parse_string(info)
	
	return properties


func check_world_properties(world_name):
	var info = get_world_properties(world_name)
	print(info)
	
	if info == null or typeof(info) != TYPE_DICTIONARY:
		return [null]
	
	var bad_settings = []
	for x in default_world_properties.keys():
		if not (x in info.keys() and typeof(info[x]) == typeof(default_world_properties[x])):
			bad_settings.append(x)
	return bad_settings


func fix_world_properties(world_name):
	var bad_settings = check_world_properties(world_name)
	var info = get_world_properties(world_name)
	if bad_settings.size() != 0:
		if bad_settings[0] == null:
			info = default_world_properties
		else: for x in bad_settings:
			info[x] = default_world_properties[x]
	
	var file = FileAccess.open("user://worlds/" + world_name + "/properties", FileAccess.WRITE)
	file.store_string(str(info))
	file.close()
	
	info = get_world_properties(world_name)
	return bad_settings.size() == 0
	
	return true
	

func get_worlds():
	var dir = DirAccess.open("user://worlds")
	dir.list_dir_begin()
	var dir_names = []
	var dir_name = dir.get_next()
	while dir_name != "":
		dir_names.append(dir_name)
		dir_name = dir.get_next()
	return dir_names
