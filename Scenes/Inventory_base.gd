extends Control

@export var priceN=0

@onready var name_node = get_node("HBoxContainer/Name")
@onready var price_node = get_node("HBoxContainer/Price")
@onready var image_node = get_node("HBoxContainer/Icon")
@onready var desc_node = get_node("HBoxContainer/Description")
# Called when the node enters the scene tree for the first time.
func _ready():
	price_node.text= "$" + str(priceN)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
