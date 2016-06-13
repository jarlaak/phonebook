require 'json'

class PhoneBook
    def initialize()
        @persons = {1=>{:name => "Test"}}
    end

    def get_person(sid)
        json = ""
        id = sid.to_i
        if ( id > 0 )
            person = @persons.select { |kid,hash| kid == id }
            json = JSON.generate(person[id]) unless person.length == 0
        end
        json
    end

    def add_person(json)
        person = JSON.parse(json)
        return 0 unless check_mandatory_fields(person)
        id = next_index
        @persons[id]=person
        id
    end

    def next_index
        max = @persons.map { |id,hash| id }.max + 1
    end

    def check_mandatory_fields(hash)
        true
    end
end
