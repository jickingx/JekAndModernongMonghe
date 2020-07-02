extends Node2D

onready var jek = $Jek
onready var monghe = $Monghe

func _ready():
	jek.is_disabled = true

func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		print_debug("Switch player")
		switch_player()

func switch_player():
	if jek.is_disabled :
		monghe.disable_control()
		jek.enable_control()
	else:
		jek.disable_control()
		monghe.enable_control()
