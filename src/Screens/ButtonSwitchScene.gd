extends Button

export(String, FILE) var next_scene

func _on_Button_button_up():
	Global.switch_scene(next_scene)
