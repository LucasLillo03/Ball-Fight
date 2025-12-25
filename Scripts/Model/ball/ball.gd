extends RigidBody2D
class_name Ball

@export var radius: float = 32.0
@export_range(8, 128, 1) var segments: int = 32
@export var color: Color
@export var life: int = 100
@export var damage: int

@onready var poly: Polygon2D = $Polygon2D
@onready var col: CollisionShape2D = $CollisionShape2D

var bound_sound_player : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
var take_damage_behavior : TakeDamageBehavior
var clamp_speed_behavior : ClampSpeedBehavior
var scenery : Map

const BOUND_SOUND = preload("res://Assets/Sounds/ball_sound.wav")
	
func _ready() -> void:
	add_child(bound_sound_player)
	bound_sound_player.stream = BOUND_SOUND
	initialization()
	_on_ready()

func _on_ready() -> void:
	pass

func initialization() -> void:
	_update_visual()
	_update_collision()
	contact_monitor = true
	max_contacts_reported = 8
	body_entered.connect(_on_body_entered)
	
func _process(delta: float) -> void:
	if is_dead(): 
		die()
	_on_process(delta)
		
func _on_process(delta : float) -> void: 
	pass
	
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
		bound_sound_player.play()
	linear_velocity = clamp_speed_behavior.clamp_speed(linear_velocity)

func get_damage() -> int: 
	return damage

func get_ball_name() -> String: 
	return "Ball"

func get_properties() -> String:
	return "this ball hasn't properties"

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




	
