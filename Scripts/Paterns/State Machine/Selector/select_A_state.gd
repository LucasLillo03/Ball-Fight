class_name SelectAState
extends State

func start():
	parent.title.text = "Select Ball 1"

func back() -> void: 
	parent.get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func confirm() -> void:
	if !parent.selected_ball: return
	parent.ballA = parent.selected_ball
	state_machine.set_state(SelectBState.new())
