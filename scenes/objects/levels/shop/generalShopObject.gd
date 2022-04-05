extends Node2D

var typeOfShop
var shop

# Called when the node enters the scene tree for the first time.
func _ready():
	#decide its type
	if(randi()%2 == 0):
		typeOfShop = "weapon"
	else:
		typeOfShop = "item"
	#instance the correct scene
	shop = load("res://scenes/objects/levels/shop/"+typeOfShop+"ShopObject.tscn").instance()
	self.add_child(shop)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
