extends TextureRect

var goLeft=false
var goRight = false

@onready var Revenue = get_node("MarginContainer/VBoxContainer/HBoxContainer/Values/Revenue")
@onready var Rent = get_node("MarginContainer/VBoxContainer/HBoxContainer/Values/Rent")
@onready var Profits = get_node("MarginContainer/VBoxContainer/HBoxContainer/Values/Profits")
@onready var Expenses = get_node("MarginContainer/VBoxContainer/HBoxContainer/Values/Expenses")
var revValue=0
var rentValue=75
var profValue=0
var expValue=0
signal NewDay(rent:int)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(goRight):
		position.x+=delta*1800
		if(position.x>1153):
			position.x=1153
			goRight=false
			
	pass
	if(goLeft):
		position.x-=delta*1800
		if(position.x<0):
			position.x=0
			goLeft=false
			
	pass


func _on_node_2d_shop_end(rev,exp):
	goLeft=true
	Revenue.text="+" + str(rev)
	Expenses.text="-" + str(exp)
	Rent.text="-" + str(rentValue)
	if(rev-exp-rentValue<0):
		Profits.text=str(rev-exp-rentValue)
	else:
		Profits.text="+ " + str(rev-exp-rentValue)
	pass # Replace with function body.


func _on_next_button_n_day_pressed():
	goRight=true
	goLeft=false
	NewDay.emit(rentValue)
	pass # Replace with function body.
