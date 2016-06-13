# coding: utf-8
class Database
    def initialize()
        @persons = {1=>{"firstname" => "Matti", "lastname" => "Meikäläinen"}, 2 => {"firstname" => "Maija", "lastname"=>"Meikäläinen"}}
    end

    def get_person(id)
        if (@persons.has_key?(id))
            @persons[id]
        else
            {}
        end
    end

    def add_person(person)
        id = next_index
        @persons[id]=person
        return id
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
        return persons
    end

    def next_index
        max = @persons.map { |id,hash| id }.max + 1
    end
end
