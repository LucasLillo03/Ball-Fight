class_name Ball
extends RigidBody2D

@export var radius: float = 32.0
@export var color: Color
@export var life: int = 100
@export var damage: int
@export var ball_name := "SIMPLE BALL"
@export var max_speed : float

@export_range(8, 128, 1) var segments: int = 32
@onready var poly: Polygon2D = $Polygon2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var icon_manager := $IconManager

var bound_sound_player : AudioStreamPlayer2D = AudioStreamPlayer2D.new()

var clamp_speed_behavior : ClampSpeedBehavior
var scenery : Map

var ability_system: AbilitySystem

var movement_locked := false 
var gravity_locked := false

signal radius_changed
signal damage_blocked
signal i_die

func _init() -> void:
	GameState.game_over.connect(game_over_actions)
	ability_system = AbilitySystem.new()
	ability_system.setup(self)

#set the attributes of a new ball
func setting(color : Color, radius : float, damage : int, life : int, clamp_speed : ClampSpeedBehavior) -> void: 
	self.color = color
	self.radius = radius
	self.damage = damage
	self.life = life
	self.clamp_speed_behavior = clamp_speed

func rand_stats() -> void:
	randomize()
	
	radius = rand_radius()
	
	damage = randi_range(1, 10)
	
	color = Color(randf(),randf(),randf())
	
	_update_stats()

func rand_radius() -> float: 
	return randf_range(Constants.MIN_INITIAL_RADIUS, Constants.MAX_INITIAL_RADIUS)

func rand_damage() -> int: 
	return randi_range(Constants.MIN_BASE_DAMAGE, Constants.MAX_BASE_DAMAGE)

func _update_stats():
	#(MIN_INITIAL_RADIUS, MAX_INITIAL_RADIUS) -> (1.0, 100.0)
	var radius_to_percentage = func(x : float) -> float : return (1 + ((x - Constants.MIN_INITIAL_RADIUS) * 99) / (100 - Constants.MAX_INITIAL_RADIUS)) 
	#(1.0, 100.0) -> (MIN_INITIAL_LIFE, MAX_INITIAL_LIFE)
	var percentage_to_life = func(x : float) -> int: return floor(Constants.MIN_INITIAL_LIFE + ( (x-1) * (Constants.MAX_INITIAL_LIFE - Constants.MIN_INITIAL_LIFE) ) / 99)
	#(1.0, 100.0) -> (MIN_INITIAL_VELOCITY, MAX_INITIAL_VELOCITY)
	var percentage_to_speed = func(x : float) -> float: 
		var accumulated_initial_velocity = (Constants.MAX_INITIAL_VELOCITY + Constants.MIN_INITIAL_VELOCITY)
		var percentage_relation = (x-1) * (Constants.MAX_INITIAL_VELOCITY - Constants.MIN_INITIAL_VELOCITY)
		return accumulated_initial_velocity - (Constants.MIN_INITIAL_VELOCITY + percentage_relation / 99)
	 
	var transformed_radius : float = radius_to_percentage.call(radius)
	
	life = percentage_to_life.call(transformed_radius)
	
	max_speed = percentage_to_speed.call(transformed_radius)
	
	if clamp_speed_behavior: clamp_speed_behavior.set_max_speed(max_speed)


func _ready() -> void:
	add_child(bound_sound_player)
	bound_sound_player.stream = Constants.BOUND_SOUND
	
	initialization()
	
	for ability in ability_system.abilities: 
		ability.on_ready()
	
	z_index = 1
	
	_update_stats()

#initialize characteristics 
func initialization() -> void:
	update_visual()
	
	_update_collision()
	contact_monitor = true
	max_contacts_reported = 8
	body_entered.connect(_on_body_entered)
	
func _physics_process(delta: float) -> void:
	ability_system.update_abilities(delta)
	
	if movement_locked:
		linear_velocity = Vector2.ZERO
		angular_velocity = 0.0

	if gravity_locked:
		apply_central_force(-get_gravity() * mass)
		

func _process(delta: float) -> void:
	if is_dead(): 
		die()

#manages dead conditions
func is_dead() -> bool: 
	return life <= 0

#manages dead actions
func die() -> void: 
	i_die.emit()
		
	queue_free()

#executes the actions when the game ends
func game_over_actions() -> void: 
	freeze = true

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("ball"):
		var ball : Ball = body
		
		var damage_context = DamageContext.new()
		damage_context.amount = ball.get_damage()
		damage_context.source = body
		
		take_damage(damage_context)
	else: 
		bound_sound_player.play()
	linear_velocity = Vector2.ZERO if movement_locked else clamp_speed_behavior.clamp_speed(linear_velocity)

func take_damage(damage_context : DamageContext):
	ability_system.abilities_take_damage(damage_context)
	
	life -= damage_context.amount

func get_damage() -> int: 
	var amount := damage
	var damage_context = DamageContext.new()
	
	damage_context.amount = amount
		
	return ability_system.abilities_get_damage(amount, damage_context)

func get_ball_name() -> String: 
	return ball_name

func get_properties() -> String:
	return str("Life: " , max(0, life), "\nDamage: ", damage , ability_system.abilities_properties())



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

func set_radius(radius : float) -> void:
	self.radius = radius
	_update_stats()
#endregion

func get_config() -> BallConfig: 
	var config = BallConfig.new()
	
	config.ball_name = ball_name
	
	for ability in ability_system.abilities: 
		config.abilities.append(ability.get_copy())
	
	config.radius = radius
	config.speed_behavior = clamp_speed_behavior.get_copy() #TODO must be implemented
	config.color = color 
	config.damage = damage
	
	return config

func set_config(config : BallConfig) -> void: 
	clamp_speed_behavior = config.speed_behavior
	damage = config.damage
	set_color(config.color)
	set_radius(config.radius)
	
	for ability in config.abilities: 
		ability_system.add_ability(ability)
	
	ball_name = config.ball_name
