extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y+=300*delta
	if(modulate.a==0):
		queue_free()
	else:
		modulate.a-=0.02
	pass
