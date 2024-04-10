class_name PlayerUI_Interactor extends RayCast3D

@export var max_interactable_range := 100.0

func _process(_delta: float) -> void:
	var coll := get_collider() as Interactable

	if is_colliding():
		print("is colliding")

		if coll.is_in_group("interactable"):
			print("is interactable")
			if (owner as CharacterBody3D).position.distance_to(coll.position) <= max_interactable_range:
				print("is in range")
				UIManager.instance.hud.show_interactor(coll.interact_name)
				return

	UIManager.instance.player.hud.hide_interactor()