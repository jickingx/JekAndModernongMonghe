extends Node2D

const Hud = preload("res://src/UI/Hud.tscn")
var hud


func _ready():
	setup_hud()


func _on_Player_coin_collected():
	if not hud:
		return
	hud.coin_add()


func setup_hud():
	hud = Hud.instance()
	
	#get players then link signals to hud
	for player in Global.current_scene.get_tree().get_nodes_in_group ("players"):
		player.connect("coin_collected", self, "_on_Player_coin_collected")
	
	Global.current_scene.add_child(hud)


