extends TextureRect

@onready var timer = get_node("../../../Store_timer")
var clockFinished=false
var started = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	rotation=2*PI-timer.time_left*(deg_to_rad(360/120))
	if(timer.time_left==0 and not clockFinished) and started:
		get_node("../Tick").stop()
		get_node("../Ring").play()
		clockFinished=true
		started=false
	pass


func _on_texture_button_letter():
	get_node("../Tick").play()
	clockFinished=false
	started=true
	pass # Replace with function body.

func _on_day_end_panel_new_day(_rent):
	get_node("../Tick").play()
	clockFinished=false
	started=true
	pass # Replace with function body.
