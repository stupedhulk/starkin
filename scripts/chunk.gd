extends CSGMesh3D

var chunks
var player

#func _ready():
#	chunks = get_parent()
#	player = chunks.player
#
#
#func _process(delta):
#	if Generation.get_block_chunk(player.position).distance_squared_to(position/Generation.chunk_size) > (chunks.render_distance * chunks.render_distance):
#		var collision = chunks.get_node_or_null(name + "C")
#		if collision != null:
#			collision.queue_free()
#		self.queue_free()

