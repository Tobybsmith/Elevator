extends Area2D

signal picked_up(weapon)

func _ready():
	var n = get_tree().get_root().get_node("Root").get_node("Player")
	connect("picked_up", n, "picked_up")

#sends to Player.gd
func _on_FistsDropped_body_entered(body):
	if(body.name == "Player"):
		emit_signal("picked_up", "fists")
		self.queue_free()
