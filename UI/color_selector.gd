extends Control


signal part_selected(group_index: int, part_index: int)
signal color_selected(color, group_index, parts_list)

const MNOG_RED = Color("#b80000")			#Ta
const MNOG_ORANGE = Color("#e64d00")		#Ta, Onu
const MNOG_YELLOW = Color("#ffcb00")		#Ta
const MNOG_BLUE = Color("#005cb8")			#Ga
const MNOG_LIGHT_BLUE = Color("#4d99e6")	#Ga, Ko
const MNOG_DARK_BLUE = Color("#003d5c")		#Ga
const MNOG_GREEN = Color("#006b00")			#Le
const MNOG_LIME_GREEN = Color("#6bb800")	#Le
const MNOG_TEAL = Color("#009071")			#Le
const MNOG_BROWN = Color("#6c3e1f")			#Po
const MNOG_TAN = Color("#c7a85c")			#Po, Onu
const MNOG_DARK_ORANGE = Color("#994d00")	#Po
const MNOG_BLACK = Color("#353535")			#Ta, Po, Onu, Ko
const MNOG_DARK_GREY = Color("#525252")		#Onu, Ko
const MNOG_PURPLE = Color("#5d005d")		#Onu
const MNOG_WHITE = Color("#fafafa")			#Ko
const MNOG_LIGHT_GREY = Color("#9e9e9e")	#Ko
const MNOG_SAND_BLUE = Color("#7aa7d5")		#Ko
const COLORS = [
	MNOG_GREEN,
	MNOG_WHITE,
	MNOG_BLUE,
	MNOG_RED,
	MNOG_BLACK,
	MNOG_BROWN,
	MNOG_LIME_GREEN,
	MNOG_LIGHT_GREY,
	MNOG_LIGHT_BLUE,
	MNOG_ORANGE,
	MNOG_DARK_GREY,
	MNOG_TAN,
	MNOG_TEAL,
	MNOG_SAND_BLUE,
	MNOG_DARK_BLUE,
	MNOG_YELLOW,
	MNOG_PURPLE,
	MNOG_DARK_ORANGE,
]
var _selected_part_group: int = 0


func _ready():
	for color in COLORS:
		var swatch = Swatch.new()
		
		$ColorPicker/Swatches.add_child(swatch)
		swatch.color = color
		swatch.custom_minimum_size = Vector2(32, 32)
		swatch.connect("swatch_selected", _swatch_selected)


func select_part_group(index: int):
	$PartGroupSelector.select(index)
	_on_part_group_selector_item_selected(index)


func select_color(color: Color):
	_on_color_picker_color_changed(color)


func set_color_picker_color(color: Color):
	$"ColorPicker".color = color


func randomize_colors():
	for part_group in $PartGroupSelector.item_count:
		var color = COLORS.pick_random()
		if part_group == _selected_part_group:
			set_color_picker_color(color)
			select_all_parts(part_group)
		_select_color(color, part_group)


func select_all_parts(index):
	var part = $PartGroupSelector.get_child(index)
	
	part.visible = index == _selected_part_group
	if part is ItemList:
		for j in part.item_count:
			part.select(j, false)


func _on_part_group_selector_item_selected(index):
	_selected_part_group = index
	part_selected.emit(_selected_part_group, 0)
	for i in $PartGroupSelector.get_child_count():
		select_all_parts(i)


func _on_color_picker_color_changed(color):
	_select_color(color, _selected_part_group)


func _select_color(color, part_group):
	var parts = $PartGroupSelector.get_child(part_group)
	var selected_parts: Array = []
	
	if parts is ItemList:
		selected_parts = parts.get_selected_items()
	emit_signal("color_selected", color, part_group, selected_parts)


func _on_part_selector_multi_selected(index, _selected):
	part_selected.emit(_selected_part_group, index)


func _swatch_selected(color):
	set_color_picker_color(color)
	_on_color_picker_color_changed(color)
