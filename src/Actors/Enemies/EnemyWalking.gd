extends Actor
class_name EnemyWalking

const Projectile = preload("res://src/Actors/Enemies/EnemyProjectile.tscn")

export var hp := 1
export var can_shoot := false
export var is_debug := true

var movement_direction := -1

func _ready():
	if not self.is_in_group("enemies"):
		self.add_to_group("enemies")
	
	acceleration = 64
	speed_max = 512
	friction = 80
	is_disabled_movement = true
	$AnimatedSprite.playing = true
	#validate if can really shoot
	if can_shoot && not (has_node("PlayerDetector") && has_node("ShootTimer")) :
		can_shoot = false


func _physics_process(delta):
	if is_disabled_movement:
		return

	_velocity.x += movement_direction * acceleration * delta * TARGET_FPS
	_velocity.x = clamp(_velocity.x, -speed_max, speed_max)
	_velocity = move_and_slide(_velocity, Vector2.UP)


#func explode():
#	var ex = ParticlesExplosion.instance()
#	ex.position = self.global_position
#	Global.current_scene.add_child(ex)
#	ex.emitting = true

func shoot():
	if is_debug:
		print_debug("shoot")
	var p = Projectile.instance()
	p.position = self.global_position
	p.is_facing_right = $AnimatedSprite.flip_h
	Global.current_scene.add_child(p)


func _on_Goryo_died():
	queue_free()


func _on_VisibilityNotifier2D_screen_entered():
	is_disabled_movement = false


func _on_Detector_area_entered(area):
	if area.global_position.y > $Detector.global_position.y:
		return
	if not area.is_in_group("players") && not area.get_parent().is_in_group("players"):
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
	if can_shoot:
		print_debug($PlayerDetector.position.x)
		$PlayerDetector.position.x *= -1
		print_debug($PlayerDetector.position.x)


func _on_ShootTimer_timeout():
	shoot()


func _on_PlayerDetector_body_entered(body):
	if can_shoot && body.is_in_group("players"):
		is_disabled_movement = true
		shoot()
		$ShootTimer.start()


func _on_PlayerDetector_body_exited(body):
	if can_shoot && body.is_in_group("players"):
		is_disabled_movement = false
		$ShootTimer.stop()



