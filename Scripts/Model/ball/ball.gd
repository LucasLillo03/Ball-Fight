extends RigidBody2D
class_name Ball

@export var radius: float = 32.0
@export_range(8, 128, 1) var segments: int = 32
@export var color: Color
@export var life: int = 100
@export var damage: int

@onready var poly: Polygon2D = $Polygon2D
@onready var col: CollisionShape2D = $CollisionShape2D
@onready var sound : AudioStreamPlayer2D = $AudioStreamPlayer2D

var take_damage_behavior : TakeDamageBehavior
var clamp_speed_behavior : ClampSpeedBehavior
var scenery : Map

	
func _ready() -> void:
	initialization()

func initialization() -> void:
	_update_visual()
	_update_collision()
	contact_monitor = true
	max_contacts_reported = 8
	body_entered.connect(_on_body_entered)
	
func _process(delta: float) -> void:
	if is_dead(): 
		die()

func die():
	scenery.ball_dead(self)
	queue_free()

func game_over() -> void:
	gravity_scale = 0.0
	linear_velocity = Vector2(0,0)

func is_dead() -> bool: 
	return life <= 0

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("harmful"):
		take_damage_behavior.take_damage(body, self)
	else: 
		sound.play()
	linear_velocity = clamp_speed_behavior.clamp_speed(linear_velocity)

func get_damage() -> int: 
	return damage

#region set form
func _update_visual() -> void:
	var pts: PackedVector2Array = PackedVector2Array()
	for i in range(segments):
		var a := TAU * float(i) / float(segments)
		pts.append(Vector2(cos(a), sin(a)) * radius)
	poly.polygon = pts
	poly.color = color

func _update_collision() -> void:
	var shape := CircleShape2D.new()
	shape.radius = radius
	col.shape = shape

func set_color(new_color: Color) -> void:
	color = new_color
	if is_instance_valid(poly):
		poly.color = color
#endregion




	
