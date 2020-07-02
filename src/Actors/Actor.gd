extends KinematicBody2D
class_name Actor

const ParticlesExplosion = preload("res://src/Particles/Explosion.tscn")

const TARGET_FPS: = 60
const FLOOR_NORMAL: = Vector2.UP

export var is_disabled := false
var motion: = Vector2.ZERO

func disable():
	is_disabled = true
	hide()
