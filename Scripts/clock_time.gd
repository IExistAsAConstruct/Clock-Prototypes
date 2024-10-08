extends Node2D
var hourRotation:float = 0.0
var minuteRotation:float = 0.0
var trueHours:float = 0.0
@onready var root:Node = get_parent().get_parent()
const hourRadians:float = PI/6
const minuteRadians:float = PI/30
const SMOOTHNESS:float = 5.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var hour:float = root.get_node("TimeControl").get_hour()
	var minute:float = root.get_node("TimeControl").get_minute()
	var second:int = root.get_node("TimeControl").get_second()
	var secondInterval:int = root.get_node("TimeControl").get_second_interval()
	
	trueHours = hour + (minute / 60.0)
	
	var target_hour_rotation = trueHours * hourRadians
	var target_minute_rotation = (minute + second / 60.0) * minuteRadians
	#hourRotation = hourRadians * trueHours
	#minuteRotation = minuteRadians * minute
	
	hourRotation = lerp_angle(hourRotation, target_hour_rotation, delta * secondInterval + 0.1)
	minuteRotation = lerp_angle(minuteRotation, target_minute_rotation, delta * secondInterval + 0.1)
	get_node("HourHand").rotation = hourRotation
	get_node("MinuteHand").rotation = minuteRotation
