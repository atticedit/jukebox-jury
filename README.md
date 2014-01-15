# Jukebox Jury ∿∿∿∿∿

#### A command-line app for storing and analyzing data on music recently listened to

## Elevator Pitch

I listen to music as much of my waking life as possible, and happily take in nearly all kinds. I also use iTunes metadata to note how frenetic a song is and mark the songs I’ve found I can listen to while concentrating on complex tasks. What I don’t do is a lot of reflection on what types of songs grab me and why, but my music library contains the data and should be able to tell that story.

## Project Requirements

  * Simple feature set
  * CRUD
  * A query or two that will reveal connections not otherwise seen
	
## Feature List

  * Print the list of songs played within a specified timeframe
  * Manually enter, update, and delete data for songs:
    * Title
    * Artist
    * Genre
    * Intensity (integer from 1 to 5 representing a point on the spectrum from tranquil to frenzied)
    * Focusing (“true” if I can code to the song)
  * Print a report of songs I can code to, correlated to Genre and Commotion
	
## Interesting Queries

Which combinations of Genre and Commotion are good to listen to while coding?

For songs falling into each ratings group, from ★ to ★★★★★, what’s the average word length of a song title?

## Data Source

I’ll export an XML file of playlist data from my iTunes library comprised of tracks (excluding spoken word tracks and other non-songs) played in the last 3 months.
