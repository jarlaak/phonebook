CREATE TABLE phonebook (
    person_id bigserial primary key,
    first_name varchar(40) NOT NULL,
    last_name varchar(40) NOT NULL
);

CREATE TABLE phonenumber (
    phone_number varchar(20) NOT NULL,
    person_id bigserial references phonebook
);
