extends Camera2D

export var shake_power = 32
export var shake_time = 0.4
var isShake = false
var curPos
var elapsedtime = 0

func _ready():
	randomize()
	curPos = offset

func _process(delta):
	if isShake:
		_shakeCamera(delta)    


func shake():
	elapsedtime = 0
	isShake = true

func _shakeCamera(delta):
	if elapsedtime<shake_time:
		offset =  Vector2(randf(), randf()) * shake_power
		elapsedtime += delta
	else:
		isShake = false
		elapsedtime = 0
		offset = curPos     
