extends AnimatedSprite2D
var keepBobbing=false
var t = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (keepBobbing or!(position.y>-42.3 and position.y<-42.1)):
		t+=4*delta
		position.y=80*sin(t)+2564.147
	pass

func reset():
	t=0
	keepBobbing=false
	position.y=+2564.147
