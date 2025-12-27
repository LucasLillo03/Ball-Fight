extends Node

@export var radius: float = 32.0
@export_range(8, 128, 1) var segments: int = 32
@export var slowing_down := 1.5
@export var damage := 1

@onready var poly: Polygon2D = $Polygon2D
@onready var col: CollisionShape2D = $CollisionShape2D
@onready var hit_timer = $HitTimer


var color : Color
var parent : StinkyBall 
var life_timer : Timer
var first_trace_collision : bool

const LIFE_TIME := 1.0
const COLOR := Color.LIGHT_GREEN
const HIT_COLOR := Color.PALE_GREEN

func _ready() -> void:
	_update_visual()
	_update_collision()
	
	await get_tree().create_timer(LIFE_TIME).timeout
	queue_free()
	
func _process(delta: float) -> void:
	var current_color = COLOR if col.disabled else HIT_COLOR
	set_color(current_color)
	
func setup(parent : Ball, trace_collision : bool) -> void:
	self.parent = parent
	first_trace_collision = !trace_collision

func _update_visual() -> void:
	var pts: PackedVector2Array = PackedVector2Array()
	for i in range(segments):
		var a := TAU * float(i) / float(segments)
		pts.append(Vector2(cos(a), sin(a)) * radius)
	poly.polygon = pts
	poly.color = COLOR

func _update_collision() -> void:
	var shape := CircleShape2D.new()
	shape.radius = radius
	col.shape = shape
	col.disabled = first_trace_collision

func _on_body_entered(body: Node2D) -> void:
	if body is Ball && body != parent: 
		body.area_entered(self)
		body.linear_velocity /= slowing_down

func set_color(new_color: Color) -> void:
	color = new_color
	if is_instance_valid(poly):
		poly.color = color

func change_state(trace_collision : bool) -> void: 
	col.disabled = !trace_collision

func get_damage(): 
	return damage
