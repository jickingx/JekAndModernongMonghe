extends StaticBody2D

const ParticlesExplosion = preload("res://src/Particles/Explosion.tscn")

func destroy_self():
	$AudioStreamPlayer.play()
	var ex = ParticlesExplosion.instance()
	ex.position = self.position
	Global.current_scene.add_child(ex)
	ex.emitting = true
	
	yield(get_tree().create_timer(.4), "timeout")
	queue_free()

func _on_DestroyerButton_pressed():
	destroy_self()

func _on_DestroyerButton00_pressed():
	destroy_self()
	
func _on_DestroyerButton01_pressed():
	destroy_self()

func _on_DestroyerButton02_pressed():
	destroy_self()

func _on_DestroyerButton03_pressed():
	destroy_self()

func _on_DestroyerButton04_pressed():
	destroy_self()
