extends Node2D

@export var keep_global_horizontal := true

@onready var label : Label = $Label
var life : int 

func _process(_delta: float) -> void:
	var ball = get_parent()
	life = ball.life
	
	label.text = str(life)
	
	if keep_global_horizontal:
		global_rotation = 0.0
	
