extends Area2D

export (String, FILE) var next_scene
export var switch_delay: float = .4


func _on_Door_body_entered(body):
	if body.is_in_group("players"):
		body.disable()
		$AudioStreamPlayer2D.play()
		yield(get_tree().create_timer(switch_delay), "timeout")
		Global.switch_scene(next_scene)
