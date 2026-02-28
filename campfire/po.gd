extends TileMapLayer

var og_y

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	og_y = position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func put(p):
	position.y += p

func r():
	global_position.y = og_y
