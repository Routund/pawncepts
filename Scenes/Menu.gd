extends TextureRect

var inventory = []
@onready var Speech_manager = get_node("../Customer/Speech_bubble")
# Called when the node enters the scene tree for the first time.
func _ready():
	visible=false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Inventory"):
		visible=!visible
	pass
