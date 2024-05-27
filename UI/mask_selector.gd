extends Panel

signal mask_scene_loaded(mask_scene)
signal mask_selected(index)

var icon_scene = preload("res://UI/mask_icon_3d.tscn")

func load_masks():
	var path = "res://Parts/Kanohi/"
	var dir = DirAccess.open(path)
	
	for file in dir.get_files():
		var icon = icon_scene.instantiate()
		var mask_scene = load(path + file)
		var mask = mask_scene.instantiate()
		var icon_texture = ViewportTexture.new()
		
		emit_signal("mask_scene_loaded", mask_scene)
		add_child(icon)
		icon.add_child(mask)
		icon_texture = icon.get_texture()
		$ItemList.add_icon_item(icon_texture)
	$ItemList.select(0)
	_on_item_list_item_selected(0)


func _on_item_list_item_selected(index):
	emit_signal("mask_selected", index)
