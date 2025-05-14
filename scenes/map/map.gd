extends Node

enum MapMode {PlottingRoutes, SelectingDestination, Traveling}

@onready var map_mode_label: RichTextLabel = %MapModeLabel
@onready var locations: Node = %Locations
@onready var routes: Node = %Routes
@onready var toggle_mode_button: CheckButton = %ToggleModeButton

@export var current_location: Location
@export var mode: MapMode = MapMode.SelectingDestination

var adjacency_graph = {} # Dictionary[Location, Array[Route]]


# handles selecting nodes and routing

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	build_graph()
	if mode == MapMode.SelectingDestination:
		enter_select_mode()
	else:
		enter_plot_mode()
	SignalBus.location_hovered.connect(on_location_hovered)
	SignalBus.location_exited.connect(on_location_exited)

func on_location_hovered(location: Location):
	if mode == MapMode.PlottingRoutes:
		var neighboring_routes = adjacency_graph[location]
		set_route_visibility(neighboring_routes, true)

func on_location_exited(location: Location):
	if mode == MapMode.PlottingRoutes:
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
