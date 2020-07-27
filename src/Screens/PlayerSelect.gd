extends Node2D

export (String, FILE) var next_scene

func switch_scene(player):
	$ButtonMM.disabled = true
	$ButtonJEK.disabled = true
	Global.player_selected = player
	$AudioStreamPlayer.play()
	yield($AudioStreamPlayer, "finished")
	Global.switch_scene(next_scene)
	

#SELECT PLAYER
# set global var > play sound > switchscene

#spawn player
# get global selected player > spawn on position


func _on_ButtonMM_button_up():
	switch_scene(Global.PLAYERS.MM)


func _on_ButtonJEK_button_up():
	switch_scene(Global.PLAYERS.JEK)
