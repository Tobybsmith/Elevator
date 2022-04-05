extends Area2D

signal picked_up_item(item)

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("Root").get_node("Player")
	connect("picked_up_item", player, "picked_up_item")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Coffee_body_entered(body):
	if(body.name == "Player"):
		emit_signal("picked_up_item", "coffee")
		self.queue_free()
