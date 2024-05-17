extends Control


signal part_selected(index)
signal color_selected(color, index)

var _selected_parts: int = 0


func main_ready():
	$PartSelector.select(0)
	_on_part_selector_item_selected(0)
	_on_color_picker_color_changed(Color("bcbcbc"))


func set_color_picker_color(color):
	$"ColorPicker".color = color


func _on_part_selector_item_selected(index):
	_selected_parts = index
	emit_signal("part_selected", _selected_parts)


func _on_color_picker_color_changed(color):
	emit_signal("color_selected", color, _selected_parts)
