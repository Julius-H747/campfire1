extends Area2D

@export var float_amount := 10.0
@export var float_time := 0.9

@onready var sprite: Sprite2D = $Sprite2D
var start_pos: Vector2

func _ready() -> void:
	start_pos = sprite.position

	var t := create_tween()
	t.set_loops() # infinite
	t.set_trans(Tween.TRANS_SINE)
	t.set_ease(Tween.EASE_IN_OUT)

	t.tween_property(sprite, "position", start_pos + Vector2(0, -float_amount), float_time)
	t.tween_property(sprite, "position", start_pos + Vector2(0,  float_amount), float_time)

func _on_body_entered(body: Node) -> void:
	if body.has_method("add_usb"):
		body.add_usb()
		queue_free()
