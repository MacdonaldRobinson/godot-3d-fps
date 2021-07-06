extends Node

class_name Interactable

var interact_count: int = 0

func _ready():
	pass
	
func _process(delta):
	pass

func interact():
	interact_count+=1
	print("Interacted")
	pass
