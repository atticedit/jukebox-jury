# User Stories

### Story 1

As a music fanatic,
I want to enter information about songs I've listened to
in order to keep track of which I like best and have found I can concentrate to.

##### Usage

    ruby jury.rb --add "Celebrated Summer"

##### Acceptance Criteria

* Prompts me for each piece of information (Artist, Genre, etc.) for the song
* Saves all the information I've given for the song
* If the song is already in the database, asks if I want to update the information

---

### Story 2

As a music fanatic,
I want to update information about songs when I have changes
in order to keep things up to date.

##### Usage

    ruby jury.rb --update "Pancake Lizard"

##### Acceptance Criteria

* Shows me each piece of information stored for the song and asks me if I want to update it
* Retains all the information I've declined to update
* Saves all the new information I've given for the song

---

### Story 3

As a music collector,
I want to delete information about songs I no longer own
in order to keep the information relevant.

##### Usage

    ruby jury.rb --delete "Airport Surroundings"

##### Acceptance Criteria

* Asks me to verify that I want to delete
* If I verify, deletes all information for the song

---

### Story 4

As a listener wanting to understand my music tastes better,
I want to get the average number of words for songs I've given each rating
in order to see whether I give higher ratings to songs with long names.

##### Usage

    ruby jury.rb stats "Name"

##### Acceptance Criteria

* For each rating from ★ to ★★★★★, prints the rating, the number of songs with that rating, and the average number of words per song name
* Ignores ratings with no matching songs

---

### Story 5

As someone needing music to listen to while concentrating on tasks,
I want to view a report on songs
in order to see what genres and intensity levels allow me to concentrate best.

##### Usage

    ruby jury.rb stats "Focusing"

##### Acceptance Criteria

* Prints a report of genres, intensities, and combinations of the two, sorted by how often they appear in the list of songs I marked as being good for concentration
* Ignores genres or intensities with no matching songs

---

### Story 6

As someone needing music to listen to while concentrating on tasks,
I want to view a report on artists
in order to see which are best to listen to while concentrating.

##### Usage

    ruby jury.rb stats "Artist"

##### Acceptance Criteria

* Prints a report of artists I listen to, sorted by how often their songs appear in the list of songs I marked as being good for concentration
* Ignores artists with no matching songs
* Limits printing to the 50 artists with the most songs appearing
