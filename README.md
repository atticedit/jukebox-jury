jukebox-jury

∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿

A command-line app for storing and analyzing data on music recently listened to

∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿


Elevator Pitch

I listen to music as much of my waking life as possible, and consume nearly all kinds. I also keep track of which songs I’ve found I can listen to while concentrating on complex tasks. What I don’t do is a lot of reflection on what types of music grab me and why, but my music library contains that data and should be able to tell that story.

Project Requirements

	•	Simple feature set
	•	CRUD
	•	A query or two that will reveal connections not otherwise seen
	
Feature List

	•	Manually enter, update, and delete information for new songs:
	  ⁃	Title
	  ⁃	Artist
	  ⁃	Genre
	  ⁃	Commotion (integer from 1 to 5 representing a point on the spectrum from tranquil to cacophonous)
	  ⁃	Attentionable (“true” if I can code to the song)
	•	Print the list of songs played in the last 3 months
	•	Print a report of songs I can code to, correlated to Genre and Commotion
	
Interesting Query

Which combinations of Genre and Commotion are good to listen to while coding?

Data Source

I’ll export an XML file of playlist data from my iTunes library comprised of tracks (excluding spoken word tracks and other non-songs) played in the last 3 months.
