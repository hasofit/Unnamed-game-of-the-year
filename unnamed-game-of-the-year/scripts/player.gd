extends CharacterBody2D

var slot_1_locked = false
var slot_2_locked = false
var slot_3_locked = false
var slot_4_locked = false
var slot_5_locked = false
var slot_6_locked = false
var slot_7_locked = false
var slot_8_locked = false
var slot_9_locked = false

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
@onready var slot_2_label: Label = $CanvasLayer/HotBar/Slot2/Slot2Label
@onready var slot_3_label: Label = $CanvasLayer/HotBar/Slot3/Slot3Label
@onready var slot_4_label: Label = $CanvasLayer/HotBar/Slot4/Slot4Label
@onready var slot_5_label: Label = $CanvasLayer/HotBar/Slot5/Slot5Label
@onready var slot_6_label: Label = $CanvasLayer/HotBar/Slot6/Slot6Label
@onready var slot_7_label: Label = $CanvasLayer/HotBar/Slot7/Slot7Label
@onready var slot_8_label: Label = $CanvasLayer/HotBar/Slot8/Slot8Label
@onready var slot_9_label: Label = $CanvasLayer/HotBar/Slot9/Slot9Label

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

func add_item(item_name,item_sprite,item_id):
	if slot_1_locked == false:
		slot_1.texture_normal = item_sprite
		slot_1_label.text = item_name
		slot_1_locked = true
		inv.append(item_id)
	elif slot_2_locked == false:
		slot_2.texture_normal = item_sprite
		slot_2_label.text = item_name
		slot_2_locked = true
		inv.append(item_id)
	elif slot_3_locked == false:
		slot_3.texture_normal = item_sprite
		slot_3_label.text = item_name
		slot_3_locked = true
		inv.append(item_id)
	elif slot_4_locked == false:
		slot_4.texture_normal = item_sprite
		slot_4_label.text = item_name
		slot_4_locked = true
		inv.append(item_id)
	elif slot_5_locked == false:
		slot_5.texture_normal = item_sprite
		slot_5_label.text = item_name
		slot_5_locked = true
		inv.append(item_id)
	elif slot_6_locked == false:
		slot_6.texture_normal = item_sprite
		slot_6_label.text = item_name
		slot_6_locked = true
	elif slot_7_locked == false:
		slot_7.texture_normal = item_sprite
		slot_7_label.text = item_name
		slot_7_locked = true
		inv.append(item_id)
		inv.append(item_id)
	elif slot_8_locked == false:
		slot_8.texture_normal = item_sprite
		slot_8_label.text = item_name
		slot_8_locked = true
		inv.append(item_id)
	elif slot_9_locked == false:
		slot_9.texture_normal = item_sprite
		slot_9_label.text = item_name
		slot_9_locked = true
		inv.append(item_id)
	else:
		print(inv)
		print("No more slots")
