create database lab4;

create table Warehouses
(
    code     integer,
    location varchar(255),
    capacity integer,
    primary key (code)
);

create table Boxes
(
    code       char(4),
    contents   varchar(255),
    value      real,
    warehouses integer,
    foreign key (warehouses) references warehouses (code)
);

INSERT INTO Warehouses(code, location, capacity)
VALUES (1, 'Chicago', 3);
INSERT INTO Warehouses(code, location, capacity)
VALUES (2, 'Rocks', 4);
INSERT INTO Warehouses(code, location, capacity)
VALUES (3, 'New York', 7);
INSERT INTO Warehouses(code, location, capacity)
VALUES (4, 'Los Angeles', 2);
INSERT INTO Warehouses(code, location, capacity)
VALUES (5, 'San Francisko', 8);

INSERT INTO Boxes(code, contents, value, warehouses)
VALUES ('0MN7', 'Rocks', 180, 3);
INSERT INTO Boxes(code, contents, value, warehouses)
VALUES ('4H8P', 'Rocks', 250, 1);
INSERT INTO Boxes(code, contents, value, warehouses)
VALUES ('4RT3', 'Scissors', 190, 4);
INSERT INTO Boxes(code, contents, value, warehouses)
VALUES ('7G3H', 'Rocks', 200, 1);
INSERT INTO Boxes(code, contents, value, warehouses)
VALUES ('8JN6', 'Papers', 75, 1);
INSERT INTO Boxes(code, contents, value, warehouses)
VALUES ('8Y6U', 'Papers', 50, 3);
INSERT INTO Boxes(code, contents, value, warehouses)
VALUES ('9J6F', 'Papers', 175, 2);
INSERT INTO Boxes(code, contents, value, warehouses)
VALUES ('LL08', 'Rocks', 140, 4);
INSERT INTO Boxes(code, contents, value, warehouses)
VALUES ('P0H6', 'Scissors', 125, 1);
INSERT INTO Boxes(code, contents, value, warehouses)
VALUES ('P2T6', 'Scissors', 150, 2);
INSERT INTO Boxes(code, contents, value, warehouses)
VALUES ('TUSS', 'Papers', 90, 5);


--Select all warehouses with all columns.
select *
from warehouses;

--Select all boxes with a value larger than $150.
select *
from boxes
where value > 150;

--Select all the boxes distinct by contents.
select distinct contents
from boxes;

--Select the warehouse code and the number of the boxes in each warehouse.
select warehouses, count(*)
from boxes
group by warehouses;

--Same as previous exercise, but select only those warehouses where the number of the boxes is greater than 2.
select warehouses, count(*)
from boxes
group by warehouses
having count(*) > 2;

--Create a new warehouse in New York with a capacity for 3 boxes.
insert into warehouses(code, location, capacity)
values (6, 'New York', 3);

--Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
insert into boxes(code, contents, value, warehouses)
values ('H5RT', 'Papers', 200, 2);

--Reduce the value of the third largest box by 15%.
update boxes
set value = value - value * 0.15
where value = (select distinct value from boxes order by value desc limit 1 offset 2);

--Remove all boxes with a value lower than $150.
delete
from boxes
where value < 150;

--Remove all boxes which is located in New York. Statement should return all deleted data.
delete
from boxes
where warehouses in (select code from warehouses where location = 'New York')
returning *;
