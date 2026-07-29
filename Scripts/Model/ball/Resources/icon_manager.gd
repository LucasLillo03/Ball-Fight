class_name IconManager
extends Node2D

@export var keep_global_horizontal := true
@export_range(0.1, 1.0)
var icon_ratio := 0.8

@onready var icon : Sprite2D = $Icon
@onready var ball : Ball = get_parent()

func _ready() -> void:

	icon.visible = false

	ball.stats.radius_changed.connect(update_icon_scale)

func _process(delta: float) -> void:

	if keep_global_horizontal:
		global_rotation = 0.0

func set_icon(texture : Texture2D) -> void:

	icon.texture = texture

	update_icon_scale()

func update_icon_scale() -> void:

	if icon.texture == null:
		return

	var texture_size = icon.texture.get_size()

	var target_size = ball.stats.radius * 2 * icon_ratio

	var scale_factor = target_size / max(
		texture_size.x,
		texture_size.y
	)

	icon.scale = Vector2.ONE * scale_factor

func show_icon() -> void:
	icon.visible = true

func hide_icon() -> void:
	icon.visible = false
