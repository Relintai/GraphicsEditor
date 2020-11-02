extends GEAction
class_name GEDarken

const dark_factor = 0.1


func do_action(canvas, data: Array):
	.do_action(canvas, data)
	
	var pixels = GEUtils.get_pixels_in_line(data[0], data[1])
	for pixel in pixels:
		if pixel in action_data.undo.cells:
			var darkened_color = canvas.get_pixel_v(pixel).darkened(dark_factor)
			canvas.set_pixel_v(pixel, darkened_color)
		
			action_data.redo.cells.append(pixel)
			action_data.redo.colors.append(darkened_color)
			continue
		
		action_data.undo.colors.append(canvas.get_pixel_v(pixel))
		action_data.undo.cells.append(pixel)
		var darkened_color = canvas.get_pixel_v(pixel).darkened(dark_factor)
		canvas.set_pixel_v(pixel, darkened_color)
	
		action_data.redo.cells.append(pixel)
		action_data.redo.colors.append(darkened_color)


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



