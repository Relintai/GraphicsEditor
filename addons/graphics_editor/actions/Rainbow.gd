extends GEAction
class_name GERainbow


func do_action(canvas, data: Array):
	.do_action(canvas, data)
	
	var pixels = GEUtils.get_pixels_in_line(data[0], data[1])
	for pixel in pixels:
		if pixel in action_data.undo.cells:
			var color = GEUtils.random_color()
			canvas.set_pixel_v(pixel, color)
			
			var idx = action_data.redo.cells.find(pixel)
			action_data.redo.cells.remove(idx)
			action_data.redo.colors.remove(idx)
			
			action_data.redo.cells.append(pixel)
			action_data.redo.colors.append(color)
			continue
		
		action_data.undo.colors.append(canvas.get_pixel_v(pixel))
		action_data.undo.cells.append(pixel)
		
		var color = GEUtils.random_color()
		canvas.set_pixel_v(pixel, color)
	
		action_data.redo.cells.append(pixel)
		action_data.redo.colors.append(color)


func commit_action(canvas):
	var cells = action_data.redo.cells
	var colors = action_data.redo.colors
	return []


func undo_action(canvas):
	var cells = action_data.undo.cells
	var colors = action_data.undo.colors
	print(action_data.keys())
	for idx in range(cells.size()):
		canvas._set_pixel_v(action_data.layer, cells[idx], colors[idx])


func redo_action(canvas):
	var cells = action_data.redo.cells
	var colors = action_data.redo.colors
	for idx in range(cells.size()):
		canvas._set_pixel_v(action_data.layer, cells[idx], colors[idx])



