extends Node2D

export (float) var interaction_distance = 10.0
export (Array) var initial_items_path

onready var tile_map = $TileMapGrass
onready var grid_selector = $GridSelector
onready var player = $Jogador
onready var curr_item_index = 0

var items = []
var mouse_tile_pos

var time = 0.0
const TIME_PERIOD = 20.0
signal timepass

func _ready():
	for node_path in initial_items_path:
		items.append( get_node( node_path ) )
	
	print( "Item atual: (" + str(curr_item_index) + ") " + items[curr_item_index].get_name() )

# transforma uma posição no grid para uma posição global
func tile_pos_to_world_pos( tile_pos ):
	return Vector2(tile_pos.x * tile_map.cell_size.x, tile_pos.y * tile_map.cell_size.y)

# verifica se o indicador no grid esta abaixo da distancia de interação
func grid_selector_distance_check():
	return grid_selector.position.distance_to( player.position ) < interaction_distance

# muda a posição e a cor do indicador no grid
func set_grid_selector( tile_pos ):
	grid_selector.position = tile_pos_to_world_pos( tile_pos )
	
	if  grid_selector_distance_check():
		$GridSelector/Sprite.modulate = Color(0, 1, 0)
	else :
		$GridSelector/Sprite.modulate = Color(1, 0, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var mouse_world_pos = get_global_mouse_position()
	mouse_tile_pos = tile_map.world_to_map( mouse_world_pos )
	
	if (tile_map.get_cellv( mouse_tile_pos ) == 17): #seletor só aparece na fazenda
		grid_selector.visible = true
	else:
		grid_selector.visible = false
	
	time += _delta
	if time > TIME_PERIOD:
		time -= TIME_PERIOD
		emit_signal("timepass")
	
	set_grid_selector( mouse_tile_pos )

# cria uma planta na posição do grid tile_pos
func cria_planta( tile_pos ):
	var planta_path = "res://Cenas/Planta.tscn"
	var planta = load(planta_path).instance()
	planta.global_position = tile_pos_to_world_pos( tile_pos )
	add_child(planta)

# verifica se tem uma planta na posição do grid tile_pos
func check_for_planta( tile_pos ):
	var space_state = get_world_2d().direct_space_state
	var results = space_state.intersect_point( tile_pos_to_world_pos( tile_pos ), 32, [], 2147483647, false, true )
	
	for r in results:
		if( r["collider"].is_in_group("Planta") ):
			return r["collider"]
	
	return null


func _input( event ):
	if( event.is_action_pressed("action") ):
		if( grid_selector_distance_check() ):
			items[curr_item_index].do_action( self )
	
	elif( event.is_action_pressed("scroll_up") ):
		curr_item_index = posmod( curr_item_index + 1, items.size() )
		print( "Item atual: (" + str(curr_item_index) + ") " + items[curr_item_index].get_name() )
	
	elif( event.is_action_pressed("scroll_down") ):
		curr_item_index = posmod( curr_item_index - 1, items.size() )
		print( "Item atual: (" + str(curr_item_index) + ") " + items[curr_item_index].get_name() )



