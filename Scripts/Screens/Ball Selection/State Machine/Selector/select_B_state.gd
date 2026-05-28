class_name SelectBState
extends State

var ball : Ball

func start():
	parent.title.text = "Select Ball 2"
	ball = BallFactory.create_default()


func back() -> void: 
	state_machine.set_state(SelectAState.new())

func confirm() -> void:
	for ability in parent.selected_abilities: 
		ball.add_ability(ability.new())
	
	for button in parent.ability_buttons: 
		button.button_pressed = false
	
	parent.ballB = ball

	parent.finalize_selection()
