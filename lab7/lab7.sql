--1
--a increments given values by 1 and returns it
create or replace function add_one(n int)
    returns int
as
$$
begin
    return n + 1;
end;
$$
    language plpgsql;
select add_one(5);

--b Returns sum of 2 numbers
create or replace function summ(n int, m int)
    returns int
as
$$
begin
    return n + m;
end;
$$
    language plpgsql;
select summ(5, 6);

--c Returns true or false if numbers are divisible by 2
create or replace function even(n int)
    returns boolean
as
$$
begin
    return n % 2 = 0;
end;
$$
    language plpgsql;
select even(6);

--d Checks some password for validity
create or replace function valid(password text)
    returns boolean
as
$$
begin
    if (length(password) < 8) then
        return false;
    else
        return false;
    end if;
end;
$$
    language plpgsql;
select valid('fjkgtl');

--e Returns two outputs, but has one input
create or replace function returns(n int, out one int, out two int)
as
$$
begin
    one = n + n;
    two = n * n;
end;
$$
    language plpgsql;
select returns(5);

--2
--a Return timestamp of the occured action within the database
create table a
(
    name varchar(30),
    date timestamp
);
create or replace function occAct()
    returns trigger
as
$$
begin
    if new.name <> old.name then
        update a
        set date = now()
        where name = new.name;
    else
        update a
        set date = now()
        where date is null;
    end if;
    return new;
end;
$$
    language plpgsql;

create trigger act
    after insert or update
    on a
    for each row
execute procedure occAct();

insert into a
values ('Amina', now());
update a
set name = 'Bota'
where name = 'Nana';
select *
from a;
--b Computes the age of a person when persons’ date of birth is inserted
create table b
(
    date_of_birth date,
    age           int default 0
);

create or replace function compAge()
    returns trigger
as
$$
begin
    update b
    set age = now() - date_of_birth
    where date_of_birth is not null;
    return new;
end;
$$
    language plpgsql;

create trigger updAge
    after insert or update
    on b
    for each row
execute procedure compAge();

insert into b
values ('2004-08-15 07:45:02.34555');
select *
from b;
--c Adds 12% tax on the price of the inserted item
create table c
(
    name  varchar(20),
    price float
);

create or replace function addTax()
    returns trigger
as
$$
begin
    update c
    set price = price * 0.12 + price
    where price is not null;
    return new;
end;

$$
    language plpgsql;

create trigger Add
    after insert or update
    on c
    for each row
execute procedure addTax();

insert into c
values ('Car', 10000);
select *
from c;
--d Prevents deletion of any row from only one table
create table d
(
);
create or replace function prevent()
    returns trigger as
$$
begin
    raise exception 'Deletion is not possible!';
end;
$$
    language plpgsql;

create trigger del
    before delete
    on d
execute procedure prevent();
--e Launches functions  1.d and 1.e.
create table e
(
);

create or replace function launch()
    returns trigger as
$$
begin
    raise notice '%'
        , valid(new.s);
    raise notice '%', returns(new.n);
    return new;
end;
$$
    language plpgsql;

create trigger l
    before insert or update
    on e
    for each row
execute launch();

--3
--a Increases salary by 10% for every 2 years of work experience and provides 10% discount and
-- after 5 years adds 1% to the discount
create or replace procedure increasing(year int, salary int, out salary1 int, out discount int)
as
$$
declare
    y int;
begin
    while year >= 0
        loop
            if y % 2 = 0 then
                salary1 = salary * 0.1 + salary;
                discount = salary1 * 0.1;
            end if;
            if y % 5 = 0 then
                discount = discount * 0.01 + discount;
            end if;
            y = y + 1;
        end loop;
end;
$$
    language plpgsql;
call increasing(6, 4000);

--b After reaching 40 years, increase salary by 15%. If work experience is more than 8 years,
-- increase salary for 15% of the already increased value for work experience and provide a constant 20% discount
create or replace procedure increasing1(year int, salary int, out salary1 int, out discount int)
as
$$
declare
    y int;
begin
    salary1 = salary;
    while year >= 0
        loop
            if y = 40 then
                salary1 = salary1 * 0.15 + salary1;
            end if;
            if y % 8 = 0 then
                salary1 = salary * 0.2 + salary1;
                discount = discount * 0.01 + discount;
            end if;
            y = y + 1;
        end loop;
end;
$$
    language plpgsql;
call increasing1(20, 4000);
