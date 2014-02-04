# User Stories

### Creating a Record

As a music fanatic who also needs to get things done,
I want to enter information about songs I've listened to
in order to keep track of which ones keep me focused.

##### Usage

    ./jury add 'Celebrated Summer' --artist 'Hüsker Dü' --intensity 5 --focusing 0

##### Acceptance Criteria

* Lists all available genres and prompts me to make a selection
* If I make a selection, lists the information I entered for the song, including genre
* Saves all the information I've given for the song

---

### Editing a Record

As a music fanatic who also needs to get things done,
I want to update information about songs when I have changes
in order to keep things up to date.

##### Usage

    ./jury edit --name 'Crusoe' --artist 'The Ex & Tom Cora' --intensity 4 --focusing 1

##### Acceptance Criteria

* If no song by that name is in the database, asks if I want to create a record instead
* Retains all the information I've declined to update
* Saves all the new information I've given for the song

---

### Deleting a Record

As a music fanatic who also needs to get things done,
I want to delete information about songs I no longer own
in order to keep the information relevant.

##### Usage

    ./jury delete "Buddy Ebsen Loves The Night Time"

##### Acceptance Criteria

* If no song by that name is in the database, gives an error
* If the song is found, lists the information on the song and asks me to verify that I want to delete
* If I verify, deletes the record for the song

---

### Importing Data

As a music fanatic who also needs to get things done,
I want to bring in data I've exported from iTunes about my songs
in order to have the best information for locating more songs I can concentrate to.

##### Usage

    rake import_data

##### Acceptance Criteria

* Adds the data from the imported file to my database

---

### Reporting on Genre/Intensity Combinations

As a music fanatic who also needs to get things done,
I want to view a report on songs I've listened to
in order to see what combinations of genres and intensity levels allow me to concentrate best.

##### Usage

    ./jury report

##### Acceptance Criteria

* Prints a report of combinations of genres and intensities, sorted by the number of songs with that combination I marked as being good for concentration
* Limits to the 7 combinations of genre and intensity I'm best able to concentrate to
