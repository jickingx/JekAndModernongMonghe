extends EnemyWalking

const Projectile = preload("res://src/Actors/Enemies/EnemyProjectile.tscn")


func _ready():
	acceleration = 64
	speed_max = 512
	friction = 80
	disable()


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
	$PlayerDetector.position.x *= -1


func _on_StompDetector_area_entered(area):
	if area.global_position.y > $StompDetector.global_position.y:
		return
	if not area.is_in_group("players"):
		return
	hp -= 1
	
	if hp <= 0:
		die()


func _on_PlayerDetector_body_entered(body):
	if body.is_in_group("players"):
		is_disabled = true
		shoot()
		$ShootTimer.start()


func _on_PlayerDetector_body_exited(body):
	if body.is_in_group("players"):
		is_disabled = false
		$ShootTimer.stop()


func shoot():
	print_debug("shoot")
	var p = Projectile.instance()
	p.position = self.global_position
	p.is_facing_right = $AnimatedSprite.flip_h
	Global.current_scene.add_child(p)


func _on_ShootTimer_timeout():
	shoot()


#TODO: CLEAN UP ENEMY/ACTOR SCRIPT
#DISABLE SHOULD BE DISABLE_AND_HIDE
#UPDATE DIE()
