extends Node2D

#Game State
var wave
var zombieCount

#States
enum State {GAME_START, IN_WAVE, OUT_WAVE, GAME_OVER}
var state

#Constants
const max_horde_size = 20

#Dependencies
var spawners
var timer

#helper
var timerStarted

#UI
var wave_ui

func _ready():
	timer = $Timer
	wave_ui = get_parent().get_node("wave")
	timer.wait_time = 5
	spawners = get_tree().get_nodes_in_group("Spawner")
	wave = 1
	wave_ui.set_text(str(wave))
	state = State.GAME_START
	timerStarted = false
	timer.connect("timeout", self, "_on_timer_timeout")
	
func _process(delta):
	if (state == State.GAME_START and not timerStarted):
		timer.start()
		timerStarted = true
	elif (state == State.IN_WAVE):
		if (zombieCount == 0):
			print("Wave Over")
			wave += 1
			wave_ui.set_text(str(wave))
			state = State.OUT_WAVE
	elif (state == State.OUT_WAVE and not timerStarted):
		timer.start()
		timerStarted = true

func compute_spawn_size():
	return wave

func spawn_wave(numZombies):
	var generator = RandomNumberGenerator.new()
	generator.randomize()
	for i in range(numZombies):
		spawners[generator.randi_range(0, len(spawners) - 1)].spawn_zombie()

func _on_timer_timeout():
	timerStarted = false
	zombieCount = compute_spawn_size()
	state = State.IN_WAVE
	print("Spawning: " + str(compute_spawn_size()) + " zombies")
	spawn_wave(compute_spawn_size())
