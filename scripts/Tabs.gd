extends TabBar




func _on_tab_changed(tab):
	update_tab(tab)


func update_tab(tab):
	for x in get_children():
		x.visible = false
	print(tab)
	print(get_tab_title(tab))
	get_node(get_tab_title(tab)).visible = true
