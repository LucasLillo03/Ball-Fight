class_name Map
extends Node2D

@onready var spawnA = $SpawnA
@onready var spawnB = $SpawnB
@onready var ballA_name = $CanvasLayer/Names/BallAName
@onready var ballA_properties = $CanvasLayer/Properties/BallAProperties
@onready var ballB_name = $CanvasLayer/Names/BallBName
@onready var ballB_properties = $CanvasLayer/Properties/BallBProperties

var ballA: Ball
var ballB: Ball
var balls: Array

const LAUNCH_VELOCITY := 200

func _ready() -> void:
	spawn_ballA(GameState.ball_a_scene)
	spawn_ballB(GameState.ball_b_scene)

func _process(delta: float) -> void:
	if ballA: ballA_properties.text = ballA.get_properties()
	if ballB: ballB_properties.text = ballB.get_properties()
	
func spawn_ballA(ball : Ball) -> void: 	
		
	ballA = ball
	ballA.global_position = spawnA.global_position
	ballA.linear_velocity = Vector2(LAUNCH_VELOCITY,LAUNCH_VELOCITY)
	ballA.scenery = self
	
	var ball_dead = func():
		ballA.queue_free()
		_game_over()
	
	ballA.i_die.connect(ball_dead)	
	
	add_child(ballA)
	
	balls.append(ballA)
	
	ballA_name.text = ballA.get_ball_name()
	ballA_name.label_settings.font_color = ballA.color
	
func spawn_ballB(ball : Ball) -> void: 
	ballB = ball
	
	ballB.global_position = spawnB.global_position
	ballB.linear_velocity = Vector2(-LAUNCH_VELOCITY,LAUNCH_VELOCITY)
	ballB.scenery = self
	
	var ball_dead = func():
		ballB.queue_free()
		_game_over()
	
	ballB.i_die.connect(ball_dead)	
	
	add_child(ballB)
	
	balls.append(ballB)
	
	ballB_name.text = ballB.get_ball_name()
	ballB_name.label_settings.font_color = ballB.color
	
func _game_over() -> void:
	for ball : Ball in balls: 
		ball.freeze = true
