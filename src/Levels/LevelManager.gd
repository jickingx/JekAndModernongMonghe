extends Node2D

const Hud = preload("res://src/UI/Hud.tscn")
const MM = preload("res://src/Actors/Players/PlayerModernongMonghe.tscn")
const Jek = preload("res://src/Actors/Players/PlayerJekengkoy.tscn")

var hud
var score := 0 #for current level only


func _ready():
	setup_hud()
	setup_players()
	setup_doors()


func setup_hud():
	hud = Hud.instance()
	Global.current_scene.add_child(hud)
	score = Global.score
	hud.coin_add(score)


func setup_players():
	#set player to spawn
	var anim_texture_path := ""
	var p
	match Global.player_selected:
		Global.PLAYERS.JEK:
			p = Jek.instance()
		_:
			p = MM.instance()
	add_child(p)
	p.global_position = $PositionSpawnPlayer.global_position
	p.connect("coin_collected", self, "_on_Player_coin_collected")


func setup_doors():
	for door in Global.current_scene.get_tree().get_nodes_in_group("doors"):
		door.connect("player_entered", self, "_on_Door_player_entered")


func _on_Key_picked():
	pass # Replace with function body.


func _on_Player_coin_collected():
	if not hud:
		return
	score += 1
	hud.coin_add(1)


func _on_Door_player_entered():
	Global.score = score
