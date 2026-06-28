extends RefCounted

const BOUND_SOUND = preload("res://Assets/Sounds/ball_sound.wav")
const BOOST_FACTOR := 1.50 

const MIN_INITIAL_RADIUS := 20.0
const MAX_INITIAL_RADIUS := 50.0

const MIN_INITIAL_LIFE := 50
const MAX_INITIAL_LIFE := 500

const MIN_INITIAL_VELOCITY := 500.0
const MAX_INITIAL_VELOCITY := 1000.0

const MIN_BASE_DAMAGE := 1
const MAX_BASE_DAMAGE := 10

enum TAG { 
	DAMAGE_BROCKER,
	BALL_CREATOR
}
