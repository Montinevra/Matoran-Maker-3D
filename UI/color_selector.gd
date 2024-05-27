extends Control


signal part_selected(group_index: int, part_index: int)
signal color_selected(color, group_index, parts_list)

var _selected_part_group: int = 0


func select_part_group(index: int):
	$PartGroupSelector.select(index)
	_on_part_group_selector_item_selected(index)


func select_color(color: Color):
	_on_color_picker_color_changed(color)


func set_color_picker_color(color: Color):
	$"ColorPicker".color = color


func _on_part_group_selector_item_selected(index):
	_selected_part_group = index
	part_selected.emit(_selected_part_group, 0)
	for i in $PartGroupSelector.get_child_count():
		var child = $PartGroupSelector.get_child(i)
		child.visible = index == i
		if child is ItemList:
			for j in child.item_count:
				child.select(j, false)


func _on_color_picker_color_changed(color):
	var child = $PartGroupSelector.get_child(_selected_part_group)
	var selected_parts: Array = []
	if child is ItemList:
		selected_parts = child.get_selected_items()
	emit_signal("color_selected", color, _selected_part_group, selected_parts)


func _on_part_selector_multi_selected(index, _selected):
	part_selected.emit(_selected_part_group, index)
