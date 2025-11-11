extends Node

## Everything here is queued for saving. Once the save() function is called,
## then we put that into the final dictionary for the JSON file.

enum Items {
	MURT_COLLECTED
}

var audio_data:Dictionary = {
	"Master": 1.0,
	"SFX": 1.0,
	"Music": 1.0
}

var save_room:String

var items_collected : Dictionary = {
	Items.MURT_COLLECTED: false
}

func collect_item(index:Items):
	if items_collected[index]:
		items_collected[index] = true
