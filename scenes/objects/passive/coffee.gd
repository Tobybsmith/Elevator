extends Node

#coffee increases the player's max speed and speed by a small amount
onready var player = get_tree().get_root().get_node("Root").get_node("Player")

func _ready():
	pass

#on pickup, we are going to do the do_effect() function
func do_effect():
	player.MAX_SPEED *= 1.25
	player.speed *= 1.25
	#change the sword item to do 1.5x damage
	if(player.weapon.name == "sword"):
		player.weapon.coffee = true

#items are processed with a name system
#where in the affected thing, it looks through the nameList 
#on the relevant action, and changed behaviour based on
#whether or not that item exists
