extends Level
var door_open = false
var in_computer_area = false

func _ready() -> void:
	super()

func _process(_delta: float) -> void:
	super(_delta)
	if player_in_elevator_area or in_computer_area:
		$ControlGuide/e.show()
	if player_in_elevator_area and $elevator/AnimationPlayer.is_playing():
		$ControlGuide/e.hide()
	if $AnimationPlayer.is_playing() and $AnimationPlayer.current_animation_length - $AnimationPlayer.current_animation_position > 2:
		$Player.velocity = Vector3.ZERO
		$ControlGuide/e.hide()
	if in_computer_area:
		$ControlGuide/e.show()
	if in_computer_area and Input.is_action_just_pressed("interact"):
		get_tree().change_scene_to_file('res://scenes/launch_system.tscn')
	
func _on_area_3d_body_entered(body: Node3D) -> void:
	if !Globals.disabled:
		$AnimationPlayer.play("kill")
		await get_tree().create_timer(4).timeout
		get_tree().change_scene_to_file("res://scenes/gameover.tscn")
	elif !door_open and body == $Player:
		await get_tree().create_timer($elevator/AnimationPlayer.current_animation_length - $elevator/AnimationPlayer.current_animation_position).timeout
		$AnimationPlayer.play('open_door')
		door_open = true


func _on_computer_area_body_entered(body: Node3D) -> void:
	in_computer_area = true
	print('enter')
	$ControlGuide/e.show()
	
func _on_computer_area_body_exited(body: Node3D) -> void:
	in_computer_area = false
	$ControlGuide/e.hide()
