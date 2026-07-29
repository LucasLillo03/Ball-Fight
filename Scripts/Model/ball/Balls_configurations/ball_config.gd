class_name BallConfig
extends Resource

var ball_name : String
var abilities : Array[Ability]
var speed_behavior : ClampSpeedBehavior
var radius : float
var color : Color
var damage : int

func add_ability(ability : Ability):
	abilities.append(ability)