class_name SelectBState
extends State

func start():
	parent.title.text = "Select Ball 2"

func back() -> void: 
	state_machine.set_state(SelectAState.new())

func confirm() -> void:
	parent.ballB = parent.selected_ball
	parent.finalize_selection()
