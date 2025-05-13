class_name Graph

var nodes := {} # { id: Vector2 }
var edges := {} # { from_id: { to_id: weight } }

func add_node(id: String, pos: Vector2):
	nodes[id] = pos
	edges[id] = {}

func add_edge(from_id: String, to_id: String, weight: float):
	edges[from_id][to_id] = weight
	edges[to_id][from_id] = weight # undirected
