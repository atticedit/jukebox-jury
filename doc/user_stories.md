# User Stories

### Creating a Record

As a music fanatic who also needs to get things done,
I want to enter information about songs I've listened to
in order to keep track of which ones keep me focused.

##### Usage

    ruby jury.rb --add "Celebrated Summer"

##### Acceptance Criteria

* If the song is already in the database, asks if I want to update the information instead
* Prompts me for each piece of information (Artist, Genre, etc.) for the song
* Saves all the information I've given for the song

---

### Updating a Record

As a music fanatic who also needs to get things done,
I want to update information about songs when I have changes
in order to keep things up to date.

##### Usage

    ruby jury.rb --update "Pancake Lizard"

##### Acceptance Criteria

* If no song by that name is in the database, asks if I want to create a record instead
* Shows me each piece of information stored for the song on numbered lines and asks me which line I want to update
* Retains all the information I've declined to update
* Saves all the new information I've given for the song

---

### Deleting a Record

As a music fanatic who also needs to get things done,
I want to delete information about songs I no longer own
in order to keep the information relevant.

##### Usage

    ruby jury.rb --delete "Airport Surroundings"

##### Acceptance Criteria

* If no song by that name is in the database, gives an error
* Asks me to verify that I want to delete
* If I verify, deletes the record for the song

---

### Reporting on Artists

As a music fanatic who also needs to get things done,
I want to view a report on artists in my collection
in order to see which are best to listen to while concentrating.

##### Usage

    ruby jury.rb stats "Artist"

##### Acceptance Criteria

* Prints a report of artists sorted by how many of the artist's songs I marked as being good for concentration
* Ignores artists that have no songs I can concentrate to
* Limits printing to the 20 artists with the most songs I can concentrate to

---

### Reporting on Genres

As a music fanatic who also needs to get things done,
I want to view a report on genres in my collection
in order to see which are best to listen to while concentrating.

##### Usage

    ruby jury.rb stats "Genre"

##### Acceptance Criteria

* Prints a report of genres sorted by the number of songs in the genre I marked as being good for concentration
* Ignores genres that have no songs I can concentrate to
* Limits printing to the 20 genres with the most songs I can concentrate to

---

### Reporting on Genre/Intensity Combinations

As a music fanatic who also needs to get things done,
I want to view a report on songs I've listened to
in order to see what combinations of genres and intensity levels allow me to concentrate best.

##### Usage

    ruby jury.rb stats "Overview"

##### Acceptance Criteria

* Prints a report of combinations of genres and intensities, sorted by the number of songs with that combination I marked as being good for concentration
* Ignores genre/intensity level combinations that have no songs I can concentrate to
