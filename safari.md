# Task - Safari Park

We've now seen how to set up and query a relational database, including how to set up links between our tables and query many tables at once. Now we'll put it into practice by building a database to store data in a specific format.

Usually we'll have a back-end application handling user input and communicating with the database. It will receive that input in a format known as **JSON** (**J**ava**S**cript **O**bject **N**otation) and determine how to structure a query based on that. In this task we will provide you with sample data which you should use as a guide to set up the tables. 

## The Data

Our users will be able to enter details for the animals in the park, their enclosures and the staff working there. Each member of staff will be assinged to a different enclosure on a different day; each enclosure will have more than one person looking after it. The data entered by the user will look like this:

```json
// animal

{
	"id": 1,
	"name": "Tony",
	"type": "Tiger",
	"age": 59,
	"enclosure_id": 1
}

// enclosure

{
	"id": 1,
	"name": "big cat field",
	"capacity": 20,
	"closedForMaintenance": false
}

// staff

{
	"id": 1,
	"name": "Captain Rik",
	"employeeNumber": 12345,
}

// assignment

{
	"id": 1,
	"employeeId": 1,
	"enclosureId": 1,
	"day": "Tuesday"
}
```

## MVP

- Draw an entity relationship diagram to show the structure of the tables and the relationships between them. Each table should have enough columns to capture all the data shown in the JSON above.
- Set up the tables in a postgres database. You can set them up using the `psql` REPL, a GUI like Postico or PGAdmin or by writing an SQL file like the one in the previous task.
- Populate the tables with some of your own data (you don't need to use more cereal mascots, unless you want to). Don't worry about the capacity restriction on enclosures for now, checking the would be handled by the back-end before the data gets sent to the database.
- Write queries to find:
	- The names of the animals in a given enclosure
	```SQL 
    SELECT animals.name FROM animals INNER JOIN enclosures ON  animals.enclosure_id = enclosures.id WHERE enclosures.name = 'big cat field'; 
   ```

- The names of the staff working in a given enclosure
	```SQL
	SELECT staff.name FROM staff INNER JOIN assignments ON  staff.id = assignments.staff_id INNER JOIN enclosures ON enclosures.id = assignments.enclosure_id WHERE enclosures.name = 'big cat field';
    ``` 

	
## Extensions

Write queries to find:

- The names of staff working in enclosures which are closed for maintenance
```SQL
   SELECT staff.name FROM staff INNER JOIN assignments ON staff.id = assignments.staff_id INNER JOIN enclosures ON assignments.enclosure_id = enclosures.id WHERE enclosures.closedformaintenance = true;

```
- The name of the enclosure where the oldest animal lives. If there are two animals who are the same age choose the first one alphabetically.
``` SQL
   SELECT enclosures.name FROM animals INNER JOIN enclosures ON animals.enclosure_id = enclosures.id ORDER BY animals.age DESC, animals.name ASC limit 1 ;
```
- The number of different animal types a given keeper has been assigned to work with.
```SQL
   SELECT DISTINCT animals.type FROM staff INNER JOIN assignments ON staff.id = assignments.staff_id INNER JOIN enclosures ON assignments.enclosure_id = enclosures.id INNER JOIN animals ON enclosures.id = animals.enclosure_id WHERE staff.name = 'Captain Rik';
```
- The number of different keepers who have been assigned to work in a given enclosure
```SQL
   SELECT DISTINCT staff.name FROM staff INNER JOIN assignments ON staff.id = assignments.staff_id INNER JOIN enclosures ON assignments.enclosure_id = enclosures.id WHERE enclosures.name = 'big cat field';
```
- The names of the other animals sharing an enclosure with a given animal (eg. find the names of all the animals sharing the big cat field with Tony)
```SQL
   -- Here is the solution given by Colin(BNTA trainer). It looks like they functionally wanted the same information as in the first query but wanted me to play around with aliases via the AS keyword.

   SELECT roommates.name FROM animals
   INNER JOIN enclosures
   ON animals.enclosure_id = enclosures.id
   INNER JOIN animals AS roommates
   ON enclosures.id = roommates.enclosure_id
   WHERE animals.id = 1;

```

## Hints

- Don't be tempted to perform too many joins, think about the data stored in each table.
- Remember that the result of a join is just another table. It can be filtered, ordered, summarised and joined again as much as you need.