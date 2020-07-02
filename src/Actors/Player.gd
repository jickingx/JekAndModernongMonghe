extends Actor

const ParticlesExplosion = preload("res://src/Particles/Explosion.tscn")

const ACCELERATION: = 64
const MAX_SPEED: = 384
const FRICTION: = 10
const AIR_RESISTANCE: = 1
const GRAVITY: = 10
const JUMP_FORCE: = 384

export var death_restart_delay: float = .8

var motion: = Vector2.ZERO

onready var animatedSprite = $AnimatedSprite

func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if x_input != 0:
		motion.x += x_input * ACCELERATION * delta * TARGET_FPS
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	
	motion.y += GRAVITY * delta * TARGET_FPS
	
	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION * delta)
			
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_FORCE
			$Sounds/Jump.play()
	else:
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE * delta)
	
	motion = move_and_slide(motion, Vector2.UP)
	
	#UPDATE SPRITE HERE
	if not is_on_floor():
		animatedSprite.play("jump")
	elif x_input != 0 && is_on_floor():
		animatedSprite.play("walk")
	else:
		animatedSprite.play("idle")
	#flip
	if x_input != 0:
		animatedSprite.flip_h = x_input < 0


func _on_HazardDetector_body_entered(body):
	if body.is_in_group("hazards"):
		print_debug("kill")
		var ex = ParticlesExplosion.instance()
		ex.position = self.position
		Global.current_scene.add_child(ex)
		ex.emitting = true
		hide()
		yield(get_tree().create_timer(death_restart_delay), "timeout")
		Global.restart_scene()
