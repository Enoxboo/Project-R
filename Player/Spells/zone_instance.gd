extends Node2D

@onready var timer: Timer = $Timer

var element: String
var active_time: float


func _ready():
	timer.wait_time = active_time
	timer.start()
	timer.timeout.connect(queue_free)
	for area_2D: Area2D in find_children("*", "Area2D"):
		area_2D.area_entered.connect(_on_wall_area_entered)
		area_2D.area_exited.connect(_on_wall_area_exited)


func _on_wall_area_entered(area: Area2D) -> void:
	ElementUtil.apply_element(area, element)


func _on_wall_area_exited(area: Area2D) -> void:
	ElementUtil.end_element(area, element)
