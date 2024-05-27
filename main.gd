extends Node3D

@export var _default_color: Color = Color("bcbcbc")
var _masks:Array[Node] = []
var _current_mask: int = 0

@onready var _parts = [
	_masks,
	[$"32577-Tohunga Torso", $"40507-Tohunga Disc Throwing Arm", $"32578-Tohunga Claw Arm"],
	[$"32576-Tohunga Right Foot", $"32576-Tohunga Left Foot"],
]


func _ready():
	$UI/MaskSelector.load_masks()
	$UI/ColorSelector.select_part_group(0)
	$UI/ColorSelector.select_color(_default_color)
	_masks[0].show()


func _on_color_selector_color_selected(color, group_index, parts_list):
	if parts_list:
		for part in parts_list:
			for i in range(_parts[group_index][part].mesh.get_surface_count()):
				_parts[group_index][part].mesh.surface_get_material(i).albedo_color = color
	else:
		for part in _parts[group_index]:
			for i in range(part.mesh.get_surface_count()):
				part.mesh.surface_get_material(i).albedo_color = color


func _on_color_selector_part_selected(group_index, part_index):
	var part_color = _parts[group_index][part_index].mesh.surface_get_material(0).albedo_color

	$UI/ColorSelector.set_color_picker_color(part_color)


func _on_mask_selector_mask_scene_loaded(mask_scene):
	var mask = mask_scene.instantiate()
	
	add_child(mask)
	mask.global_position = $"32579-Tohunga Skull/MaskAttachPoint".global_position
	mask.hide()
	_masks.append(mask)


func _on_mask_selector_mask_selected(index):
	_masks[_current_mask].hide()
	_current_mask = index
	_masks[_current_mask].show()

