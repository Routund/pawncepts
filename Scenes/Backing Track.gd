extends AudioStreamPlayer
@onready var customer = get_node("../CanvasLayer/Customer")
var fade = false
var setValue = -18.297
# Called when the node enters the scene tree for the first time.
func _ready():
	setValue=volume_db
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(customer.customer_enter and !playing):
		play()
		volume_db=setValue
	if fade:
		volume_db-=0.51
		if volume_db<-35:
			stop()
			fade = false
	pass


func _on_node_2d_shop_end(rev, exp):
	fade=true
	pass # Replace with function body.
