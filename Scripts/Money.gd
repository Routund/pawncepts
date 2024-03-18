extends Label


# Called when the node enters the scene tree for the first time.
var balance=2500
@onready var sucess = get_node("Ka-Ching")

func _ready():
	text = "$" + str(balance)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_speech_bubble_sold(price):
	balance-=price
	text = "$" + str(balance)
	if(abs(price)>0):
		sucess.play()
		if(price<0):
			var instance = preload("res://Scenes/money_added.tscn")
			var item_instance = instance.instantiate()
			item_instance.set("text","+$"+str(abs(price)))
			add_child(item_instance)
		else:
			var instance = preload("res://Scenes/money_removed.tscn")
			var item_instance = instance.instantiate()
			item_instance.set("text","-$"+str(price))
			add_child(item_instance)
	pass # Replace with function body.


func _on_day_end_panel_new_day(rent):
	balance-=rent
	text = "$" + str(balance)
	pass # Replace with function body.
