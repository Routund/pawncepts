extends TextureButton
@onready var parent = get_node("../../Letter")
@onready var text = get_node("../Label")
var is_button_pressed=false
signal letter
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_button_pressed and not is_pressed():
		# Button was pressed and is now released
		is_button_pressed = false
		parent.visible=false
		text.text = "
Dear Shopkeeper,

Congratulations on settling the outstanding bail charges for the shop! With this payment, you now officially own the pawn shop.

You're now authorized to run the business and make it your own. We're here to support you every step of the way.

Best wishes for your success as the new proprietor of your Uncle's Pawn Shop."
		letter.emit()
	elif is_pressed() and not is_button_pressed:
		# Button is pressed for the first time
		is_button_pressed = true
	pass
