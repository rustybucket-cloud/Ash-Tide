extends Node

var _game_time = 0
var game_time:
	get:
		return _game_time

var DAY_LENGTH = 60 * 10 # 10 minutes
var FULL_DAY_LENGTH = 60 * 60 * 24
var time_scale = FULL_DAY_LENGTH / DAY_LENGTH

var state_manager : Node

func init(sm : Node) -> void:
	state_manager = sm


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if state_manager == null:
		return
	
	if state_manager.state != state_manager.State.RUNNING:
		return
	
	var new_time = _game_time + delta * time_scale
	_game_time = int(new_time)
