extends Node
class_name StateManager

enum State { RUNNING, PAUSED }

var _state : State = State.RUNNING
var state : State:
	get:
		return _state


func pause() -> void:
	_state = State.PAUSED


func run() -> void:
	_state = State.RUNNING
