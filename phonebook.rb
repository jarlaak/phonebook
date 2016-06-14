# coding: utf-8
require 'json'

class PhoneBook
    def initialize(database)
        @database = database
    end

    def get_person(id)
        JSON.generate(@database.get_person(id.to_i))
    end

    def get_all_persons
        JSON.generate(@database.get_all_persons)
    end
    def add_person(json)
        id=0
        begin
            person = JSON.parse(json)
            return 0 unless check_mandatory_fields(person)
            id = @database.add_person(person)
        rescue
        end
        return id
    end

    def search_persons(criterias)
        persons = @database.search_persons(criterias)
        JSON.generate(persons)
    end

    def check_mandatory_fields(hash)
        true
    end
end
