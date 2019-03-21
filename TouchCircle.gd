extends Node2D
#export (PackedScene) var Ball
# class member variables go here, for example:
export (int) var maxTime
var currentTime
var centerOfCircle

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	currentTime = OS.get_unix_time()

func updateCircle(time, center):
	currentTime = time
	centerOfCircle = center
	update()
	
func _draw():
	var point = get_viewport_rect().size
	var center = Vector2(point.x/2, point.y/2)
	var ratio = currentTime / maxTime
	print(ratio)
	if ratio < 1:
		var angle = (currentTime / maxTime) * 360
		var color = Color(1,1,1)
		draw_circle_arc_poly(centerOfCircle, 100, 0, angle, color, 10)
		
	
func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()

	for i in range(nb_points+1):
		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)


func draw_circle_arc_poly(center, radius, angle_from, angle_to, color, thickness):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	var colors = PoolColorArray([color])
	
	# draw outer arc
	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	# then draw another circle back towards the start with smaller radius
	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_to - i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * (radius - thickness))
	
	draw_polygon(points_arc, colors)


func remove():
	queue_free()
	