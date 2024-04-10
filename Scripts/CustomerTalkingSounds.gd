extends AudioStreamPlayer2D

# Sounds array containing paths to audio files for male and female customers
var Sounds = [
	["res://Sounds/CustomerSounds/MaleAngry1.mp3","res://Sounds/CustomerSounds/MaleAngry2.mp3", "res://Sounds/CustomerSounds/MaleHappy1.mp3","res://Sounds/CustomerSounds/MaleHappy2.mp3","res://Sounds/CustomerSounds/MaleNeutral1.mp3","res://Sounds/CustomerSounds/MaleNeutral2.mp3","res://Sounds/CustomerSounds/MaleNeutral3.mp3"],
	["res://Sounds/CustomerSounds/FemaleAngry1.mp3","res://Sounds/CustomerSounds/FemaleAngry2.mp3", "res://Sounds/CustomerSounds/FemaleHappy1.mp3","res://Sounds/CustomerSounds/FemaleHappy2.mp3","res://Sounds/CustomerSounds/FemaleNeutral1.mp3","res://Sounds/CustomerSounds/FemaleNeutral2.mp3","res://Sounds/CustomerSounds/FemaleNeutral3.mp3"]
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Function to play an affirmative sound
func playAffirmative(gender: int):
	if gender < 0 or gender >= Sounds.size():
		return
	var sound_index = randi_range(2,3) #Index of affirmative sound in the array
	playSound(Sounds[gender][sound_index])

# Function to play an angry sound
func playAngry(gender: int):
	if gender < 0 or gender >= Sounds.size():
		return
	var sound_index = randi_range(0, 1)  # Index of angry sound in the array
	playSound(Sounds[gender][sound_index])

# Function to play an inquisitive sound
func playInquisitive(gender: int):
	if gender < 0 or gender >= Sounds.size():
		return
	var sound_index = randi_range(4, Sounds[gender].size() - 1)  # Randomly select an inquisitive sound
	playSound(Sounds[gender][sound_index])

# Internal function to play the specified sound
func playSound(sound_path: String):
	var sound = load(sound_path)
	if sound:
		stream = sound
		play()
	else:
		print("Failed to load sound:", sound_path)
