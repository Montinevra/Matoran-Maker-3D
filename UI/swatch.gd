class_name Swatch
extends ColorRect

signal swatch_selected(color)

func _gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:
		emit_signal("swatch_selected", color)
