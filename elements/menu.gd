class_name Menu extends PanelContainer


func close():
	hide()


func open():
	show()


func toggle():
	if is_visible_in_tree(): close()
	else: open()
