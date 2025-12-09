extends CharacterBody2D

const HOTBAR_SIZE := 9
const SAVE_PATH := "user://Save1.save"

var slots: Array[TextureButton] = []
var slot_labels: Array[Label] = []
var slot_selected: Array[TextureRect] = []
var slot_items: Array[String] = []
var slot_locked: Array[bool] = []

@onready var helmet_sprite_node: Sprite2D = $Helmet
@onready var health_bar: ProgressBar = $"CanvasLayer/Health Bar"
@onready var sword: Area2D = $Sword
@onready var sword_cooldown_node: Timer = $"Sword Cooldown"

@export var test_helmet_sprite: Texture2D
@export var blood_sword: Texture2D

var equipped_helmet: String = ""
var equipped_item: String = ""
var sword_cooldown = false
var sword_equipped : String = ""

var inv = []

var health: float = 100.0
var max_health: float = 100.0
var enemy_damaging_count: int = 0
var damage: float = 0.0
var shield: float = 0.0
var sword_cooldown_time = 5

var SPEEDX: float = 600.0
var SPEEDY: float = 600.0

enum ItemType { CONSUMABLE, WEAPON, ARMOR }
enum ArmorType { HELMET, CHEST, LEGS }

func _ready() -> void:
	sword_cooldown_node.start(sword_cooldown_time)
	setup_hotbar_arrays()
	load_game()

func setup_hotbar_arrays() -> void:
	for i in range(HOTBAR_SIZE):
		var slot_index := i + 1
		var slot_path := "CanvasLayer/HotBar/Slot%d" % slot_index
		var slot: TextureButton = get_node(slot_path)
		var label: Label = slot.get_node("Slot%dLabel" % slot_index)
		var selected: TextureRect = slot.get_node("Slot%dSelected" % slot_index)

		slots.append(slot)
		slot_labels.append(label)
		slot_selected.append(selected)
		slot_items.append("")
		slot_locked.append(false)

		slot.pressed.connect(_on_slot_pressed.bind(i))

func _physics_process(delta: float) -> void:
	
	if sword_equipped:
		sword.visible = true
	else:
		sword.visible = false
	
	sword.look_at(get_global_mouse_position())
	
	take_damage(damage, delta)

	health = clamp(health, 0.0, max_health)
	health_bar.max_value = max_health
	health_bar.value = health

	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_vector.length() > 0.0:
		velocity.x = input_vector.x * SPEEDX
		velocity.y = input_vector.y * SPEEDY
	else:
		velocity.x = move_toward(velocity.x, 0.0, SPEEDX)
		velocity.y = move_toward(velocity.y, 0.0, SPEEDY)

	move_and_slide()

	if Input.is_action_just_pressed("ui_down"):
		save_game()

func add_item(
	item_name: String,
	item_sprite: Texture2D,
	item_id: String,
	item_type: int,
	armor_type: int
) -> void:
	if item_type != ItemType.ARMOR:
		_add_to_hotbar(item_name, item_sprite, item_id)
	else:
		if armor_type == ArmorType.HELMET:
			equipped_helmet = item_id
			_update_helmet_sprite()

func _add_to_hotbar(item_name: String, item_sprite: Texture2D, item_id: String) -> void:
	for i in range(HOTBAR_SIZE):
		if !slot_locked[i]:
			slot_locked[i] = true
			slot_items[i] = item_id
			slots[i].texture_normal = item_sprite
			slot_labels[i].text = item_name
			inv.append(item_id)
			return
	print("NO MORE SLOTS!")

func _on_slot_pressed(index: int) -> void:
	equipped_item = slot_items[index]
	var make_visible := !slot_selected[index].visible

	for i in range(HOTBAR_SIZE):
		slot_selected[i].visible = false

	slot_selected[index].visible = make_visible

	if !make_visible:
		equipped_item = ""

func take_damage(dmg: float, delta: float) -> void:
	if equipped_helmet == "test_helmet":
		shield = 0.0

	var total_damage := dmg * float(enemy_damaging_count) * delta - shield
	if total_damage <= 0.0:
		return

	health -= total_damage

func _update_helmet_sprite() -> void:
	match equipped_helmet:
		"test_helmet":
			helmet_sprite_node.texture = test_helmet_sprite
		_:
			helmet_sprite_node.texture = null

func _get_save_data() -> Dictionary:
	return {
		"slots": slot_items,
		"equipped_helmet": equipped_helmet,
		"health": health,
		"inv": inv,
	}

func save_game() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		print("SAVE ERROR!")
		return
	var data := _get_save_data()
	file.store_var(data)
	file.close()
	print("Saved:", data)

func load_game() -> void:
	if !FileAccess.file_exists(SAVE_PATH):
		print("NO SAVE FILE.")
		return

	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		print("FAILED TO READ SAVE.")
		return

	var saved_data: Dictionary = file.get_var()
	file.close()

	equipped_helmet = saved_data.get("equipped_helmet", saved_data.get("equiped_helmet", ""))
	health = float(saved_data.get("health", max_health))
	inv = saved_data.get("inv", [])

	restore_hotbar_slots(saved_data.get("slots", []))
	_update_helmet_sprite()

	print("Loaded:", saved_data)

func restore_hotbar_slots(saved_slots: Array) -> void:
	for i in range(HOTBAR_SIZE):
		var id := ""
		if i < saved_slots.size():
			id = str(saved_slots[i])

		if id == "" or id == null:
			slot_items[i] = ""
			slot_locked[i] = false
			slot_labels[i].text = ""
			slots[i].texture_normal = null
		else:
			slot_items[i] = id
			slot_locked[i] = true
			slot_labels[i].text = id

func _on_sword_body_entered(body: Node2D) -> void:
	if sword_cooldown == false:
		hit(damage, body)

func _on_sword_cooldown_timeout() -> void:
	sword_cooldown = false

func hit(damage, body):
	if body.is_in_group("Enemies"):
		body.health -= damage
