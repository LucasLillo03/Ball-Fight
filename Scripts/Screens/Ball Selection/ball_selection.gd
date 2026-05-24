class_name BallSelection
extends Control

@onready var grid = $VBoxContainer/GridContainer
@onready var title = $VBoxContainer/Label

var state_machine : SelectorStateMachine
var ballA : Ball
var ballB: Ball

var ability_buttons : Array[Button]
var selected_abilities : Array[Ability]

func _ready() -> void:
	state_machine = SelectorStateMachine.new(self)
	
	for ability in BallContext.abilities:
		var current_ability = ability.new()
		var button = Button.new()
		
		var button_toggled = func(toggled : bool) : 
			if toggled : selected_abilities.append(current_ability)
			else: selected_abilities.erase(current_ability)
		
		button.text = current_ability.get_ablity_name()
		button.toggle_mode = true
		
		button.toggled.connect(button_toggled)
		
		grid.add_child(button)
		
		ability_buttons.append(button)

func finalize_selection() -> void: 
	var map_scene = preload("res://Scenes/Map.tscn")
	var map = map_scene.instantiate()
		
	print(ballA, ballB)
	GameState.ball_a_scene = ballA
	GameState.ball_b_scene = ballB
		
	get_tree().change_scene_to_packed(map_scene) 

func _on_back_pressed() -> void:
	state_machine.back()

func _on_confirm_pressed() -> void:
	state_machine.confirm()
