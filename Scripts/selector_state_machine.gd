class_name SelectorStateMachine
extends Node

var current_satate : State 
var parent : BallSelection

func _init(parent : BallSelection) -> void:
	self.parent = parent
	current_satate = SelectAState.new()
	current_satate.parent = parent
	current_satate.state_machine = self
	current_satate.start()

func set_state(state : State) -> void:
	current_satate.end()
	
	current_satate = state
	
	current_satate.parent = parent
	current_satate.state_machine = self
	current_satate.start()

func back(): 
	current_satate.back()

func confirm(): 
	current_satate.confirm()
