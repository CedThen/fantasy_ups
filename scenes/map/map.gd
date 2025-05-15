class_name Map extends Node

enum MapMode {PlottingRoutes, SelectingDestination, Traveling}

@onready var map_mode_label: RichTextLabel = %MapModeLabel
@onready var locations: Node = %Locations
@onready var routes: Node = %Routes
@onready var toggle_mode_button: CheckButton = %ToggleModeButton
@onready var map_camera: Camera2D = %MapCamera

@export var mode: MapMode = MapMode.SelectingDestination

@export var starting_location: Location

var locations_list:Array[Location]

var adjacency_graph = {} # Dictionary[Location, Array[Route]]

func _ready() -> void:
	Global.map = self
	build_graph()
	build_locations_list()
	if mode == MapMode.SelectingDestination:
		enter_select_mode()
	else:
		enter_plot_mode()
	SignalBus.location_hovered.connect(on_location_hovered)
	SignalBus.location_exited.connect(on_location_exited)
	SignalBus.location_clicked.connect(on_location_clicked)

func on_location_hovered(location: Location):
	if mode == MapMode.PlottingRoutes and adjacency_graph.has(location):
		var neighboring_routes = adjacency_graph[location]
		set_route_visibility(neighboring_routes, true)

func on_location_exited(location: Location):
	if mode == MapMode.PlottingRoutes and adjacency_graph.has(location):
		var neighboring_routes = adjacency_graph[location]
		set_route_visibility(neighboring_routes, false)

func _on_toggle_mode_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		enter_select_mode()
	else:
		enter_plot_mode()

func enter_select_mode():
	mode = MapMode.SelectingDestination
	map_mode_label.text = "Choose Destination"
	set_route_visibility(routes.get_children(), false)
	
func enter_plot_mode():
	mode = MapMode.PlottingRoutes
	map_mode_label.text = "Plotting Routes"
	#set_route_visibility(true)

func set_route_visibility(routes_array: Array, visible: bool):
	for route in routes_array:
		if route is Route:
			route.isVisible = visible

func build_graph():
	adjacency_graph.clear()
	for route in routes.get_children():
		if route is Route and route.origin and route.destination:
			# Add route to origin
			if not adjacency_graph.has(route.origin):
				adjacency_graph[route.origin] = []
			adjacency_graph[route.origin].append(route)

			# If routes are bidirectional, also add reverse
			if not adjacency_graph.has(route.destination):
				adjacency_graph[route.destination] = []
			adjacency_graph[route.destination].append(route)


func build_locations_list():
	var locations_children = locations.get_children()
	for loc in locations_children:
		if not loc is Location:
			continue
			
		locations_list.append(loc)


func get_starting_location() -> Location:
	return starting_location


func get_location_by_def(def:LocationDef) -> Location:
	for location:Location in locations_list:
		if location.location_def == def:
			return location
			
	return
	

# Very rough for now - all actual validity checking done before this
func move_player(dest_location:Location):
	var player = Global.get_player()
	player.entered_location(dest_location)
	


func on_location_clicked(loc: Location):
	move_player(loc)
