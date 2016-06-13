# coding: utf-8
require 'json'

class PhoneBook
    def initialize()
        @persons = {1=>{"firstname" => "Matti", "lastname" => "Meikäläinen"}, 2 => {"firstname" => "Maija", "lastname"=>"Meikäläinen"}}
    end

    def get_person(id)
        json = "{}"
        json = JSON.generate(@persons[id.to_i]) if @persons.has_key?(id.to_i)
        json
    end

    def add_person(json)
        id=0
        begin
            person = JSON.parse(json)
            return 0 unless check_mandatory_fields(person)
            id = next_index
            @persons[id]=person
        rescue
        end
        id
    end

    def search_persons(criterias)
        persons = @persons
        criterias.each do |criteria|
            persons = persons.select do |key,value|
                found = value.has_key?(criteria[:name])
                if (found )
                    found = value[criteria[:name]] == criteria[:criteria]
                end
                found
            end
        end
        JSON.generate(persons)
    end

    def next_index
        max = @persons.map { |id,hash| id }.max + 1
    end

    def check_mandatory_fields(hash)
        true
    end
end
