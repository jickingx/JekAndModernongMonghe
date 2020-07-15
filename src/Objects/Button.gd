extends StaticBody2D

signal pressed

var is_pressed := false


func _ready():
	if is_pressed:
		$AnimatedSprite.play("pressed")
	else:
		$AnimatedSprite.play("default")


func press():
	is_pressed = true
	emit_signal("pressed")
	$AnimatedSprite.play("pressed")
	$TriggerDetector.queue_free()


func _on_TriggerDetector_body_entered(body):
	if body.is_in_group("players"):
		press()


func _on_DestroyerButton_pressed():
	pass  # Replace with function body.
