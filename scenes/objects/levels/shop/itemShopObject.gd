extends Node2D

var price = 10
#get pulled from a list of shop pool items
var item
var content

# Called when the node enters the scene tree for the first time.
func _ready():
	item = get_parent().get_node("ShopPool").pool[randi()%get_parent().get_node("ShopPool").pool.size()]
	#load a random item into the shop content
	#just make it coffee for now
	content = load("res://scenes/objects/passive/dropped_items/"+item+"_dropped.tscn").instance()
	#player cannot just pick up the coffee
	content.monitoring = false

func _physics_process(delta):
	for body in get_node("ShopObjectCollider").get_overlapping_bodies():
		if(body.name == "Player" and Input.is_action_just_pressed("interact")):
			if(body.money >= price):
				body.money -= price
				body.picked_up_item(item)
				self.queue_free()

