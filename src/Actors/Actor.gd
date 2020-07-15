extends KinematicBody2D
class_name Actor

const ParticlesExplosion = preload("res://src/Particles/Explosion.tscn")
const TARGET_FPS := 60
const FLOOR_NORMAL := Vector2.UP

export var gravity := 32  #using pixel per second unit
export var acceleration := 32
export var speed_jump := 1024
export var speed_max := 512
export var friction := 80
export var friction_air := 32
export var is_disabled := false

var _velocity := Vector2.ZERO


func _physics_process(delta):
	_velocity.y += gravity * delta * TARGET_FPS


func disable():
	is_disabled = true
	hide()


func enable():
	is_disabled = false
	show()
