class_name BallVisual
extends Node2D

var ball : Ball 

@onready var poly := $BallShape
@onready var icon_manager := $IconManager
@onready var text_container := $TextContainer

func _ready() -> void:
    ball = get_parent()
    ball.stats_changed.connect(stats_settings)

    stats_settings()    

    print("[Visual] ball=", ball.name,
      " in_tree=", ball.is_inside_tree(),
      " ball_pos=", ball.global_position,
      " poly_pts=", poly.polygon.size(),
      " poly_color=", poly.color,
      " poly_visible=", poly.visible,
      " poly_global=", poly.global_position)

func stats_settings() -> void: 
    ball.stats.color_changed.connect(change_color)
    ball.stats.radius_changed.connect(change_radius)
    ball.stats.life_changed.connect(change_life)

    update_visual(ball.stats.radius, ball.stats.color, ball.stats.life)

func change_color(new_color : Color) -> void: 
    poly.change_color(new_color)

func change_radius(new_radius : float) -> void: 
    poly.change_radius(new_radius)
    icon_manager.update_icon_scale(new_radius)

func update_visual(radius : float, color : Color, life : int) -> void:
    change_color(color)
    change_radius(radius)
    change_life(life)

func change_life(new_life : int) -> void: 
    text_container.text = new_life