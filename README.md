# Jukebox Jury ∿∿∿∿∿

#### A command-line app for storing and analyzing data on music recently listened to

## Elevator Pitch

I listen to music as much of my waking life as possible, and happily take in nearly all kinds. I also use iTunes metadata to note how frenetic a song is and mark the songs I’ve found I can listen to while concentrating on complex tasks. What I don’t do is a lot of reflection on what types of songs grab me and why, but my music library contains the data and should be able to tell that story.

## Project Requirements

  * Simple feature set
  * CRUD
  * Test-driven development
  * A query or two that will reveal connections not otherwise seen
	
## Feature List

  * Print the list of all songs played within a specified timeframe
  * Manually enter, update, and delete data for songs:
    * Title
    * Artist
    * Genre
    * Play Date
    * Intensity (integer from 1 to 5 representing a point on the spectrum from tranquil to frenzied)
    * Focusing (“true” if conducive to concentration)
  * Print a report of songs with a Focusing value of "true", correlated to Genre and Intensity
	
## Interesting Queries

Which combinations of Genre and Intensity are good to listen to while coding?

For songs falling into each ratings group, from ★ to ★★★★★, what’s the average number of words per song title?

## Data Source

An XML file of playlist data from iTunes comprised of tracks (excluding spoken word tracks and other non-songs) that have values entered in the Rating, Intensity, and Focusing metadata fields.
