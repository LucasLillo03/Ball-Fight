class_name DefaultTakeDamageBehavior
extends TakeDamageBehavior

func take_damage(damage : int, ball : Ball) -> void: 
	ball.life -= damage
