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
@onready var slot_2_label: Label = $CanvasLayer/HotBar/Slot2/Slot2Label
@onready var slot_3_label: Label = $CanvasLayer/HotBar/Slot3/Slot3Label
@onready var slot_4_label: Label = $CanvasLayer/HotBar/Slot4/Slot4Label
@onready var slot_5_label: Label = $CanvasLayer/HotBar/Slot5/Slot5Label
@onready var slot_6_label: Label = $CanvasLayer/HotBar/Slot6/Slot6Label
@onready var slot_7_label: Label = $CanvasLayer/HotBar/Slot7/Slot7Label
@onready var slot_8_label: Label = $CanvasLayer/HotBar/Slot8/Slot8Label
@onready var slot_9_label: Label = $CanvasLayer/HotBar/Slot9/Slot9Label

@onready var slot_1_selected: TextureRect = $CanvasLayer/HotBar/Slot1/Slot1Selected
@onready var slot_2_selected: TextureRect = $CanvasLayer/HotBar/Slot2/Slot2Selected
@onready var slot_3_selected: TextureRect = $CanvasLayer/HotBar/Slot3/Slot3Selected
@onready var slot_4_selected: TextureRect = $CanvasLayer/HotBar/Slot4/Slot4Selected
@onready var slot_5_selected: TextureRect = $CanvasLayer/HotBar/Slot5/Slot5Selected
@onready var slot_6_selected: TextureRect = $CanvasLayer/HotBar/Slot6/Slot6Selected
@onready var slot_7_selected: TextureRect = $CanvasLayer/HotBar/Slot7/Slot7Selected
@onready var slot_8_selected: TextureRect = $CanvasLayer/HotBar/Slot8/Slot8Selected
@onready var slot_9_selected: TextureRect = $CanvasLayer/HotBar/Slot9/Slot9Selected
@onready var helmet_sprite_node: Sprite2D = $Helmet

@export var equiped_helmet : String

@export var test_helmet_sprite : Texture
@export var demon_horns_sprites : Texture

var inv = []
var equiped_item : String

var health = 100
var SPEEDX = 600.0
var SPEEDY = 600

var slot_1_locked = false
var slot_2_locked = false
var slot_3_locked = false
var slot_4_locked = false
var slot_5_locked = false
var slot_6_locked = false
var slot_7_locked = false
var slot_8_locked = false
var slot_9_locked = false

var slot_1_item : String
var slot_2_item : String
var slot_3_item : String
var slot_4_item : String
var slot_5_item : String
var slot_6_item : String
var slot_7_item : String
var slot_8_item : String
var slot_9_item : String

func _physics_process(delta: float) -> void:
	
	if equiped_helmet == "test_helmet":
		helmet_sprite_node.texture = test_helmet_sprite
	
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

func add_item(item_name,item_sprite,item_id,item_type,armor_type):
	if item_type != 2:
		if slot_1_locked == false:
			slot_1.texture_normal = item_sprite
			slot_1_label.text = item_name
			slot_1_locked = true
			slot_1_item = item_id
			inv.append(item_id)
		elif slot_2_locked == false:
			slot_2.texture_normal = item_sprite
			slot_2_label.text = item_name
			slot_2_locked = true
			slot_2_item = item_id
			inv.append(item_id)
		elif slot_3_locked == false:
			slot_3.texture_normal = item_sprite
			slot_3_label.text = item_name
			slot_3_locked = true
			slot_3_item = item_id
			inv.append(item_id)
		elif slot_4_locked == false:
			slot_4.texture_normal = item_sprite
			slot_4_label.text = item_name
			slot_4_locked = true
			slot_4_item = item_id
			inv.append(item_id)
		elif slot_5_locked == false:
			slot_5.texture_normal = item_sprite
			slot_5_label.text = item_name
			slot_5_locked = true
			slot_5_item = item_id
			inv.append(item_id)
		elif slot_6_locked == false:
			slot_6.texture_normal = item_sprite
			slot_6_label.text = item_name
			slot_6_locked = true
			slot_6_item = item_id
			inv.append(item_id)
		elif slot_7_locked == false:
			slot_7.texture_normal = item_sprite
			slot_7_label.text = item_name
			slot_7_locked = true
			slot_7_item = item_id
			inv.append(item_id)
		elif slot_8_locked == false:
			slot_8.texture_normal = item_sprite
			slot_8_label.text = item_name
			slot_8_locked = true
			slot_8_item = item_id
			inv.append(item_id)
		elif slot_9_locked == false:
			slot_9.texture_normal = item_sprite
			slot_9_label.text = item_name
			slot_9_locked = true
			slot_9_item = item_id
			inv.append(item_id)
		else:
			print(inv)
			print("No more slots")
	elif item_type == 2:
		if armor_type == 1:
			equiped_helmet = item_id
			print(equiped_helmet)
func _on_slot_1_pressed() -> void:
	equiped_item = slot_1_item
	if !slot_1_selected.visible:
		slot_1_selected.visible = true
		slot_2_selected.visible = false
		slot_3_selected.visible = false
		slot_4_selected.visible = false
		slot_5_selected.visible = false
		slot_6_selected.visible = false
		slot_7_selected.visible = false
		slot_8_selected.visible = false
		slot_9_selected.visible = false
	else:
		slot_1_selected.visible = false
		equiped_item = ""

func _on_slot_2_pressed() -> void:
	equiped_item = slot_2_item
	if !slot_2_selected.visible:
		slot_2_selected.visible = true
		slot_1_selected.visible = false
		slot_3_selected.visible = false
		slot_4_selected.visible = false
		slot_5_selected.visible = false
		slot_6_selected.visible = false
		slot_7_selected.visible = false
		slot_8_selected.visible = false
		slot_9_selected.visible = false
	else:
		slot_2_selected.visible = false
		equiped_item = ""

func _on_slot_3_pressed() -> void:
	equiped_item = slot_3_item
	if !slot_3_selected.visible:
		slot_3_selected.visible = true
		slot_2_selected.visible = false
		slot_1_selected.visible = false
		slot_4_selected.visible = false
		slot_5_selected.visible = false
		slot_6_selected.visible = false
		slot_7_selected.visible = false
		slot_8_selected.visible = false
		slot_9_selected.visible = false
	else:
		slot_3_selected.visible = false
		equiped_item = ""

func _on_slot_4_pressed() -> void:
	equiped_item = slot_4_item
	if !slot_4_selected.visible:
		slot_4_selected.visible = true
		slot_2_selected.visible = false
		slot_3_selected.visible = false
		slot_1_selected.visible = false
		slot_5_selected.visible = false
		slot_6_selected.visible = false
		slot_7_selected.visible = false
		slot_8_selected.visible = false
		slot_9_selected.visible = false
	else:
		slot_4_selected.visible = false
		equiped_item = ""

func _on_slot_5_pressed() -> void:
	equiped_item = slot_5_item
	if !slot_5_selected.visible:
		slot_5_selected.visible = true
		slot_2_selected.visible = false
		slot_3_selected.visible = false
		slot_4_selected.visible = false
		slot_1_selected.visible = false
		slot_6_selected.visible = false
		slot_7_selected.visible = false
		slot_8_selected.visible = false
		slot_9_selected.visible = false
	else:
		slot_5_selected.visible = false
		equiped_item = ""

func _on_slot_6_pressed() -> void:
	equiped_item = slot_6_item
	if !slot_6_selected.visible:
		slot_6_selected.visible = true
		slot_2_selected.visible = false
		slot_3_selected.visible = false
		slot_4_selected.visible = false
		slot_5_selected.visible = false
		slot_1_selected.visible = false
		slot_7_selected.visible = false
		slot_8_selected.visible = false
		slot_9_selected.visible = false
	else:
		slot_6_selected.visible = false
		equiped_item = ""

func _on_slot_7_pressed() -> void:
	equiped_item = slot_7_item
	if !slot_7_selected.visible:
		slot_7_selected.visible = true
		slot_2_selected.visible = false
		slot_3_selected.visible = false
		slot_4_selected.visible = false
		slot_5_selected.visible = false
		slot_6_selected.visible = false
		slot_1_selected.visible = false
		slot_8_selected.visible = false
		slot_9_selected.visible = false
	else:
		slot_7_selected.visible = false
		equiped_item = ""

func _on_slot_8_pressed() -> void:
	equiped_item = slot_8_item
	if !slot_8_selected.visible:
		slot_8_selected.visible = true
		slot_2_selected.visible = false
		slot_3_selected.visible = false
		slot_4_selected.visible = false
		slot_5_selected.visible = false
		slot_6_selected.visible = false
		slot_7_selected.visible = false
		slot_1_selected.visible = false
		slot_9_selected.visible = false
	else:
		slot_8_selected.visible = false
		equiped_item = ""

func _on_slot_9_pressed() -> void:
	equiped_item = slot_9_item
	if !slot_9_selected.visible:
		slot_9_selected.visible = true
		slot_2_selected.visible = false
		slot_3_selected.visible = false
		slot_4_selected.visible = false
		slot_5_selected.visible = false
		slot_6_selected.visible = false
		slot_7_selected.visible = false
		slot_8_selected.visible = false
		slot_1_selected.visible = false
	else:
		slot_9_selected.visible = false
		equiped_item = ""
