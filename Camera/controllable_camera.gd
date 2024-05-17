extends Camera3D

const SENSE: float = 0.001
const MOVE_SPEED: float = 0.6
const SPRINT_FACTOR: float = 4.0
const MOVE_KEY: Dictionary = {
	KEY_W: Vector3.FORWARD,
	KEY_S: Vector3.BACK,
	KEY_A: Vector3.LEFT,
	KEY_D: Vector3.RIGHT,
	KEY_SPACE: Vector3.UP,
	KEY_C: Vector3.DOWN,
}


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta):
	var movement: Vector3 = Vector3(0, 0, 0)
	var sprint: float = 1
	
	for i in MOVE_KEY:
		if Input.is_key_pressed(i):
			movement += Vector3(MOVE_KEY.get(i))
	if Input.is_key_pressed(KEY_SHIFT):
		sprint = SPRINT_FACTOR
	elif Input.is_key_pressed(KEY_CTRL):
		sprint = 1 / SPRINT_FACTOR
	translate_object_local(movement * delta * MOVE_SPEED * sprint)


func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate(Vector3.DOWN, event.relative.x * SENSE)
		rotate_object_local(Vector3.LEFT, event.relative.y * SENSE)
	elif event.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
