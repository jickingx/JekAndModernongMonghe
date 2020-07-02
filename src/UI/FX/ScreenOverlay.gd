extends CanvasLayer


func _ready():
	$AnimationPlayer.play("fade")


func fade_out():
	print_debug("fade out")
	$AnimationPlayer.play_backwards("fade")
