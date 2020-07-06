extends KinematicBody2D


const ParticlesExplosion = preload("res://src/Particles/Explosion.tscn")
var is_activated = false
var fall_velocity = Vector2.ZERO


func _physics_process(delta):
	if is_activated:
		fall_velocity.y += 128 * delta * 60
		fall_velocity = move_and_slide( fall_velocity )


func die():
	yield(get_tree().create_timer(.01), "timeout")
	var ex = ParticlesExplosion.instance()
	ex.position = self.position
	Global.current_scene.add_child(ex)
	ex.emitting = true
	queue_free()


func _on_ObjectDetector_body_entered(body):
	if body.is_in_group("players") && body.has_method("die"):
		body.die()
	die()


func _on_PlayerDetector_body_entered(body):
	if body.is_in_group("players"):
		is_activated = true
