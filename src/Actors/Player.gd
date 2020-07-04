extends Actor

const UIDeathMessage = preload("res://src/UI/DeathMessage.tscn")

export var death_restart_delay:= 0.8
var x_input := 0
var input:= Vector2.ZERO
onready var animatedSprite:= $AnimatedSprite


func _process(delta):
	x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	#update anim
	if not is_on_floor():
		animatedSprite.play("jump")
	elif x_input != 0 && is_on_floor():
		animatedSprite.play("walk")
	else:
		animatedSprite.play("idle")
	#flip
	if x_input != 0:
		animatedSprite.flip_h = x_input < 0


func _physics_process(delta):
	#TODO: extract calculation to method 
	if is_disabled:
		return
	
	if x_input != 0:
		_velocity.x += x_input * acceleration * delta * TARGET_FPS
		_velocity.x = clamp(_velocity.x, -speed_max, speed_max)
	
	if is_on_floor():
		if x_input == 0:
			_velocity.x = lerp(_velocity.x, 0, friction * delta)
		if Input.is_action_just_pressed("ui_up"):
			_velocity.y = -speed_jump
			$Sounds/Jump.play() #TODO: move to _process
	else:
		if x_input == 0:
			_velocity.x = lerp(_velocity.x, 0, friction_air * delta)
		if Input.is_action_just_released("ui_up") and _velocity.y < -speed_jump/2:
			_velocity.y = -speed_jump/2
	
	_velocity = move_and_slide(_velocity, Vector2.UP)


func die():
	var ex = ParticlesExplosion.instance()
	ex.position = self.position
	Global.current_scene.add_child(ex)
	ex.emitting = true
	
	var dm = UIDeathMessage.instance()
	Global.current_scene.add_child(dm)
	
	if $Camera2D.has_method("shake"):
		$Camera2D.shake()
	
	disable()
	$Sounds/Dead.play()
	yield(get_tree().create_timer(death_restart_delay), "timeout")
	Global.restart_scene()


func enable_control():
	$Camera2D.current = true
	is_disabled = false


func disable_control():
	$Camera2D.current = false
	is_disabled = true
	_velocity = Vector2.ZERO


func _on_ObjectDetector_body_entered(body):
	if body.is_in_group("hazards"):
		die()


func _on_ObjectDetector_area_entered(area):
	if area.is_in_group("coins") && area.has_method("kill") :
		$Sounds/Pickup.play()
		area.kill()

