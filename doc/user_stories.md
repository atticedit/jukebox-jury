# User Stories

### Story 1

As a music fanatic who also needs to get things done,
I want to enter information about songs I've listened to
in order to keep track of which ones keep me focused.

##### Usage

    ruby jury.rb --add "Celebrated Summer"

##### Acceptance Criteria

* Prompts me for each piece of information (Artist, Genre, etc.) for the song
* Saves all the information I've given for the song
* If the song is already in the database, asks if I want to update the information

---

### Story 2

As a music fanatic who also needs to get things done,
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

As a music fanatic who also needs to get things done,
I want to delete information about songs I no longer own
in order to keep the information relevant.

##### Usage

    ruby jury.rb --delete "Airport Surroundings"

##### Acceptance Criteria

* Asks me to verify that I want to delete
* If I verify, deletes all information for the song

---

### Story 4

As a music fanatic who also needs to get things done,
I want to view a report on songs I've listened to
in order to see what genres and intensity levels allow me to concentrate best.

##### Usage

    ruby jury.rb stats

##### Acceptance Criteria

* Prints a report of genres, intensities, and combinations of the two, sorted by how often they appear in the list of songs I marked as being good for concentration
* Ignores genres or intensities with no matching songs

---

### Story 5

As a music fanatic who also needs to get things done,
I want to view a report on artists in my collection
in order to see which are best to listen to while concentrating.

##### Usage

    ruby jury.rb stats "Artist"

##### Acceptance Criteria

* Prints a report of artists sorted by how many of their songs I marked as being good for concentration
* Ignores artists with no matching songs
* Limits printing to the 50 artists with the most matching songs
