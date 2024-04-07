extends TextureRect

@onready var timer = get_node("../../../Store_timer")
var clockFinished=false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	rotation=2*PI-timer.time_left*(deg_to_rad(360/120))
	if(timer.time_left==0 and not clockFinished):
		get_node("../AudioStreamPlayer").stop()
	pass


func _on_texture_button_letter():
	get_node("../AudioStreamPlayer").play()
	pass # Replace with function body.
