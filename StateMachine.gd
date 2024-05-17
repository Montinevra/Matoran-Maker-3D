class_name StateMachine
extends Node


@onready var _state: State


func set_state(t_state):
	_state.exit()
	_state = get_node(t_state)
	_state.enter()
