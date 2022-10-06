create table customers(
    id integer,
    full_name varchar(50),
    timestamp timestamp,
    delivery_address text,
    primary key (id)
);
create table orders
(
    code        integer,
    customer_id integer,
    total_sum   double precision,
    is_paid     boolean,
    primary key (code),
    foreign key (customer_id) references customers
);
create table order_items(
    order_code integer,
    product_id varchar,
    quantity integer,
    foreign key (order_code) references orders,
    foreign key (product_id) references products
);

create table products(
    id varchar,
    name varchar,
    description text,
    price double precision,
    primary key(id)
);
create database university;
create table students(name varchar, id varchar);
alter table students rename to firstyears;
drop table firstyears;
drop database university;

insert into firstyears values('Amina', '21B031086');
update firstyears set  id = '22B031086' where name = 'Amina';
delete from firstyears where name = 'Amina';
select * from firstyears;
select id from firstyears;

create table students(
    full_name text,
    age integer,
    birth_date varchar(10),
    gender text,
    average_grade float,
    city varchar(21),
    nationality varchar(21),
    phone_number varchar(21),
    social_category text,
    primary key (full_name)
);

create table instructors(
    full_name text,
    speaking_languages varchar(255),
    work_experience float,
    remote_lessons float,
    primary key (full_name)
);

create table lesson_participants(
    lesson text,
    teaching_instructor text,
    studying_students text,
    room_number text,
    foreign key (teaching_instructor) references instructors,
    foreign key (studying_students) references students
);

insert into customers values(6, 'Amangeldi Amina',1664769731, 'Seifullina, 574');
insert into products values ('2840', 'milk', 'low in calories and light in taste', 450.00);
update customers set id = 1 where full_name = 'Amangeldi Amina';
delete from customers where id = 1;