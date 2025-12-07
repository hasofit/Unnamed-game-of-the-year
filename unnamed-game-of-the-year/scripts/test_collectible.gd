extends Area2D

@export var item : String
@export var item_id : String

@onready var sprite_2d: Sprite2D = $Sprite2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.add_item(item, sprite_2d.texture, item_id)
		queue_free()
