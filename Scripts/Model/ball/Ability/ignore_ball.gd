class_name IgnoreBall
extends Ability

var ignored_balls : Array

func _init(arr : Array[Ball]) -> void:
	ignored_balls = arr

func on_take_damage(damage : DamageContext) -> int: 
	if ignored_balls.has(damage.source): 
		damage.cancelled = true
		
	return damage.amount 

func get_copy() -> Ability: 
	var copy_arr = ignored_balls 
	
	#NOTE
	# 1 - this references the same array for convenience but it could be: ignored_balls.duplicate() 
	# 2 - this ability is used only in creator abilities, for this reason don't needs sends the array by copy for now
	
	var copy = IgnoreBall.new(copy_arr)
	
	return copy
