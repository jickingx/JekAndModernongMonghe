extends Area2D

var speed = 800
var is_facing_right = false

func _physics_process(delta):
	if is_facing_right: 
		position += transform.x * speed * delta
	else:
		position += transform.x * speed * delta * -1


func _on_Bullet_body_entered(body):
	if not body.is_in_group("enemies"):
		body.queue_free()
		return
	yield(get_tree().create_timer(.6), "timeout")
	queue_free()
