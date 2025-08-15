extends Level
var in_npc_area = false
var e_disabled = false

func _process(_delta: float) -> void:
	super(_delta)
	if in_npc_area and !e_disabled:
		$ControlGuide/e.show()
	else:
		$ControlGuide/e.hide()
	if in_npc_area and Input.is_action_just_pressed("interact") and !e_disabled:
		e_disabled = true
		if in_npc_area and Input.is_action_just_pressed("interact"):
			if Globals.disabled:
				$NPC/Control.show()
				$NPC/Control/Character.text = 'Cybersecurity Employee'
				$NPC/Control/Dialogue.text = "I think those gunshots may have been a signal."
				await get_tree().create_timer(1).timeout
				await $NPC.advance
				
				$NPC/Control/Dialogue.text = "I also noticed the security system on the third floor seems to have been weakened somewhat."
				await $NPC.advance
				$NPC/Control/Dialogue.text = "I'll stay here just in case. Disabling the missiles should be fairly straightforward."
				await $NPC.advance
				$NPC/Control.hide()
			elif Globals.l2npcknows and !Globals.story_change:
				$NPC/Control.show()
				$NPC/Control/Character.text = 'Cybersecurity Employee'
				$NPC/Control/Dialogue.text = "If you go to the third floor, the security team will undoubtedly kill you..."
				await get_tree().create_timer(1).timeout
				await $NPC.advance
				$NPC/Control/Dialogue.text = "They have no idea what they're protecting..."
				await $NPC.advance
				$NPC/Control/Dialogue.text = "Maybe if they knew what was going on they wouldn't stop us."
				await $NPC.advance
				$NPC/Control.hide()
			elif !Globals.story_change:
				$NPC/Control.show()
				$NPC/Control/Character.text = 'Cybersecurity Employee'
				$NPC/Control/Dialogue.text = 'Who are you?'
				await $NPC.advance
				$NPC/Control.hide()
				await get_tree().create_timer(.5).timeout
				$NPC/Control.show()
				$NPC/Control/Dialogue.text = 'Who are you?'
				$NPC/Control/Options/Option1.show()
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				$NPC/Control/Options/Option1.text = "How do I stop the missile launch?"
				await $NPC.choice
				$NPC/Control/Options/Option1.hide()
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				$NPC/Control/Dialogue.text = "Wha... Missile launch? There's no missile launch..."
				await $NPC.advance
				$NPC/Control.hide()
				await get_tree().create_timer(1).timeout
				$NPC/Control.show()
				$NPC/Control/Dialogue.text = "Wait... there is a missile launch!"
				await $NPC.advance
				$NPC/Control/Dialogue.text = 'This is a problem...'
				await $NPC.advance
				$NPC/Control/Dialogue.text = 'The only way to control the missiles is through an airgapped server on the fourth floor.'
				await $NPC.advance
				$NPC/Control/Dialogue.text = 'And getting to the fourth floor requires getting through the security floor.'
				await $NPC.advance
				$NPC/Control/Dialogue.text = "I can't move away from this desk or security will be notified..."
				await $NPC.advance
				$NPC/Control/Dialogue.text += "\nYou'll need to figure out some way to stop the security team." 
				await $NPC.advance
				$NPC/Control.hide()
				Globals.l2npcknows = true
			elif Globals.story_change and !Globals.l2npcknows:
				$NPC/Control.show()
				$NPC/Control/Character.text = 'Cybersecurity Employee'
				$NPC/Control/Dialogue.text = 'Who are you?'
				await $NPC.advance
				$NPC/Control.hide()
				await get_tree().create_timer(.5).timeout
				$NPC/Control.show()
				$NPC/Control/Dialogue.text = 'Who are you?'
				$NPC/Control/Options/Option1.show()
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				$NPC/Control/Options/Option1.text = "How do I stop the missile launch?"
				await $NPC.choice
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				$NPC/Control/Options/Option1.hide()
				$NPC/Control/Dialogue.text = 'The only way to control the missiles is through an airgapped server on the fourth floor.'
				await $NPC.advance
				$NPC/Control/Dialogue.text = 'And getting to the fourth floor requires getting through the security floor.'
				await $NPC.advance
				$NPC/Control/Dialogue.text = "I can't move away from this desk or security will be notified..."
				await $NPC.advance
				$NPC/Control/Dialogue.text += "\nYou'll need to figure out some way to stop the security team." 
				await $NPC.advance
				$NPC/Control.hide()
				Globals.l2npcknows = true
			elif Globals.story_change:
				$NPC/Control.show()
				$NPC/Control/Character.text = 'Cybersecurity Employee'
				$NPC/Control.show()
				$NPC/Control/Character.text = 'Cybersecurity Employee'
				$NPC/Control/Dialogue.text = "Did you leak the story to the media?"
				await get_tree().create_timer(1).timeout
				await $NPC.advance
				$NPC/Control/Dialogue.text = "That's actually pretty clever..."
				await $NPC.advance
				$NPC/Control/Dialogue.text = "With any luck, someone on the security team will notice and let us in."
				await $NPC.advance
				$NPC/Control.hide()
			e_disabled = false
		if in_npc_area or player_in_elevator_area:
			$ControlGuide/e.show()
		if player_in_elevator_area and $elevator/AnimationPlayer.is_playing():
			$ControlGuide/e.hide()

func _ready() -> void:
	super()
	$NPC/Mesh.get_active_material(0).set("albedo_color", Color(0,0,1))

func _on_npc_area_body_entered(_body: Node3D) -> void:
	in_npc_area = true

func _on_npc_area_body_exited(_body: Node3D) -> void:
	in_npc_area = false
