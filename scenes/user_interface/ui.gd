class_name Ui
extends CanvasLayer

# colours
const GREEN := Color("6bbfa3")
const RED := Color(0.9, 0.0, 0.0, 1.0)

@onready var laser_label: Label = $LaserCounter/VBoxContainer/LaserLabel
@onready var laser_icon: TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var grenade_label: Label = $GrenadeCounter/VBoxContainer/GrenadeLabel
@onready var grenade_icon: TextureRect = $GrenadeCounter/VBoxContainer/TextureRect
@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar


func _ready() -> void:
	Globals.connect("laser_amount_changed", _on_globals_laser_amount_changed)
	Globals.connect("grenade_amount_changed", _on_globals_grenade_amount_changed)
	Globals.connect("health_changed", _on_globals_health_changed)
	update_laser_count_display()
	update_grenade_count_display()
	update_health_display()


## Update the displayed laser count in the UI to show the player's current laser count.
func update_laser_count_display() -> void:
	laser_label.text = str(Globals.laser_amount)
	_update_color(Globals.laser_amount, laser_label, laser_icon)


## Update the displayed grenade count in the UI to show the player's current grenade count.
func update_grenade_count_display() -> void:
	grenade_label.text = str(Globals.grenade_amount)
	_update_color(Globals.grenade_amount, grenade_label, grenade_icon)


func update_health_display() -> void:
	health_bar.value = Globals.health


func _on_globals_laser_amount_changed(_old_amount: int, _new_amount: int) -> void:
	update_laser_count_display()


func _on_globals_grenade_amount_changed(_old_amount: int, _new_amount: int) -> void:
	update_grenade_count_display()


func _on_globals_health_changed(_old_health: int, _new_health: int) -> void:
	update_health_display()


## Modulates the color of the passed-in [param label] and [param icon] to green
## if [param amount] is greater than 0, or red otherwise.
func _update_color(amount: int, label: CanvasItem, icon: CanvasItem) -> void:
	label.modulate = GREEN if amount > 0 else RED
	icon.modulate = GREEN if amount > 0 else RED
