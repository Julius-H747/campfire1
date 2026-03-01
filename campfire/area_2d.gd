extends Area2D

@onready var animated_door = $"../Area2D/AnimatedSprite2D"
var on = false
var p1 = false
var p2 = false

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		on = true
		p1 = true
	if body.is_in_group("player2"):
		p2 = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		on = false
		p1 = false
	if body.is_in_group("player2"):
		p2 = false

		
		
func _physics_process(delta: float) -> void:
	if on:
		animated_door.play("door")
	else:
		animated_door.play("no")
	if p1 and p2:
		get_tree().change_scene_to_file("res://ufo.tscn")
