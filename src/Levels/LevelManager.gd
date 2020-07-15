extends Node2D

const Hud = preload("res://src/UI/Hud.tscn")
var hud
var score := 0 #for current level only

func _ready():
	setup_hud()
	setup_doors()


func _on_Player_coin_collected():
	if not hud:
		return
	score += 1
	hud.coin_add(1)


func _on_Door_player_entered():
	Global.score += score


func setup_hud():
	hud = Hud.instance()
	for player in Global.current_scene.get_tree().get_nodes_in_group("players"):
		player.connect("coin_collected", self, "_on_Player_coin_collected")
	Global.current_scene.add_child(hud)
	score = Global.score
	hud.coin_add(score)


func setup_doors():
	for door in Global.current_scene.get_tree().get_nodes_in_group("doors"):
		door.connect("player_entered", self, "_on_Door_player_entered")
