extends TileMapLayer

var og
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	og = position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func push(p):
	global_position.y += p

func reset():
	global_position.y = og
