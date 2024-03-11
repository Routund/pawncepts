extends ScrollContainer

var inventory = []
@onready var Speech_manager = get_node("../Customer/Speech_bubble")
@onready var VBox = get_node("VBoxContainer")
# Called when the node enters the scene tree for the first time.
func _ready():
	visible=false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("Inventory"):
		visible=!visible
	pass


func _on_speech_bubble_sold(price):
	if(price>0):
		var item_scene = preload("res://Scenes/InventoryBox.tscn")
		var item_instance = item_scene.instantiate()
		item_instance.set("priceN",price)
		item_instance.set("item",Speech_manager.item)
		VBox.add_child(item_instance)
		inventory.append(item_instance)
	elif(price<0):
		inventory[Speech_manager.item_index].queue_free()
		inventory.pop_at(Speech_manager.item_index)
	pass # Replace with function body.
