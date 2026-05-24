class_name DamageAccumulator
extends Ability

var accumulated_damage : int = 0 
var returned_percentage : float #(0,1]

func setup(ball) -> void:
	super(ball)
	ball.damage_blocked.connect(_on_blocked_damage)
	
func _init() -> void:
	ability_name = "Damage Acumulator"
	
func on_ready() -> void: 
	returned_percentage = randf_range(0.1, 1)

func get_damage(daamge_context : DamageContext) -> int: 
	var returned_damage = daamge_context.amount + accumulated_damage
	
	accumulated_damage = 0
	
	return returned_damage

func _on_blocked_damage(amount) -> void: 
	accumulated_damage += max(floor(amount * returned_percentage), 1)

func get_property() -> String: 
	return str("Accumulated Damage : ", accumulated_damage)
