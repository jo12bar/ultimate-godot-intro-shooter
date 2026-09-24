class_name Ui
extends CanvasLayer

@onready var laser_label: Label = $LaserCounter/VBoxContainer/LaserLabel
@onready var grenade_label: Label = $GrenadeCounter/VBoxContainer/GrenadeLabel


func _ready() -> void:
	update_laser_count_display()
	update_grenade_count_display()


## Update the displayed laser count in the UI to show the player's current laser count.
func update_laser_count_display():
	laser_label.text = str(Globals.laser_amount)


## Update the displayed grenade count in the UI to show the player's current grenade count.
func update_grenade_count_display():
	grenade_label.text = str(Globals.grenade_amount)
