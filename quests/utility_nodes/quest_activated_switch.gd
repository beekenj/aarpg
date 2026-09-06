@tool
@icon("res://quests/utility_nodes/icons/quest_switch.png")
extends QuestNode
class_name QuestActivatedSwitch

enum CheckType {HAS_QUEST, QUEST_STEP_COMPLETE, ON_CURRENT_QUEST_STEP, QUEST_COMPLETE}

signal is_activated_changed(v: bool)

@export var check_type : CheckType = CheckType.HAS_QUEST : set = _set_check_type
@export var remove_when_activated : bool = false
@export var react_to_global_signal : bool = false

var is_activated : bool = false



func _ready() -> void:
	if Engine.is_editor_hint():
		return
	# remove tool icon
	$Sprite2D.queue_free()
	if react_to_global_signal == true:
		QuestManager.quest_updated.connect(_on_quest_updated)
	check_is_activated()




func _on_quest_updated(_q : Dictionary) -> void:
	check_is_activated()
	


func check_is_activated() -> void:
	# get the saved quest
	var _q : Dictionary = QuestManager.find_quest(linked_quest)
	
	if _q.title != "not found":
		if check_type == CheckType.HAS_QUEST:
			# we already passed this test, so we are done!
			set_is_activated(true)
		elif check_type == CheckType.QUEST_COMPLETE:
			# simply set is activated based on our quest complete values match
			var is_complete : bool = false
			if _q.is_complete is bool:
				is_complete = _q.is_complete
			set_is_activated(is_complete)
		elif check_type == CheckType.QUEST_STEP_COMPLETE:
			# 
			if quest_step > 0:
				set_is_activated(_q.completed_steps.has(get_step()) == true)
			else:
				set_is_activated(false)
		elif check_type == CheckType.ON_CURRENT_QUEST_STEP:
			var step : String = get_step()
			if step == "N/A":
				# no step, set false
				set_is_activated(false)
			else:
				set_is_activated(can_activate(_q))
	else:
		set_is_activated(false)


func can_activate(_q : Dictionary) -> bool:
	var step : String = get_step()
	var prev_step : String = get_prev_step()
	return (
		# return false if current step in completed steps array
		not _q.completed_steps.has(step.to_lower()) 
		and (
			# there is no previous step, must be on first step, return true
			prev_step == "N/A" or 
			# return true if previous step in completed steps array
			# since current step is not in the array
			_q.completed_steps.has(prev_step.to_lower()))
	)


func set_is_activated(_v : bool) -> void:
	is_activated = _v
	is_activated_changed.emit(_v)
	if is_activated == true:
		if remove_when_activated == true:
			hide_children()
		else: 
			show_children()
	else:
		if remove_when_activated == true:
			show_children()
		else: 
			hide_children()



func show_children() -> void:
	for c in get_children():
		c.visible = true
		c.process_mode = Node.PROCESS_MODE_INHERIT


func hide_children() -> void:
	for c in get_children():
		c.set_deferred("visible", false)
		c.set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)



func _set_check_type(v : CheckType) -> void:
	check_type = v
	update_summary()


func update_summary() -> void:
	if linked_quest == null:
		settings_summary = "Select a quest"
		return
	settings_summary = "UPDATE QUEST:\nQuest: " + linked_quest.title + "\n"
	if check_type == CheckType.HAS_QUEST:
		settings_summary += "Checking if player has quest"
	elif check_type == CheckType.QUEST_STEP_COMPLETE:
		settings_summary += "Checking if player has completed step: " + get_step()
	elif check_type == CheckType.ON_CURRENT_QUEST_STEP:
		settings_summary += "Checking if player is on step: " + get_step()
	elif check_type == CheckType.QUEST_COMPLETE:
		settings_summary += "Checking if quest is complete"
	
