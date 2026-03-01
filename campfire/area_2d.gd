extends Area2D

@onready var animated_door = $"../Area2D/AnimatedSprite2D"

func _on_body_entered(body: CharacterBody2D) -> void:
	animated_door.play("door")
