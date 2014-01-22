# User Stories

### Creating a Record

As a music fanatic who also needs to get things done,
I want to enter information about songs I've listened to
in order to keep track of which ones keep me focused.

##### Usage

    ./jury add "Celebrated Summer"

##### Acceptance Criteria

* If the song is already in the database, asks if I want to update the existing record instead
* Gives me one prompt at a time for each attribute (Artist, Genre, etc.) of the song
* Saves all the information I've given for the song

---

### Updating a Record

As a music fanatic who also needs to get things done,
I want to update information about songs when I have changes
in order to keep things up to date.

##### Usage

    ./jury update "Pancake Lizard"

##### Acceptance Criteria

* If no song by that name is in the database, asks if I want to create a record instead
* Shows me each attribute stored for the song on its own numbered line and asks me which line I want to update
* Retains all the information I've declined to update
* Saves all the new information I've given for the song

---

### Deleting a Record

As a music fanatic who also needs to get things done,
I want to delete information about songs I no longer own
in order to keep the information relevant.

##### Usage

    ./jury delete "Airport Surroundings"

##### Acceptance Criteria

* If no song by that name is in the database, gives an error
* Asks me to verify that I want to delete
* If I verify, deletes the record for the song

---

### Importing Data

As a music fanatic who also needs to get things done,
I want to bring in data I've exported from iTunes about my songs
in order to have the best information for locating more songs I can concentrate to.

##### Usage

    ./jury import songs.xml

##### Acceptance Criteria

* Asks me to verify that I want to import the file
* If I verify, adds the data from the imported file to my database
* Prints a summary of the records saved to the database

---

### Reporting on Artists

As a music fanatic who also needs to get things done,
I want to view a report on artists in my collection
in order to see which are best to listen to while concentrating.

##### Usage

    ./jury stats --artist
    ./jury stats -a

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

    ./jury stats --genre
    ./jury stats -g

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

    ./jury stats --overview
    ./jury stats -o


##### Acceptance Criteria

* Prints a report of combinations of genres and intensities, sorted by the number of songs with that combination I marked as being good for concentration
* Ignores genre/intensity level combinations that have no songs I can concentrate to
