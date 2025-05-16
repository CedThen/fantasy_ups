@tool
class_name RouteDef extends Resource

enum RouteTypes { UNLOCKED, LOCKED, HIDDEN }

@export var origin: LocationDef
@export var destination: LocationDef
@export var route_name: String
@export var default_route: Texture2D
@export var highlighted_route: Texture2D
@export var color: Color
@export var supply_cost: float
@export var time_cost: float
@export var route_type: RouteTypes
@export var is_in_fog: bool
@export var collision_polygon: Array
#@export var requisites: Dictionary # mbbe an array of items or something
# need to query some source (inventory?) to check if prereqs are met
#@export var hazards/prereqs: ?
