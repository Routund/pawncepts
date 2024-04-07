extends AudioStreamPlayer2D

# Sounds array containing paths to audio files for male and female customers
var Sounds = [
	["res://Sounds/CustomerSounds/MaleAngry.wav", "res://Sounds/CustomerSounds/MaleAffirmative.wav", "res://Sounds/CustomerSounds/MaleInquisitive1.wav", "res://Sounds/CustomerSounds/MaleInquisitive2.wav", "res://Sounds/CustomerSounds/MaleInquisitive3.wav"],
	["res://Sounds/CustomerSounds/FemaleAngry.wav", "res://Sounds/CustomerSounds/FemaleAffirmative.wav", "res://Sounds/CustomerSounds/FemaleInquisitive1.wav", "res://Sounds/CustomerSounds/FemaleInquisitive3.wav"]
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Function to play an affirmative sound
func playAffirmative(gender: int):
	if gender < 0 or gender >= Sounds.size():
		return
	var sound_index = 1  # Index of affirmative sound in the array
	playSound(Sounds[gender][sound_index])

# Function to play an angry sound
func playAngry(gender: int):
	if gender < 0 or gender >= Sounds.size():
		return
	var sound_index = 0  # Index of angry sound in the array
	playSound(Sounds[gender][sound_index])

# Function to play an inquisitive sound
func playInquisitive(gender: int):
	if gender < 0 or gender >= Sounds.size():
		return
	var sound_index = randi_range(2, Sounds[gender].size() - 1)  # Randomly select an inquisitive sound
	playSound(Sounds[gender][sound_index])

# Internal function to play the specified sound
func playSound(sound_path: String):
	var sound = load(sound_path)
	if sound:
		stream = sound
		play()
	else:
		print("Failed to load sound:", sound_path)
