extends VBoxContainer

onready var list = $Lista

func update_inventario( fazenda, inv ):
	for i in range(0, list.get_child_count()):
		list.get_child(i).queue_free()
	
	for i in range( inv.size() ):
		var label = Label.new()
		if fazenda.curr_item_index == i: 
			label.text = "-> " + inv[i].get_name()
		else:
			label.text = inv[i].get_name()
		label.align = Label.ALIGN_RIGHT
		list.add_child(label)
