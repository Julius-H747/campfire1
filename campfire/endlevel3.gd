extends Area2D

var p1 = false
var p2 = false

func _process(delta: float) -> void:
	if p1 and p2:
		get_tree().change_scene_to_file("res://Cave LVl 3.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("p1")
		p1 = true
	if body.is_in_group("player2"):
		print(p2)
		p2 = true
