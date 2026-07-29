class_name AbilitySystem 
extends RefCounted

var abilities : Array[Ability]
var updating_abilities : Array[Ability] #array de habilidades que requieren update
var parent : Ball

func _init() -> void:
	GameState.game_over.connect(dissable_abilities)

func setup(parent : Ball) -> void: 
	self.parent = parent

func update_abilities(delta : float) -> void: 
	for ability in updating_abilities: 
		ability.on_update(delta)

func add_ability(ability : Ability):
	abilities.append(ability)
	
	ability.setup(parent)
	
	if ability.requires_update:
		updating_abilities.append(ability)

func abilities_take_damage(damage_context : DamageContext) -> void:
	for ability in abilities:
		ability.on_take_damage(damage_context)
		
		if damage_context.cancelled: return 

func abilities_get_damage(amount : int, damage_context : DamageContext) -> int: 		
	for ability in abilities:
		amount = ability.get_damage(damage_context) 
		
		if damage_context.cancelled: return 0
		
	return amount

func abilities_properties() -> String: 
	var result := ""
	
	for ability in abilities: 
		result = result + "\n" + ability.get_property()
	
	return result

func dissable_abilities() -> void: 
	for ability in abilities: 
		ability.can_activate = false