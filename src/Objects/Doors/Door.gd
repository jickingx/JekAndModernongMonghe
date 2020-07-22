extends Area2D

signal player_entered

export var is_locked := false
export (String, FILE) var next_scene
export var switch_delay: float = .6


func _ready():
	if is_locked:
		$AnimatedSprite.play("locked")
	else:
		$AnimatedSprite.play("unlocked")


func switch_scene():
	emit_signal("player_entered")
	$AudioStreamPlayer2D.play()
	yield(get_tree().create_timer(switch_delay), "timeout")
	Global.switch_scene(next_scene)


func unlock():
	$AudioStreamPlayer2D.play()
	is_locked = false
	$AnimatedSprite.play("unlocked")


func _on_Door_body_entered(body):
	if is_locked:
		return
	if body.is_in_group("players"):
		body.warp_to_portal()
		switch_scene()


func _on_Key_picked():
	unlock()


func _on_DoorButton_pressed():
	unlock()

