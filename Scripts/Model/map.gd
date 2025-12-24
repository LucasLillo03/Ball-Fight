class_name Map
extends Node2D

@onready var spawnA = $SpawnA
@onready var spawnB = $SpawnB

var ballA: Ball
var ballB: Ball
var balls: Array

func _ready() -> void:
	spawn_ballA(GameState.ball_a_scene)
	spawn_ballB(GameState.ball_b_scene)
	
func spawn_ballA(scene : PackedScene) -> void: 	
	ballA = scene.instantiate()
	
	add_child(ballA)
	ballA.global_position = spawnA.global_position
	ballA.linear_velocity = Vector2(100,100)
	ballA.scenery = self
	balls.append(ballA)
	
func spawn_ballB(scene : PackedScene) -> void: 
	ballB = scene.instantiate()
	
	add_child(ballB)
	ballB.global_position = spawnB.global_position
	ballB.linear_velocity = Vector2(-100,100)
	ballB.scenery = self
	balls.append(ballB)
	
func ball_dead(ball : Ball) -> void: 
	balls.erase(ball)
	_game_over()
	
func _game_over() -> void:
	for ball in balls: 
		ball.game_over()
