extends Actor
class_name EnemyWalking

export var hp = 1
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


func die():
	explode()
	queue_free()


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
	$AnimatedSprite.flip_h = true if movement_direction == 1 else false


func _on_StompDetector_area_entered(area):
	if area.global_position.y > $StompDetector.global_position.y:
		return
	if not area.is_in_group("players"):
		return
	hp -= 1
	
	if hp <= 0:
		die()


