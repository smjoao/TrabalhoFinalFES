extends Node

func do_action( fazenda ):
	# verifica se a posição que o mouse aponta não 
	# tem nenhuma planta e que é uma posição de terra
	if !fazenda.check_for_planta( fazenda.mouse_tile_pos ) and fazenda.tile_map.get_cellv( fazenda.mouse_tile_pos ) == 17:
		# cria uma planta na posição que o mouse aponta
		fazenda.cria_planta( fazenda.mouse_tile_pos )
