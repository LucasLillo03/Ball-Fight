extends RigidBody2D
class_name Ball

@export var radius: float = 32.0
@export_range(8, 128, 1) var segments: int = 32
@export var color: Color
@export var life: int = 100
@export var damage: int
@export var ball_name := "SIMPLE BALL"
@export var max_speed : float

@onready var poly: Polygon2D = $Polygon2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var icon_manager := $IconManager

var bound_sound_player : AudioStreamPlayer2D = AudioStreamPlayer2D.new()

var clamp_speed_behavior : ClampSpeedBehavior
var abilities : Array[Ability]
var updating_abilities : Array[Ability]
var scenery : Map

const BOUND_SOUND = preload("res://Assets/Sounds/ball_sound.wav")
const BOOST_FACTOR := 1.15 

signal radius_changed

#set the attributes of a new ball
func setting(color : Color, radius : float, damage : int, life : int, clamp_speed : ClampSpeedBehavior) -> void: 
	self.color = color
	self.radius = radius
	self.damage = damage
	self.life = life
	self.clamp_speed_behavior = clamp_speed

func rand_stats() -> void:
	randomize()
	radius = randf_range(20.0, 50.0)
	damage = randi_range(1, 10)
	life = randi_range(50, 300)
	max_speed = randf_range(500.0, 1000.0)
	color = Color(randf(),randf(),randf())

func add_ability(ability : Ability):
	abilities.append(ability)
	
	ability.setup(self)
	
	if ability.requires_update:
		updating_abilities.append(ability)

func _ready() -> void:
	add_child(bound_sound_player)
	bound_sound_player.stream = BOUND_SOUND
	
	initialization()
	
	for ability in abilities: 
		ability.on_ready()
	
	z_index = 1

#initialize characteristics 
func initialization() -> void:
	update_visual()
	
	_update_collision()
	contact_monitor = true
	max_contacts_reported = 8
	body_entered.connect(_on_body_entered)

##TODO remake this from here 
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
##to here 

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("ball"):
		var ball : Ball = body
		
		var damage_context = DamageContext.new()
		damage_context.amount = ball.get_damage()
		
		take_damage(damage_context)
	else: 
		bound_sound_player.play()
	linear_velocity = clamp_speed_behavior.clamp_speed(linear_velocity)

func take_damage(ctx : DamageContext):
	for ability in abilities:
		ability.on_take_damage(ctx)
		
		if ctx.cancelled: return 
	
	life -= ctx.amount

func get_damage() -> int: 
	var amount := damage
	for ability in abilities:
		amount = ability.get_damage(damage) 
	
	return amount

func get_ball_name() -> String: 
	return ball_name

func get_properties() -> String:
	return str("Life: " , max(0, life), "\nDamage: ", damage, "\nMax speed: ", snapped(max_speed,0.01)) + abilities_properties()

func abilities_properties() -> String: 
	var result := ""
	
	for ability in abilities: 
		result = result + "\n" + ability.get_property()
	
	return result

#region set form
func update_visual() -> void:
	var pts: PackedVector2Array = PackedVector2Array()
	for i in range(segments):
		var a := TAU * float(i) / float(segments)
		pts.append(Vector2(cos(a), sin(a)) * radius)
	poly.polygon = pts
	poly.color = color

func _update_collision() -> void:
	var shape := CircleShape2D.new()
	shape.radius = radius
	collision.shape = shape

func set_color(new_color: Color) -> void:
	color = new_color
	if is_instance_valid(poly):
		poly.color = color
#endregion




	
