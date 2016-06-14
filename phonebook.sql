DROP TABLE phonebook;
CREATE TABLE phonebook (
    person_id bigserial primary key,
    first_name varchar(40) NOT NULL,
    last_name varchar(40) NOT NULL,
    phone_number varchar(20) NOT NULL
);
