extends TextureButton

var calc_value = 0
@onready var base = get_node("../../Calculator")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("%s"%[calc_value])):
		base.addNum(calc_value)
	pass

func _pressed():
	base.addNum(calc_value)
