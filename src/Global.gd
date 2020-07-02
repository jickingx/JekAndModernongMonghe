extends Node

const ScreenOverlay: PackedScene = preload("res://src/Ui/Fx/ScreenOverlay.tscn")

var current_scene_path:= ""

onready var root = get_tree().get_root()
onready var current_scene = root.get_child(root.get_child_count() - 1)


func _ready():
	setup_fade_transition()
	print_debug(current_scene.get_node_and_resource(current_scene.get_path()))

func restart_scene():
	switch_scene(current_scene_path)

func switch_scene(path: String):
	current_scene_path = path
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path: String):
	# It is now safe to remove the current scene
	current_scene.free()
	
	# Load the new scene.
	var s = ResourceLoader.load(path)
	# Instance the new scene.
	current_scene = s.instance()
	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)
	setup_fade_transition()


func setup_fade_transition():
	var so = ScreenOverlay.instance()
	so.set_name("ScreenOverlay")
	current_scene.add_child(so)


func fade_out_transition() -> void:
	var so = current_scene.get_node_or_null("ScreenOverlay")
	if so != null :
		so.fade_out()
