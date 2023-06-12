extends Node3D
#---settings---#
@export var music = true
@export var dual_window = false

#---node paths---#
	#-music-#
@onready var music_player = $MusicPlayer
@onready var music_lable = $GUI/Music
	#-sky-#
@onready var world_enviornment = $WorldEnvironment
	#-GUI-#
@onready var credits = $GUI/Credits
@onready var GUI = $GUI
@onready var controlls = $GUI/controlls
var skys = {
	"surface" : preload("res://skys/surface world 1.tres"),
	"below" : preload("res://skys/the below.tres"),
}


#---playlists---#
var unkown_world = [
	"res://music/Mana Two - Part 1.mp3",
	"res://music/Mana Two - Part 2.mp3",
	"res://music/Mana Two - Part 3.mp3",
	"res://music/Water Prelude.mp3",
	"res://music/Mystic Force.mp3",
	"res://music/Comfortable Mystery.mp3"
]
var below = [
	"res://music/Supernatural.mp3",
	"res://music/Air Prelude.mp3"
]


func _ready():
	
	if !Files.check_file_intergrety():
		Files.fix_files()
	
	print(Files.get_worlds())
	
	#RenderingServer.set_debug_generate_wireframes(true)
	#get_viewport().debug_draw = Viewport.DEBUG_DRAW_WIREFRAME
	
	get_viewport().set_embedding_subwindows(false)
	if dual_window: add_child(load("res://side_view.tscn").instantiate())



func _process(_delta):
	music_handler()
	sky_handler()
	#---window handler---#
	if Input.is_action_just_pressed("fullscreen"):
		get_window().mode = Window.MODE_FULLSCREEN
	
	
	if Input.is_action_just_pressed("credits"):
		credits.visible = !credits.visible
	
	if Input.is_action_just_pressed("GUI"):
		GUI.visible = !GUI.visible
		$Player/Info.visible = GUI.visible




func music_handler():
	if !music_player.playing and music:
		var song_choice = Time.get_datetime_dict_from_system()["minute"] + Time.get_datetime_dict_from_system()["second"] \
				+ Time.get_datetime_dict_from_system()["year"] + Time.get_datetime_dict_from_system()["month"] \
				+ Time.get_datetime_dict_from_system()["day"]
		
		var playlist
		if Generation.get_block_chunk($Player.position).y < 10:
			playlist = below
		else:
			playlist = unkown_world
		
		var song_path = playlist[song_choice%playlist.size()]
		music_player.stream = load(song_path)
		music_player.play()
		music_lable.text = "playing: " + get_music_name(song_path)


func get_music_name(path): #path must be in the music folder
	path = path.replace("res://music/", "")
	return path.replace(".mp3", "")



func sky_handler():
	if $Player.position.y < 416:
		world_enviornment.environment.background_sky = skys["below"]
	else:
		world_enviornment.environment.background_sky = skys["surface"]

