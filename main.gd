extends Node3D

var _masks:Array[Node] = []
var _current_mask: int = 0

@onready var _parts = {
	0: _masks,
	1: [$"32577-Tohunga Torso", $"40507-Tohunga Disc Throwing Arm", $"32578-Tohunga Claw Arm"],
	2: [$"32576-Tohunga Foot", $"32576-Tohunga Foot2"],
}


func _ready():
	$UI/MaskSelector.main_ready()
	$UI/ColorSelector.main_ready()
	_masks[0].show()


func _on_color_selector_color_selected(color, index):
	for part in _parts[index]:
		for i in range(part.mesh.get_surface_count()):
			part.mesh.surface_get_material(i).albedo_color = color


func _on_color_selector_part_selected(index):
	var part_color = _parts[index][0].mesh.surface_get_material(0).albedo_color

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
