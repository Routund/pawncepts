extends TextureRect

var goLeft=false
var goRight = false

@onready var Revenue = get_node("MarginContainer/VBoxContainer/HBoxContainer/Values/Revenue")
@onready var Rent = get_node("MarginContainer/VBoxContainer/HBoxContainer/Values/Rent")
@onready var Profits = get_node("MarginContainer/VBoxContainer/HBoxContainer/Values/Profits")
@onready var Expenses = get_node("MarginContainer/VBoxContainer/HBoxContainer/Values/Expenses")
@onready var money = get_node("../Label")
@onready var letter = get_node("../Letter")
var revValue=0
var rentValue=75
var profValue=0
var expValue=0
var paid = false
var days=0
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
	days+=1
	if(money.balance-rentValue>5000 and !paid):
		money.balance-=5000
		letter.visible=true
		paid = true
	elif (days==10):
		money.balance-=5000
		letter.visible=true
		letter.text="Dear Ctizen,

RE: Repossession of Pawn shop Due to Non-Payment of Bail Charges

We regret to inform you that, as of today, the pawn shop is being repossessed due to failure to pay outstanding bail charges.

Repossession proceedings will commence immediately. Please refrain from accessing the premises unlawfully.

For further information, please contact our office.
"
	else:
		NewDay.emit(rentValue)
	pass # Replace with function body.
