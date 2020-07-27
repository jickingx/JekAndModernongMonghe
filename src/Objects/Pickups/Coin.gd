extends Area2D


func die():
	$CollisionShape2D.queue_free()
	$AnimationPlayer.play("fade")
	yield($AnimationPlayer, "animation_finished")
	queue_free()
