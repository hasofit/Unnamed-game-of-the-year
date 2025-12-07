extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.inv.append("Test")
		queue_free()
		print(body.inv)
