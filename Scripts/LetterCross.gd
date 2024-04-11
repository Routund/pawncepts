extends TextureButton

var parent
var text
var is_button_pressed = false
var endGame =false
signal letter

# Duration of the fade-in effect in seconds
var fade_duration = 1.0
var fade_timer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_node("../../Letter")
	text = get_node("../Label")
	parent.visible = true
	parent.modulate.a=0
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_button_pressed and not is_pressed():
		# Button was pressed and is now released
		is_button_pressed = false
		text.visible = true
		text.text = "
Dear Shopkeeper,

Congratulations on settling the outstanding bail charges for the shop! With this payment, you now officially own the pawn shop.

You're now authorized to run the business and make it your own. We're here to support you every step of the way.

Best wishes for your success as the new proprietor of your Uncle's Pawn Shop."
		if(endGame):
			get_tree().change_scene_to_file("res://Scenes/Starting_Menu.tscn")
		letter.emit()
	elif is_pressed() and not is_button_pressed:
		# Button is pressed for the first time
		is_button_pressed = true
		fade_timer = 0.0
		parent.visible = false
		parent.modulate.a = 0.0  # Initially transparent

	# Fade-in effect
	if parent.visible:
		fade_timer += delta/2.5
		print(fade_timer)
		parent.modulate.a = min(fade_timer / fade_duration, 1.0)
