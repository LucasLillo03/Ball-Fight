class_name BallSelection
extends Control

@onready var grid = $VBoxContainer/GridContainer
@onready var title = $VBoxContainer/Label

var balls := {
	DefaultBall : "Deafult ball",
	CriticalBall : "Critical ball"
}
var state_machine : SelectorStateMachine
var ballA : Ball
var ballB: Ball
var selected_ball : Ball
var ball_factory : BallFactory

func _ready() -> void:
	state_machine = SelectorStateMachine.new(self)
	ball_factory = BallFactory.new()
	
	for ball in balls:
		var button = Button.new()
		var button_call = func(): 
			selected_ball = ball.new()

		button.text = balls.get(ball)
		button.toggle_mode = true
		button.pressed.connect(button_call)
		
		grid.add_child(button)

func finalize_selection() -> void: 
	var map_scene = preload("res://Scenes/Map.tscn")
	var map = map_scene.instantiate()
	
	var ball_A_scene = ball_factory.create(ballA)
	var ball_b_scene = ball_factory.create(ballB)
	GameState.ball_a_scene = ball_A_scene
	GameState.ball_b_scene = ball_b_scene
	
	get_tree().change_scene_to_packed(map_scene) 

func _on_back_pressed() -> void:
	state_machine.back()


func _on_confirm_pressed() -> void:
	state_machine.confirm()
