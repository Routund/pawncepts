extends Label

@export var fadeDuration : float = 1.0 # Duration of each fade cycle
@export var fadeDelay : float = 0.5 # Delay between each fade cycle
var isFading : bool = false # Flag to control fading animation
var fadeDirection : int = 1 # Direction of fading animation (1 for fade in, -1 for fade out)
var fadeTimer : float = 0.0 # Timer to track fading animation
var minAlpha : float = 0.0 # Minimum alpha value
var maxAlpha : float = 1.0 # Maximum alpha value

func _ready():
	isFading = true
	fadeTimer = fadeDuration # Start fading immediately
	process_fade_animation()

func _process(delta):
	if isFading:
		fadeTimer -= delta
		if fadeTimer <= 0:
			fadeTimer = fadeDelay
			fadeDirection *= -1 # Reverse fade direction
			process_fade_animation()

func process_fade_animation():
	if fadeDirection == 1:
		# Fade in
		modulate.a = 1
	else:
		# Fade out
		modulate.a = 1-0.5

func stop_fade_animation():
	isFading = false
