extends Control
var lines = [
	"ohhh thank you so much big dawg for helping me",
 "yoo no problem glorbus Jr",
 "ight imma head off now outta earth twin",
 "ight have fun twin, get on your spaceship and dont forget me bro",
 "i wont bro, imma leave cya!",
 "Okay Cya! Have fun in Glorbia!!"
]
var line := 0
var turn := false

@export var chars_per_second := 40.0

var is_typing := false
var current_tween: Tween

@onready var m1: RichTextLabel = $man1/RichTextLabel
@onready var m2: RichTextLabel = $man2/RichTextLabel
@onready var ms1: AnimatedSprite2D = $man1/AnimatedSprite2D
@onready var ms2: AnimatedSprite2D = $man2/AnimatedSprite2D
@onready var mh1: TextureRect = $man1/mh1
@onready var mh2: TextureRect = $man2/mh1


func _ready() -> void:
	m1.text = ""
	m2.text = ""
	m1.visible_characters = 0
	m2.visible_characters = 0
	mh1.visible = true
	mh2.visible = true


func type_line(label: RichTextLabel, s: String) -> void:
	# stop any previous typing tween
	if current_tween and current_tween.is_running():
		current_tween.kill()

	label.text = s
	label.visible_characters = 0

	var duration := s.length() / chars_per_second

	is_typing = true
	current_tween = create_tween()
	current_tween.tween_property(label, "visible_characters", s.length(), duration) \
		.set_trans(Tween.TRANS_LINEAR) \
		.set_ease(Tween.EASE_IN_OUT)

	current_tween.finished.connect(func():
		is_typing = false
	)


func finish_typing_now() -> void:
	# instantly reveal the current line if player presses accept mid-type
	if current_tween and current_tween.is_running():
		current_tween.kill()
	# reveal both (only one actually has text at a time in your setup)
	m1.visible_characters = m1.text.length()
	m2.visible_characters = m2.text.length()
	is_typing = false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		# If it's currently typing, pressing accept will instantly finish the line
		if is_typing:
			finish_typing_now()
			return

		if line != len(lines):
			if turn:
				type_line(m2, lines[line])
				ms2.play("default")
				ms1.pause()
				line += 1
				turn = false
				mh1.visible = true
				mh2.visible = false
			else:
				type_line(m1, lines[line])
				ms1.play("default")
				ms2.pause()
				line += 1
				turn = true
				mh1.visible = false
				mh2.visible = true
		else:
			get_tree().change_scene_to_file("res://fnal.tscn")
