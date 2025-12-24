class_name DuplicatorBall
extends Ball

@onready var ray = $CloneSpawnRay
@onready var timer = $Timer
@onready var crown = $Crown

const BOOST_FACTOR: float = 1.15   
const MAX_SPEED: float = 600.0   
const DAMAGE := 1
const cloneScene := preload("res://Scenes/Balls/DuplicatorClone.tscn")

var clones : Array

func _init() -> void:
	take_damage_behavior = ExclusiveTakeDamage.new(clones)
	clamp_speed_behavior = AcceleratedAndLimited.new(BOOST_FACTOR, MAX_SPEED)
	color = Color.DARK_MAGENTA
	damage = DAMAGE

func _ready() -> void:
	initialization()
	ray.target_position = Vector2(0.0, 50.0)
	

func _physics_process(delta: float) -> void:
	ray.rotate(0.1) 
	if clones.is_empty(): crown.visible = false
	else: crown.visible = true

func game_over() -> void:
	super.game_over()
	ray.enabled = false
	for clone in clones: 
		clone.game_over()

func _on_timer_timeout() -> void:
	spawn_clone()
	timer.start()

func spawn_clone():
	if !ray.is_colliding():
		var clone = cloneScene.instantiate()
		clone.setup(self)
		clones.append(clone)
		
		var spawn_pos = ray.to_global(ray.target_position)
		
		add_child(clone)
		clone.global_position = spawn_pos
		
		var dir = (spawn_pos - global_position).normalized()
		clone.linear_velocity = dir * 500.0
