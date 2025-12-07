extends Area2D

@export var item : String
@export var item_id : String
@export var item_sprite : Texture

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite_2d.texture = item_sprite

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.add_item(item, sprite_2d.texture, item_id)
		queue_free()
