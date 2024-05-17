extends Node3D


const ORBIT_SPEED: float = 0.01
const PAN_SPEED: float = 0.1


func _unhandled_input(event):
	if Input.is_action_pressed("camera_orbit") and event is InputEventMouseMotion:
		rotation.y -= event.relative.x * ORBIT_SPEED
		rotation.x = clamp(rotation.x - event.relative.y * ORBIT_SPEED, -TAU/4, TAU/4)
	if Input.is_action_pressed("camera_pan") and event is InputEventMouseMotion:
		var movement = Vector3(-event.relative.x * PAN_SPEED, event.relative.y * PAN_SPEED, 0)
		translate_object_local(movement * PAN_SPEED)
	if Input.is_action_just_pressed("camera_zoom_in"):
		$Camera3D.position.z -= 0.5
	elif Input.is_action_just_pressed("camera_zoom_out"):
		$Camera3D.position.z += 0.5
	$Camera3D.position.z = clamp($Camera3D.position.z, 0.5, 20.0)


func _on_reset_camera_button_pressed():
	position = Vector3(0, 0, 0)
	rotation = Vector3(0, 0, 0)
	$Camera3D.position = Vector3(0, 0, 2)
