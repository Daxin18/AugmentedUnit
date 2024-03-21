class_name Lethal
extends CollisionObject2D
# just a base class for damage detection

func _ready():
	# all lethal objects should be on layer 5
	set_collision_layer_value(5, true)

