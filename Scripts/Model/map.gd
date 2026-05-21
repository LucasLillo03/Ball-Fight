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

func _ready() -> void:
	spawn_ballA(GameState.ball_a_scene)
	spawn_ballB(GameState.ball_b_scene)

func _process(delta: float) -> void:
	if ballA: ballA_properties.text = ballA.get_properties()
	if ballB: ballB_properties.text = ballB.get_properties()
	
func spawn_ballA(ball : Ball) -> void: 	
	ballA = ball
	
	add_child(ballA)
	ballA.global_position = spawnA.global_position
	ballA.linear_velocity = Vector2(100,100)
	ballA.scenery = self
	balls.append(ballA)
	
	ballA_name.text = ballA.get_ball_name()
	
func spawn_ballB(ball : Ball) -> void: 
	ballB = ball
	
	add_child(ballB)
	ballB.global_position = spawnB.global_position
	ballB.linear_velocity = Vector2(-100,100)
	ballB.scenery = self
	balls.append(ballB)
	
	ballB_name.text = ballB.get_ball_name()
	
func ball_dead(ball : Ball) -> void: 
	balls.erase(ball)
	_game_over()
	
func _game_over() -> void:
	for ball in balls: 
		ball.game_over()
