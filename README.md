# Jukebox Jury ∿∿∿∿∿

#### A command-line app for analyzing what types of songs are best for concentration

## Elevator Pitch

I listen to music as much of my waking life as possible, which includes while I'm coding. I also use iTunes metadata to note how frenetic a song is and mark the songs I’ve found I can listen to while concentrating on complex tasks. What I don’t do is a lot of reflection on what types of songs focus my mind and why, but my music library contains the data and should be able to tell that story.

## Project Requirements

  * Simple feature set
  * CRUD operations
  * Test-driven development
  * A query that will reveal connections not otherwise seen

## Feature List

  * Manually enter, update, and delete the following data for songs:
    * Name
    * Artist
    * Genre
    * Intensity (integer from 1 to 5 representing a point on the spectrum from tranquil to frenzied)
    * Focusing (1 if conducive to concentration and 0 if not)
  * Import song data exported from iTunes
  * Print a list of the combinations of genre and intensity with the most songs conducive to concentration

## Interesting Query

Which combinations of Genre and Intensity are good to listen to while coding?

## Data Source

An XML file of playlist data from iTunes comprised of tracks (excluding spoken word tracks and other non-songs) that have values entered for Name, Artist, Genre, Intensity, and Focusing.
