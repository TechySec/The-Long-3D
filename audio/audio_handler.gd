extends Node

## Ensure the song is the same as the index variable when adding
## new music. This is just so we don't have random magic numbers.
enum Music {
	STALAGMITE = 0
}

enum Sounds {
	ROCK_AND_STONE = 0
}

@export var music_array:Array[AudioStreamPlayer]
@export var sounds_array:Array[AudioStreamPlayer]


## Stops all music and plays a new song.
func change_music(song:Music = Music.STALAGMITE):
	stop_music()
	music_array[song].play()

func stop_music(): for i in music_array: i.stop()
		
func play_sfx(sound:Sounds): if sound: sounds_array[sound].play()
	
func stop_sfx(): for i in sounds_array: i.stop()
