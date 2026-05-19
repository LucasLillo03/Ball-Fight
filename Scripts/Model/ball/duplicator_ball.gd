class_name DuplicatorBall
extends Ball

@onready var ray = $CloneSpawnRay
@onready var timer = $Timer
@onready var crown = $Crown

const BOOST_FACTOR: float = 1.15   
const MAX_SPEED: float = 600.0   
const DAMAGE := 1
const COLOR := Color.DARK_MAGENTA
const CLONE_SCENE := preload("res://Scenes/Balls/Complements/DuplicatorClone.tscn")
const BALL_NAME := "DUPLICATOR"

var clones : Array

func _init() -> void:
	clamp_speed_behavior = AcceleratedAndLimited.new(BOOST_FACTOR, MAX_SPEED)
	color = COLOR
	damage = DAMAGE

func _on_ready() -> void:
	ray.target_position = Vector2(0.0, 50.0)
	

func _physics_process(delta: float) -> void:
	ray.rotate(0.1) 
	if clones.is_empty(): crown.visible = false
	else: crown.visible = true

func game_over() -> void:
	super.game_over()
	timer.stop()
	for clone in clones: 
		if clone: clone.game_over()

func _on_timer_timeout() -> void:
	spawn_clone()
	timer.start()

func spawn_clone():
	if !ray.is_colliding():
		var clone = CLONE_SCENE.instantiate()
		clone.setup(self)
		clones.append(clone)
		
		var spawn_pos = ray.to_global(ray.target_position)
		
		add_child(clone)
		clone.global_position = spawn_pos
		
		var dir = (spawn_pos - global_position).normalized()
		clone.linear_velocity = dir * 500.0

func get_ball_name() -> String: 
	return BALL_NAME

func get_properties() -> String: 
	var result := "Clones: " + str(clones.size())
	
	return result
