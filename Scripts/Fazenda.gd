extends Node2D

export (float) var interaction_distance = 10.0
export (Array) var items = []

onready var tile_map = $TileMapGrass
onready var grid_selector = $GridSelector
onready var player = $Jogador
onready var num_items = items.size()
onready var curr_item_index = 0

var mouse_tile_pos


func tile_pos_to_world_pos( tile_pos ):
	return Vector2(tile_pos.x * tile_map.cell_size.x, tile_pos.y * tile_map.cell_size.y)


func grid_distance_check():
	return grid_selector.position.distance_to( player.position ) < interaction_distance


func set_grid_selector( tile_pos ):
	grid_selector.position = tile_pos_to_world_pos( tile_pos )
	
	if  grid_distance_check():
		$GridSelector/Sprite.modulate = Color(0, 1, 0)
	else :
		$GridSelector/Sprite.modulate = Color(1, 0, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var mouse_world_pos = get_global_mouse_position()
	mouse_tile_pos = tile_map.world_to_map( mouse_world_pos )
	
	set_grid_selector( mouse_tile_pos )


func cria_planta( tile_pos ):
	var planta_path = "res://Cenas/Planta.tscn"
	var planta = load(planta_path).instance()
	planta.global_position = tile_pos_to_world_pos( tile_pos )
	add_child(planta)


func check_for_planta( tile_pos ):
	var space_state = get_world_2d().direct_space_state
	var results = space_state.intersect_point( tile_pos_to_world_pos( tile_pos ), 32, [], 2147483647, false, true )
	
	for r in results:
		if( r["collider"].is_in_group("Planta") ):
			return r["collider"]
	
	return null


func _input( event ):
	if( event.is_action_pressed("action") ):
		if( grid_distance_check() ):
			if( !check_for_planta( mouse_tile_pos ) and tile_map.get_cellv( mouse_tile_pos ) == 17 ):
				cria_planta( mouse_tile_pos )
	
	elif( event.is_action_pressed("scroll_up") ):
		if( curr_item_index + 1 == num_items ):
			curr_item_index = 0
		else:
			curr_item_index += 1
	
	elif( event.is_action_pressed("scroll_down") ):
		if( curr_item_index == 0 ):
			curr_item_index = num_items - 1
		else:
			curr_item_index -= 1
