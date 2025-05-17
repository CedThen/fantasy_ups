@tool
extends EditorScript

func _run():
	var route_defs_folder: String = "res://assets/map_resources/routes/"
	var simplification: int = 4
	var grow_pixels: int = 5
	var shrink_pixels: int = 0

	var dir: DirAccess = DirAccess.open(route_defs_folder)
	if dir == null:
		push_error("Cannot open folder: %s" % route_defs_folder)
		return

	for file_name: String in dir.get_files():
		if not file_name.ends_with(".tres"):
			continue

		var path: String = route_defs_folder + "/" + file_name
		var route_def: Resource = ResourceLoader.load(path)

		if route_def == null:
			print("Failed to load:", file_name)
			continue

		# Only handle RouteDef resources that have the expected properties
		if not route_def.default_route:
			print("Skipping non-route resource:", file_name)
			continue

		var texture: Texture2D = route_def.default_route
		if texture == null:
			print("No texture found on:", file_name)
			continue

		var img: Image = texture.get_image()
		if img == null:
			print("Could not get image from texture on:", file_name)
			continue

		var bmp: BitMap = BitMap.new()
		bmp.create_from_image_alpha(img, 0.1)

		var rect: Rect2 = Rect2(Vector2.ZERO, img.get_size())
		if shrink_pixels > 0:
			bmp.grow_mask(-shrink_pixels, rect)
		if grow_pixels > 0:
			bmp.grow_mask(grow_pixels, rect)

		var polygons: Array[PackedVector2Array] = bmp.opaque_to_polygons(rect, simplification)
		if polygons.is_empty() or polygons[0].is_empty():
			print("No valid polygons generated for:", file_name)
			continue
		#
		#var arr = []
		#for polygon in polygons:
			#for item in polygon:
				#arr.append(item)
				#
		#route_def.collision_polygon = arr

		route_def.collision_polygon = polygons[0]

		var result: Error = ResourceSaver.save(route_def, path)
		if result == OK:
			print("✔ Collision polygon updated for:", file_name)
			print("new collision polygon:", route_def.collision_polygon)
			#print("new collision polygon:", polygons)X
		else:
			print("❌ Failed to save:", file_name)
