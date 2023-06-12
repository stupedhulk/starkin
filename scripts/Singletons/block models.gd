@tool
extends Node


const TEXTURES = {
	#----Stone----#
	'stone_top'    : Vector2(16,1),
	'stone_bottom' : Vector2(16,3),
	'stone_side_1' : Vector2(13,1),
	'stone_side_2' : Vector2(14,1),
	'stone_side_3' : Vector2(15,1),
	'stone_side_4' : Vector2(13,2),
	'stone_side_5' : Vector2(15,2),
	'stone_side_6' : Vector2(13,3),
	'stone_side_7' : Vector2(14,3),
	'stone_side_8' : Vector2(15,3),
	#----Grass----#
	'grass_top'    : Vector2(8,1),
	'grass_bottom' : Vector2(8,3),
	'grass_side_1' : Vector2(5,1),
	'grass_side_2' : Vector2(6,1),
	'grass_side_3' : Vector2(7,1),
	'grass_side_4' : Vector2(5,2),
	'grass_side_5' : Vector2(7,2),
	'grass_side_6' : Vector2(5,3),
	'grass_side_7' : Vector2(6,3),
	'grass_side_8' : Vector2(7,3),
	#----Dirt----#
	'dirt_top'    : Vector2(12,1),
	'dirt_bottom' : Vector2(12,3),
	'dirt_side_1' :  Vector2(9,1),
	'dirt_side_2' : Vector2(10,1),
	'dirt_side_3' : Vector2(11,1),
	'dirt_side_4' :  Vector2(9,2),
	'dirt_side_5' : Vector2(11,2),
	'dirt_side_6' :  Vector2(9,3),
	'dirt_side_7' : Vector2(10,3),
	'dirt_side_8' : Vector2(11,3),
	#----Cobblestone----#
	'cobblestone_top'    : Vector2(20,1),
	'cobblestone_bottom' : Vector2(20,3),
	'cobblestone_side_1' :  Vector2(17,1),
	'cobblestone_side_2' : Vector2(18,1),
	'cobblestone_side_3' : Vector2(19,1),
	'cobblestone_side_4' :  Vector2(17,2),
	'cobblestone_side_5' : Vector2(19,2),
	'cobblestone_side_6' :  Vector2(17,3),
	'cobblestone_side_7' : Vector2(18,3),
	'cobblestone_side_8' : Vector2(19,3),
	#----Cloud----#
	"cloud_top" : Vector2(2,4),
	"cloud_bottom" : Vector2(2,4),
	"cloud_side_1" : Vector2(2,4),
	"cloud_side_2" : Vector2(2,4),
	"cloud_side_3" : Vector2(2,4),
	"cloud_side_4" : Vector2(2,4),
	"cloud_side_5" : Vector2(2,4),
	"cloud_side_6" : Vector2(2,4),
	"cloud_side_7" : Vector2(2,4),
	"cloud_side_8" : Vector2(2,4),
	#----Test----#
	"test_top" : Vector2(1,4),
	"test_bottom" : Vector2(1,4),
	"test_side_1" : Vector2(1,4),
	"test_side_2" : Vector2(1,4),
	"test_side_3" : Vector2(1,4),
	"test_side_4" : Vector2(1,4),
	"test_side_5" : Vector2(1,4),
	"test_side_6" : Vector2(1,4),
	"test_side_7" : Vector2(1,4),
	"test_side_8" : Vector2(1    ,4),
}

const MODELS = {
	"dirt" : {
		"top"    : [[Vector3(0,0,0), Vector3(0,0,0), Vector3(0,0,0), Vector3(0,0,0)], [TEXTURES["dirt_top"]]],
		
		"bottom" : [[Vector3(0,0,0)], [TEXTURES["dirt_bottom"]]],
		
		"front"  : [[Vector3(0,0,0)], [\
		TEXTURES["dirt_side_1"], TEXTURES["dirt_side_2"], TEXTURES["dirt_side_3"], \
		TEXTURES["dirt_side_4"], TEXTURES["dirt_side_5"], TEXTURES["dirt_side_6"], \
		TEXTURES["dirt_side_7"], TEXTURES["dirt_side_8"]]],
		
		"back"   : [[Vector3(0,0,0)], [\
		TEXTURES["dirt_side_1"], TEXTURES["dirt_side_2"], TEXTURES["dirt_side_3"], \
		TEXTURES["dirt_side_4"], TEXTURES["dirt_side_5"], TEXTURES["dirt_side_6"], \
		TEXTURES["dirt_side_7"], TEXTURES["dirt_side_8"]]],
		
		"left"   : [[Vector3(0,0,0)], [\
		TEXTURES["dirt_side_1"], TEXTURES["dirt_side_2"], TEXTURES["dirt_side_3"], \
		TEXTURES["dirt_side_4"], TEXTURES["dirt_side_5"], TEXTURES["dirt_side_6"], \
		TEXTURES["dirt_side_7"], TEXTURES["dirt_side_8"]]],
		
		"right"  : [[Vector3(0,0,0)], [\
		TEXTURES["dirt_side_1"], TEXTURES["dirt_side_2"], TEXTURES["dirt_side_3"], \
		TEXTURES["dirt_side_4"], TEXTURES["dirt_side_5"], TEXTURES["dirt_side_6"], \
		TEXTURES["dirt_side_7"], TEXTURES["dirt_side_8"]]],
	}
}

const INFO = {
	"dirt" : {
		"cullable_faces" : ["top", "bottom", "front", "back", "left", "right"],
		"faces" : ["top", "bottom", "front", "back", "left", "right"]
	},
	"grass" : {
		"cullable_faces" : ["top", "bottom", "front", "back", "left", "right"],
		"faces" : ["top", "bottom", "front", "back", "left", "right"]
	},
	"stone" : {
		"cullable_faces" : ["top", "bottom", "front", "back", "left", "right"],
		"faces" : ["top", "bottom", "front", "back", "left", "right"]
	},
	"cobblestone" : {
		"cullable_faces" : ["top", "bottom", "front", "back", "left", "right"],
		"faces" : ["top", "bottom", "front", "back", "left", "right"]
	},
	"279" : {
		"cullable_faces" : ["top", "bottom", "front", "back", "left", "right"],
		"faces" : ["top", "bottom", "front", "back", "left", "right"]
	},
	"test" : {
		"cullable_faces" : ["top", "bottom", "front", "back", "left", "right"],
		"faces" : ["top", "bottom", "front", "back", "left", "right"]
	},
}
