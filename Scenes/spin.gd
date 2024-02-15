extends TextureButton

var price = 100
var sensitivity = 1.0
var mouse_pos
var start_angle = 0
var clockwise = false

func _ready():
	set_process_input(true)

func _process(delta):
	if is_pressed():
		var new_mouse_pos = get_global_mouse_position()
		var current_angle = (new_mouse_pos - global_position).angle()
		if mouse_pos != null:
			var angle_difference = current_angle - start_angle
			if abs(angle_difference) > 0.01: # Adjust the threshold as needed
				clockwise = angle_difference > 0
				if clockwise:
					price += sensitivity
				else:
					price -= sensitivity
				print("Price: ", price)
		mouse_pos = new_mouse_pos
		start_angle = current_angle

func _on_TextureButton_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			mouse_pos = get_global_mouse_position()
			start_angle = (mouse_pos - global_position).angle()
