extends Node2D

export (float) var interaction_distance = 10.0
var tile_map
var grid_selector
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	tile_map = $TileMapGrass
	grid_selector = $GridSelector
	player = $Jogador


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var mouse_world_pos = get_global_mouse_position()
	var mouse_tile_pos = tile_map.world_to_map( mouse_world_pos )
	
	grid_selector.position = Vector2(mouse_tile_pos.x * tile_map.cell_size.x, mouse_tile_pos.y * tile_map.cell_size.y)
	
	if grid_selector.position.distance_to( player.position ) >= interaction_distance :
		$GridSelector/Sprite.modulate = Color(1, 0, 0)
	else :
		$GridSelector/Sprite.modulate = Color(0, 1, 0)
