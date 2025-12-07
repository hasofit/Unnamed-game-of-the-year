extends CharacterBody2D

@onready var slot_1: TextureButton = $CanvasLayer/HotBar/Slot1
@onready var slot_2: TextureButton = $CanvasLayer/HotBar/Slot2
@onready var slot_3: TextureButton = $CanvasLayer/HotBar/Slot3
@onready var slot_4: TextureButton = $CanvasLayer/HotBar/Slot4
@onready var slot_5: TextureButton = $CanvasLayer/HotBar/Slot5
@onready var slot_6: TextureButton = $CanvasLayer/HotBar/Slot6
@onready var slot_7: TextureButton = $CanvasLayer/HotBar/Slot7
@onready var slot_8: TextureButton = $CanvasLayer/HotBar/Slot8
@onready var slot_9: TextureButton = $CanvasLayer/HotBar/Slot9

@onready var slot_1_label: Label = $CanvasLayer/HotBar/Slot1/Slot1Label

var inv = []

var health = 100
var dead = false
var SPEEDX = 600.0
var SPEEDY = 600


func _physics_process(delta: float) -> void:
	if !dead:
		if not is_on_floor():
			velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX := Input.get_axis("move_left", "move_right")
	var directionY := Input.get_axis("move_up", "move_down")
	if directionX:
		velocity.x = directionX * SPEEDX
	else:
		velocity.x = move_toward(velocity.x, 0, SPEEDX)
	if directionY:
		velocity.y = directionY * SPEEDY
	else:
		velocity.y = move_toward(velocity.y, 0, SPEEDY)

	move_and_slide()

func add_item(item_name,item_sprite):
	slot_1.texture_normal = item_sprite
	slot_1_label.text = item_name
