extends Actor

const ACCELERATION: = 64
const MAX_SPEED: = 512
const FRICTION: = 80

var movement_direction:= -1

func _ready():
	disable()

func _physics_process(delta):
	if is_disabled:
		return
	
	motion.x += movement_direction * ACCELERATION * delta * TARGET_FPS
	motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	motion = move_and_slide(motion, Vector2.UP)


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
	
