extends Camera2D

func _ready():
	set_process(true)

func _process(delta):
	var pos = get_position()
	set_position(Vector2(pos.x + 5, pos.y))
