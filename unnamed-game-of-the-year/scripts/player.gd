extends CharacterBody2D

var slots: Array[TextureButton] = []
var slot_labels: Array[Label] = []
var slot_selected: Array[TextureRect] = []
var slot_items: Array[String] = []
var slot_locked: Array[bool] = []

@onready var helmet_sprite_node: Sprite2D = $Helmet
@onready var health_bar: ProgressBar = $"CanvasLayer/Health Bar"

@export var test_helmet_sprite: Texture
@export var demon_horns_sprites: Texture

var equiped_helmet: String = ""
var equiped_item: String = ""

var inv = []

var health = 100
var max_health = 100
var enemy_damaging_count = 0
var damage = 0
var shield = 0

var SPEEDX = 600.0
var SPEEDY = 600

const SAVE_PATH = "user://Save1.save"


# -----------------------------------------------------
# READY
# -----------------------------------------------------
func _ready():
	setup_hotbar_arrays()
	load_game(["slots", "equiped_helmet", "health", "inv"])


# -----------------------------------------------------
# HOTBAR INITIALIZATION
# -----------------------------------------------------
func setup_hotbar_arrays():
	for i in range(1, 10):

		var slot_path := "CanvasLayer/HotBar/Slot%d" % i
		var slot: TextureButton = get_node(slot_path)

		var label: Label = slot.get_node("Slot%dLabel" % i)
		var selected: TextureRect = slot.get_node("Slot%dSelected" % i)

		slots.append(slot)
		slot_labels.append(label)
		slot_selected.append(selected)
		slot_items.append("")
		slot_locked.append(false)

		# Connect
		slot.pressed.connect(_on_slot_pressed.bind(i - 1))


# -----------------------------------------------------
# PHYSICS
# -----------------------------------------------------
func _physics_process(delta):
	take_damage(damage, delta)

	health_bar.max_value = max_health
	health_bar.value = health

	if equiped_helmet == "test_helmet":
		helmet_sprite_node.texture = test_helmet_sprite

	var directionX := Input.get_axis("move_left", "move_right")
	var directionY := Input.get_axis("move_up", "move_down")

	velocity.x = directionX * SPEEDX if directionX else move_toward(velocity.x, 0, SPEEDX)
	velocity.y = directionY * SPEEDY if directionY else move_toward(velocity.y, 0, SPEEDY)

	move_and_slide()

	if Input.is_action_just_pressed("ui_down"):
		save_game({
			"slots": slot_items,
			"equiped_helmet": equiped_helmet,
			"health": health,
			"inv": inv
		})


# -----------------------------------------------------
# ADD ITEM (FIRST EMPTY SLOT)
# -----------------------------------------------------
func add_item(item_name, item_sprite, item_id, item_type, armor_type):
	if item_type != 2:
		for i in range(9):
			if !slot_locked[i]:
				slot_locked[i] = true
				slot_items[i] = item_id

				slots[i].texture_normal = item_sprite
				slot_labels[i].text = item_name

				inv.append(item_id)
				return
		print("NO MORE SLOTS!")
	else:
		if armor_type == 1:
			equiped_helmet = item_id


# -----------------------------------------------------
# SLOT CLICK
# -----------------------------------------------------
func _on_slot_pressed(index: int):
	equiped_item = slot_items[index]

	var make_visible = !slot_selected[index].visible

	for i in range(9):
		slot_selected[i].visible = false

	slot_selected[index].visible = make_visible

	if !make_visible:
		equiped_item = ""


# -----------------------------------------------------
# DAMAGE
# -----------------------------------------------------
func take_damage(dmg, delta):
	if equiped_helmet == "test_helmet":
		shield = 0
	health -= dmg * enemy_damaging_count * delta


# -----------------------------------------------------
# SAVE GAME
# -----------------------------------------------------
func save_game(data: Dictionary) -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		print("SAVE ERROR!")
		return
	file.store_var(data)
	file.close()
	print("Saved:", data)


# -----------------------------------------------------
# LOAD GAME
# -----------------------------------------------------
func load_game(keys: Array) -> void:
	if !FileAccess.file_exists(SAVE_PATH):
		print("NO SAVE FILE.")
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		print("FAILED TO READ SAVE.")
		return

	var saved_data: Dictionary = file.get_var()
	file.close()

	for key in keys:
		if saved_data.has(key):
			match key:
				"equiped_helmet":
					equiped_helmet = saved_data[key]

				"health":
					health = saved_data[key]

				"inv":
					inv = saved_data[key]

				"slots":
					restore_hotbar_slots(saved_data[key])

	print("Loaded:", saved_data)


# -----------------------------------------------------
# RESTORE HOTBAR FROM SAVE
# -----------------------------------------------------
func restore_hotbar_slots(saved_slots: Array):
	for i in range(9):
		var id = saved_slots[i]

		if id == "" or id == null:
			# empty slot
			slot_items[i] = ""
			slot_locked[i] = false
			slot_labels[i].text = ""
			slots[i].texture_normal = null
		else:
			# Restore slot
			slot_items[i] = id
			slot_locked[i] = true
			slot_labels[i].text = id  # or use database for item names
			# If you have an icon DB, assign texture here
