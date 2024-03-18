extends TextureRect

@onready var timer = get_node("../../../Store_timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation=2*PI-timer.time_left*(deg_to_rad(360/90))
	pass
