extends Actor

var movement_direction := -1


func _ready():
	acceleration = 64
	speed_max = 512
	friction = 80
	disable()


func _physics_process(delta):
	if is_disabled:
		return

	_velocity.x += movement_direction * acceleration * delta * TARGET_FPS
	_velocity.x = clamp(_velocity.x, -speed_max, speed_max)
	_velocity = move_and_slide(_velocity, Vector2.UP)


func _on_VisibilityNotifier2D_screen_entered():
	enable()


func _on_WallDetector_body_entered(body):
	var wall := body as TileMap
	if not wall:
		return

	is_disabled = true
	yield(get_tree().create_timer(.2), "timeout")
	movement_direction *= -1
	is_disabled = false
