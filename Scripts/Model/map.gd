class_name Map
extends Node2D

@onready var spawnA = $SpawnA
@onready var spawnB = $SpawnB
@onready var battle_ui = $BattleUI

var ballA: Ball
var ballB: Ball
var balls_arr: Array

const LAUNCH_VELOCITY := 200

func _ready() -> void:
	spawn_ballA(GameState.ball_a_scene)
	spawn_ballB(GameState.ball_b_scene)
	
func spawn_ballA(ball : Ball) -> void: 	
		
	ballA = ball
	ballA.global_position = spawnA.global_position
	ballA.linear_velocity = Vector2(LAUNCH_VELOCITY,LAUNCH_VELOCITY)
	ballA.scenery = self
	
	ballA.i_die.connect(_game_over)	
	
	add_child(ballA)
	
	balls_arr.append(ballA)
	
	battle_ui.set_ball_A(ballA)
	
func spawn_ballB(ball : Ball) -> void: 
	ballB = ball
	
	ballB.global_position = spawnB.global_position
	ballB.linear_velocity = Vector2(-LAUNCH_VELOCITY,LAUNCH_VELOCITY)
	ballB.scenery = self
	
	ballB.i_die.connect(_game_over)	
	
	add_child(ballB)
	
	balls_arr.append(ballB)
	
	battle_ui.set_ball_B(ballB)

	
func _game_over() -> void:
	for ball : Ball in balls_arr: 
		ball.game_over_actions()
	battle_ui.game_over()
