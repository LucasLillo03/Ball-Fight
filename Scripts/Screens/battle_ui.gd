class_name BattleUI
extends CanvasLayer

@onready var ballA_name = $Names/BallAName
@onready var ballA_properties = $Properties/BallAProperties
@onready var ballB_name = $Names/BallBName
@onready var ballB_properties = $Properties/BallBProperties
@onready var game_over_ui = $GameOverPanel

var ballA : Ball
var ballB : Ball

func _init() -> void:
	GameState.game_over.connect(game_over)

func _process(delta: float) -> void:
	if ballA: ballA_properties.text = ballA.get_properties()
	if ballB: ballB_properties.text = ballB.get_properties()

func set_ball_A(ball : Ball) -> void:
	ballA = ball
	
	ballA_name.text = "Ball 1"
	ballA_name.label_settings.font_color = ball.stats.color

func set_ball_B(ball : Ball) -> void:
	ballB = ball

	ballB_name.text = "Ball 2"
	ballB_name.label_settings.font_color = ball.stats.color

func game_over() -> void: 
	game_over_ui.visible = true

func _on_retry_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/BallSelection.tscn")
	game_over_ui.visible = false


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
