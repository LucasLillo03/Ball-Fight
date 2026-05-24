class_name SelectAState
extends State

var ball : Ball

func start():
	parent.title.text = "Select Ball 1"
	ball = BallFactory.create_default()
	
func back() -> void: 
	parent.get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func confirm() -> void:
	for ability in parent.selected_abilities: 
		ball.add_ability(ability)
	
	for button in parent.ability_buttons: 
		button.button_pressed = false
	
	parent.ballA = ball
	state_machine.set_state(SelectBState.new())
