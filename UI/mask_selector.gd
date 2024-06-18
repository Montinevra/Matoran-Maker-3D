extends Panel

signal mask_scene_loaded(mask_scene)
signal mask_selected(index)

var icon_scene = preload("res://UI/mask_icon_3d.tscn")

func load_masks():
	const files = [
		"res://Parts/Kanohi/32565_miru.tscn",
		"res://Parts/Kanohi/32575_mahiki.tscn",
		"res://Parts/Kanohi/32569_akaku.tscn",
		"res://Parts/Kanohi/32575_matatu.tscn",
		"res://Parts/Kanohi/32571_kaukau.tscn",
		"res://Parts/Kanohi/32574_rau.tscn",
		"res://Parts/Kanohi/32505_hau.tscn",
		"res://Parts/Kanohi/32573_huna.tscn",
		"res://Parts/Kanohi/32566_pakari.tscn",
		"res://Parts/Kanohi/32567_ruru.tscn",
		"res://Parts/Kanohi/32568_kakama.tscn",
		"res://Parts/Kanohi/32572_komau.tscn",
	]
	
	for file in files:
		var icon = icon_scene.instantiate()
		var mask_scene = load(file)
		var mask = mask_scene.instantiate()
		var icon_texture = ViewportTexture.new()
		
		emit_signal("mask_scene_loaded", mask_scene)
		add_child(icon)
		icon.add_child(mask)
		icon_texture = icon.get_texture()
		$ItemList.add_icon_item(icon_texture)
	$ItemList.select(0)
	_on_item_list_item_selected(0)


func randomize_mask():
	var mask_index = randi_range(0, $ItemList.item_count - 1)
	
	emit_signal("mask_selected", mask_index)
	$ItemList.select(mask_index)


func _on_item_list_item_selected(index):
	emit_signal("mask_selected", index)
