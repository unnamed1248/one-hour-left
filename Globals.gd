extends Node
var player_pos: Vector3
var first = true
var first_computer = true
var noti = false
var elevator = false
var level = 1
var leaked = false
var disabled = false
var l2npcknows = false
var l1_spoken_to = false
var story_change= false
var stop = false

#func _ready() -> void:
	#$AudioStreamPlayer.play()

func _process(_delta: float):
	if leaked and !stop:
		stop = true
		await get_tree().create_timer(300).timeout
		story_change = true
		await get_tree().create_timer(300).timeout
		$AudioStreamPlayer.play()
		disabled = true
		await get_tree().create_timer(10).timeout
		$AudioStreamPlayer.queue_free()
