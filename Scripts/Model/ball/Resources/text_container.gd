class_name TextContainer
extends Node2D

@export var keep_global_horizontal := true

@onready var label : Label = $Label

var text: 
	set(value): 
		text = value
		label.text = str(text)

func _process(_delta: float) -> void:	
	if keep_global_horizontal:
		global_rotation = 0.0
