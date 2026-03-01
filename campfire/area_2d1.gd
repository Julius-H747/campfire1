extends Area2D

@onready var animated_door = $"../Area2D/AnimatedSprite2D"
var on = false

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		on = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		on = false

func _physics_process(delta: float) -> void:
	if on:
		animated_door.play("door")
	else:
		animated_door.play("no")
