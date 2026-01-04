extends Label

var time_manager

func _ready() -> void:
	time_manager = get_tree().get_first_node_in_group("time_manager")


func _process(delta: float) -> void:
	if time_manager == null:
		time_manager = get_tree().get_first_node_in_group("time_manager")
		return
	text = _get_24_hour_time()


var SECONDS_PER_DAY = 3600
func _get_24_hour_time() -> String:
	var game_time = get_tree().get_first_node_in_group("time_manager").game_time
	var hours = (game_time / SECONDS_PER_DAY) % 24
	var minutes = (game_time % SECONDS_PER_DAY) / 60
	return "%02d:%02d" % [hours, minutes]
