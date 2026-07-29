class_name SelectAState
extends State

var ball_config : BallConfig

func start():
	parent.title.text = "Select Ball 1"
	ball_config = BallFactory.create_rand_config()
	
func back() -> void: 
	parent.get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func confirm() -> void:
	for ability in parent.selected_abilities: 
		ball_config.add_ability(ability.new())
	
	for button in parent.ability_buttons: 
		button.button_pressed = false
	
	parent.ball_A_config = ball_config
	state_machine.set_state(SelectBState.new())
