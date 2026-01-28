extends Node

# The main script that controls the flow of the game.

# INTERACTION_MODE encodes the menu states the main battle menu can be in.
# Since RUN isn't a special menu, it does not get an entry here
enum INTERACTION_MODE {NONE, FIGHT, ITEM, MON}

var game_state: GameState


func _ready():
	# Connect signal listeners
	Events.request_menu_fight.connect(handle_request_menu_fight)
	Events.request_option_selected.connect(handle_menu_option_selected)
	Events.request_menu_run.connect(handle_run)

	setup_model()


func setup_model() -> void:
	game_state = GameState.new()

	var species_salamander: SpeciesResource = preload("uid://ckrih20qtfhly")
	var species_turtle: SpeciesResource = preload("uid://dk382ww1srg0a")

	var monster_one: Monster = Monster.new()
	monster_one.species = species_salamander
	monster_one.hp = species_salamander.max_hp

	var monster_two: Monster = Monster.new()
	monster_two.species = species_turtle
	monster_two.hp = species_turtle.max_hp

	game_state.player_monster = monster_one
	game_state.opponent_monster = monster_two
	return

	
func handle_request_menu_fight():
	var labels: Array[StringEnabled] = [StringEnabled.new("A", true), StringEnabled.new("B", false)]
	Events.on_menu_fight.emit(labels)


func handle_menu_option_selected(mode: INTERACTION_MODE, index: int):
	print("Selecting mode: %s  number: %d"%[mode, index])


func handle_run():
	get_tree().quit()
