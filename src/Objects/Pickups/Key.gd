extends Area2D

signal picked

func _on_Key_body_entered(body):
	if body.is_in_group("players"):
		emit_signal("picked")
		yield(get_tree().create_timer(.2), "timeout")
		queue_free()


func _on_Key_picked():
	pass # Replace with function body.
