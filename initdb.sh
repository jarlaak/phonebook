#!/bin/sh

if ! psql -ltq | cut -d '|' -f1 | grep -q "^[ \t]*phonebook[ \t]*$"; then
    echo "Creating phonebook database..."
    createdb -E UTF8 phonebook
fi

if psql phonebook -c "\dt" | cut -d '|' -f2 | grep -q "^[ \t]*phonenumber[ \t]*$"; then
    echo "Dropping phonenumber table..."
    psql phonebook -c "DROP TABLE phonenumber"
fi

if psql phonebook -c "\dt" | cut -d '|' -f2 | grep -q "^[ \t]*phonebook[ \t]*$"; then
    echo "Dropping phonebook table..."
    psql phonebook -c "DROP TABLE phonebook"
fi

echo "Creating tables..."
psql -q phonebook < phonebook.sql
