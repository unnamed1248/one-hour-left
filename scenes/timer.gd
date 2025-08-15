extends Timer
var minutes_left: String 
var seconds_left 

func _on_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/gameover.tscn")

func _process(_delta: float) -> void:
	minutes_left = str(int(GlobalTimer.time_left/60))
	while len(minutes_left) != len("00"):
		minutes_left = "0" + minutes_left
	seconds_left = str(int(GlobalTimer.time_left)%60)
	while len(seconds_left) != len("00"):
		seconds_left = "0" + seconds_left
