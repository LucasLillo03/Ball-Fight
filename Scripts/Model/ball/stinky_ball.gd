class_name StinkyBall
extends Ball

@onready var trace_timer = $TraceTimer
@onready var hit_timer = $HitTimer

const BOOST_FACTOR: float = 1.15   
const MAX_SPEED: float = 800.0   
const COLOR := Color.FOREST_GREEN
const DAMAGE := 1
const BALL_NAME = "STINKY"
const TRACE_SCENE = preload("res://Scenes/Balls/Complements/StinkyTrace.tscn")

var trace : Array
var trace_damage : float = 1.0
var trace_collision : bool = true 

func _init() -> void:
	take_damage_behavior = DefaultTakeDamageBehavior.new()
	clamp_speed_behavior = AcceleratedAndLimited.new(BOOST_FACTOR, MAX_SPEED)
	color = COLOR
	damage = DAMAGE

func _on_trace_timer_timeout() -> void:
	leave_trace()
	trace_timer.start()

func leave_trace() -> void:
	var splatter = TRACE_SCENE.instantiate()
	splatter.setup(self, trace_collision)
	trace.append(splatter)
	
	scenery.add_child(splatter)
	splatter.global_position = global_position


func _cleanup_trace() -> void:
	trace = trace.filter(func(x): return is_instance_valid(x))

func _on_trace_color_timer_timeout() -> void:
	for splatter in trace: 
		if is_instance_valid(splatter): splatter.change_color()

func get_trace_damage() -> int: 
	return round(trace_damage)

func _on_hit_timer_timeout() -> void:
	trace_damage += 0.1
	trace_collision = !trace_collision
	for splatter in trace: 
		if is_instance_valid(splatter): splatter.change_state(trace_collision)

func get_ball_name() -> String: 
	return BALL_NAME

func get_properties() -> String: 
	var result := "im a dummy ball" 
	
	return result
