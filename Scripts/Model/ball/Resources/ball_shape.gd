class_name BallShape
extends Polygon2D

@export_range(8, 128, 1) var segments: int = 32

func change_color(new_color : Color) -> void: 
    color = new_color

func change_radius(new_radius : float) -> void: 
    var aux_color = color

    var pts: PackedVector2Array = PackedVector2Array()
    for i in range(segments):
        var a := TAU * float(i) / float(segments)
        pts.append(Vector2(cos(a), sin(a)) * new_radius)
    polygon = pts
    color = aux_color

    print("[Shape] change_radius(", new_radius, ") pts=", pts.size())