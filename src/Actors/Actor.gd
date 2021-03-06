class_name Actor
extends KinematicBody2D
signal died

const ParticlesExplosion = preload("res://src/Particles/Explosion.tscn")
const TARGET_FPS := 60
const FLOOR_NORMAL := Vector2.UP

export var gravity := 32  #using pixel per second unit
export var acceleration := 32
export var speed_jump := 1024
export var speed_max := 512
export var friction := 80
export var friction_air := 32
export var is_disabled_movement := false

var _velocity := Vector2.ZERO


func _physics_process(delta):
	_velocity.y += gravity * delta * TARGET_FPS


func die():
	if is_disabled_movement:
		return
	is_disabled_movement = true
	remove_collisions()
	#$AnimationPlayer.play("hurt")
	explode()
	$AnimatedSprite.hide()
	$Sounds/Hurt.play()
	yield($Sounds/Hurt, "finished")
	emit_signal("died")
	#subscribe to signal then call queue_free()
	

func explode():
	$Label.text = "POS G: %s, %s " % [self.global_position.x,self.global_position.y]
	$Label2.text = "POS : %s, %s " % [self.position.x,self.position.x]
	var ex = ParticlesExplosion.instance()
	ex.global_position = self.global_position
	#ex.position = self.position
	Global.current_scene.add_child(ex)
	ex.emitting = true
	print("yawa")


func remove_collisions():
	if is_instance_valid($CollisionShape2D):
		$CollisionShape2D.queue_free()
	if is_instance_valid($Detector):
		$Detector.queue_free()
