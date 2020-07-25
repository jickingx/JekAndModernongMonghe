class_name Player
extends Actor

signal coin_collected

const UIDeathMessage = preload("res://src/UI/DeathMessage.tscn")

export var death_restart_delay := 0.8
var direction_x := 0


func _ready():
	if not is_in_group("players"):
		add_to_group("players")


func _process(delta):
	direction_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	#update anim
	if not is_on_floor():
		$AnimatedSprite.play("jump")
	elif direction_x != 0 && is_on_floor():
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")
	#flip
	if direction_x != 0:
		$AnimatedSprite.flip_h = direction_x < 0


func _physics_process(delta):
	#TODO: extract calculation to method 
	if is_disabled_movement:
		return

	if direction_x != 0:
		_velocity.x += direction_x * acceleration * delta * TARGET_FPS
		_velocity.x = clamp(_velocity.x, -speed_max, speed_max)

	if is_on_floor():
		if direction_x == 0:
			_velocity.x = lerp(_velocity.x, 0, friction * delta)
		if Input.is_action_just_pressed("ui_up"):
			_velocity.y = -speed_jump
			$Sounds/Jump.play()  #TODO: move to _process
	else:
		if direction_x == 0:
			_velocity.x = lerp(_velocity.x, 0, friction_air * delta)
		if Input.is_action_just_released("ui_up") and _velocity.y < -speed_jump / 2:
			_velocity.y = -speed_jump / 2

	_velocity = move_and_slide(_velocity, Vector2.UP)


func die():
	var dm = UIDeathMessage.instance()
	Global.current_scene.add_child(dm)
	if $Camera2D.has_method("shake"):
		$Camera2D.shake()
	.die()
	yield(get_tree().create_timer(death_restart_delay), "timeout")
	Global.restart_scene()


func warp_to_portal():
	is_disabled_movement = true
	
	$AnimationPlayer.play("warp")


func _on_Detector_area_entered(area):
	if area.is_in_group("hazards"):
		die()
	if area.is_in_group("coins") && area.has_method("die"):
		$Sounds/Pickup.play()
		emit_signal("coin_collected")
		area.die()
	if area.is_in_group("stompables") && area.global_position.y > $Detector.global_position.y:
		_velocity.y = -speed_jump


func _on_Detector_body_entered(body):
	if body.is_in_group("hazards"):
		die()
	if body.is_in_group("enemies"):
		die()
	else:
		print_debug(body)
