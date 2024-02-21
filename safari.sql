DROP TABLE IF EXISTS assignments;
DROP TABLE IF EXISTS animals;
DROP TABLE IF EXISTS enclosures;
DROP TABLE IF EXISTS staff;

CREATE TABLE staff(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    employeeNumber INT
);

CREATE TABLE enclosures(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    capacity INT,
    closedForMaintenance BOOLEAN
);

CREATE TABLE animals(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    type VARCHAR(255),
    age INT,
    enclosure_id INT REFERENCES enclosures(id)
);

CREATE TABLE assignments(
    id SERIAL PRIMARY KEY,
    staff_id INT REFERENCES staff(id),
    enclosure_id INT REFERENCES enclosures(id),
    day VARCHAR(255)
);

INSERT INTO staff(name, employeeNumber) VALUES('Captain Rik', 1234);
INSERT INTO staff(name, employeeNumber) VALUES('Captain Rok', 2468);
INSERT INTO staff(name, employeeNumber) VALUES('Captain Rak', 3579);


INSERT INTO enclosures(name, capacity, closedForMaintenance) VALUES('big cat field',20, false);
INSERT INTO enclosures(name, capacity, closedForMaintenance) VALUES('monkey sanctuary',10, false);
INSERT INTO enclosures(name, capacity, closedForMaintenance) VALUES('birds',1, true);

INSERT INTO animals(name, type, age, enclosure_id) VALUES('Tony', 'Tiger', 59, 1);
INSERT INTO animals(name, type, age, enclosure_id) VALUES('Simba', 'Lion', 10, 1);
INSERT INTO animals(name, type, age, enclosure_id) VALUES('Mufasa', 'Lion', 80, 1);
INSERT INTO animals(name, type, age, enclosure_id) VALUES('Rafiki', 'Monkey', 80, 2);
INSERT INTO animals(name, type, age, enclosure_id) VALUES('Zazu', 'Bird', 44, 3);
INSERT INTO animals(name, type, age, enclosure_id) VALUES('Iago', 'Bird', 32, 3);

INSERT INTO assignments(staff_id, enclosure_id, day) VALUES(2,1, 'Monday');
INSERT INTO assignments(staff_id, enclosure_id, day) VALUES(1,1,'Tuesday');
INSERT INTO assignments(staff_id, enclosure_id, day) VALUES(1,3, 'Wednesday');
INSERT INTO assignments(staff_id, enclosure_id, day) VALUES(3,2, 'Tuesday');
