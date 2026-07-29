class_name SelectBState
extends State

var ball_config : BallConfig

func start():
	parent.title.text = "Select Ball 2"
	ball_config = BallFactory.create_rand_config()


func back() -> void: 
	state_machine.set_state(SelectAState.new())

func confirm() -> void:
	for ability in parent.selected_abilities: 
		ball_config.add_ability(ability.new())
	
	for button in parent.ability_buttons: 
		button.button_pressed = false
	
	parent.ball_B_config = ball_config

	parent.finalize_selection()
