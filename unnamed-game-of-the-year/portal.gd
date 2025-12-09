extends Area2D

@export_flags("World 1","Testing world") var WorldToGo

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if WorldToGo == 1:
			get_tree().change_scene_to_file("res://scenes/world_1.tscn")
		if WorldToGo == 2:
			get_tree().change_scene_to_file("res://scenes/testing_world.tscn")
