extends CharacterBody2D

const SPEED := 300.0
const JAMOUNT := 2
const DAMOUNT := 1

var JUMP_VELOCITY := -600.0

@export var dash_speed := 800.0
@export var dash_time := 0.2
@export var friction := 1200.0   # for decel (feel free to tweak)
@export var gravity := 1200.0    # if you want your own gravity value

@onready var asprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera: Camera2D = $Camera2D

var is_dashing := false
var dash_timer := 0.0
var dash_direction := 1.0

var jumps := 0
var dashes := 0
var og_scale: Vector2

func _ready() -> void:
	camera.zoom = Vector2(1, 1)
	og_scale = scale
	jumps = JAMOUNT
	dashes = DAMOUNT

func _physics_process(delta: float) -> void:
	# Gravity + reset jump/dash when grounded
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		jumps = JAMOUNT
		dashes = DAMOUNT
		JUMP_VELOCITY = -600.0

	# Jump
	if Input.is_action_just_pressed("up") and jumps > 0:
		jump()

	var direction := Input.get_axis("left", "right")

	leftright(direction, delta)

	# Flip sprite based on movement
	if velocity.x < 0:
		asprite.scale.x = -2
	elif velocity.x > 0:
		asprite.scale.x = 2

	# Dash movement override
	if is_dashing:
		velocity.x = dash_direction * dash_speed
		velocity.y = 0
		dash_timer -= delta
		if dash_timer <= 0.0:
			is_dashing = false
			scale = og_scale
	animate()
	check_cam()
	move_and_slide()

func leftright(d: float, delta: float) -> void:
	if d != 0.0:
		velocity.x = d * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0.0, friction * delta)

	# Dash (make sure "n" exists in InputMap)
	if Input.is_action_just_pressed("n") and not is_on_floor() and dashes > 0 and not is_dashing:
		is_dashing = true
		dash_timer = dash_time
		dashes -= 1

		# Use movement direction if moving, otherwise use facing from sprite flip
		if abs(velocity.x) > 1.0:
			dash_direction = sign(velocity.x)
		else:
			dash_direction = sign(asprite.scale.x)  # -1 or +1 only

		scale = og_scale - Vector2(0.2, 0.2)

func check_cam() -> void:
	if camera.limit_right <= position.x:
		camera.limit_right += 1000
		camera.limit_left += 1000
	if camera.limit_left >= position.x:
		camera.limit_left -= 1000
		camera.limit_right -= 1000
	if camera.limit_bottom <= position.y:
		camera.limit_bottom += 640
		camera.limit_top += 640
	if camera.limit_top >= position.y:
		camera.limit_top -= 640
		camera.limit_bottom -= 640

func animate() -> void:
	if is_dashing:
		asprite.play("dash")
		return

	if is_on_floor():
		if abs(velocity.x) > 0.1:
			asprite.play("run")
		else:
			asprite.play("idle")
	else:
		if velocity.y < 0:
			asprite.play("jump")  # going up
		else:
			asprite.play("fall")  # going down

func jump() -> void:
	velocity.y = JUMP_VELOCITY
	jumps -= 1
	JUMP_VELOCITY += 200
