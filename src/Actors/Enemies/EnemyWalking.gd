extends Actor
class_name EnemyWalking

export var hp = 1
var movement_direction := -1


func _ready():
	if not self.is_in_group("enemies"):
		self.add_to_group("enemies")
	
	acceleration = 64
	speed_max = 512
	friction = 80
	is_disabled_movement = true
	$AnimatedSprite.playing = true


func _physics_process(delta):
	if is_disabled_movement:
		return

	_velocity.x += movement_direction * acceleration * delta * TARGET_FPS
	_velocity.x = clamp(_velocity.x, -speed_max, speed_max)
	_velocity = move_and_slide(_velocity, Vector2.UP)



func _on_VisibilityNotifier2D_screen_entered():
	is_disabled_movement = false


func _on_Detector_area_entered(area):
	if area.global_position.y > $Detector.global_position.y:
		return
	if not area.is_in_group("players"):
		return
	hp -= 1
	$Sounds/Hurt.play()
	$AnimationPlayer.play("hurt")
	if hp <= 0:
		die()


func _on_Detector_body_entered(body):
	var wall := body as TileMap
	if not wall:
		return

	is_disabled_movement = true
	yield(get_tree().create_timer(.2), "timeout")
	movement_direction *= -1
	is_disabled_movement = false
	$AnimatedSprite.flip_h = true if movement_direction == 1 else false



func _on_Goryo_died():
	queue_free()
