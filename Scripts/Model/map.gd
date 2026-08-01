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

	print("[Map] ", ballA.name, " pos=", ballA.global_position, " viewport=", get_viewport().get_visible_rect())
	
	balls_arr.append(ballA)
	
	battle_ui.set_ball_A(ballA)
	
func spawn_ballB(ball : Ball) -> void: 
	ballB = ball
	
	ballB.global_position = spawnB.global_position
	ballB.linear_velocity = Vector2(-LAUNCH_VELOCITY,LAUNCH_VELOCITY)
	ballB.scenery = self
	
	ballB.i_die.connect(_game_over)	
	
	add_child(ballB)
	print("[Map] ", ballB.name, " pos=", ballB.global_position, " viewport=", get_viewport().get_visible_rect())
	
	balls_arr.append(ballB)
	
	battle_ui.set_ball_B(ballB)

	
func _game_over() -> void:
	GameState.game_over.emit()
	battle_ui.game_over()
