extends Area2D

var p1 = false
var p2 = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if p1 and p2:
		get_tree().change_scene_to_file("res://the real Cave lvl 4.tscn")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		p1 = true
		print(p1)
	if body.is_in_group("player2"):
		p2 = true
		print(p2)
		


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		p1 = false
	if body.is_in_group("player2"):
		p2 = false
