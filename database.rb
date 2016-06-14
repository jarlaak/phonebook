# coding: utf-8
require 'pg'

class Database
    def initialize()
        @connection = PG::Connection.new(:dbname => "phonebook")
    end

    def get_person(id)
        res = get_person_from_db(id)
        result_to_hash(res)
    end

    def result_to_hash(res)
        if ( !res.nil? )
            {"firstname"=>res["first_name"], "lastname"=>res["last_name"], "phonenumber"=>res["phone_number"]}
        else
            {}
        end
    end
    
    def get_person_from_db(id)
        res = @connection.exec_params("SELECT * FROM phonebook WHERE person_id=$1",[id])
        if ( res.count == 1 )
            res[0]
        else
            nil
        end
    end
    
    def add_person(person)
        id = next_index
        begin
            @connection.exec_params("INSERT INTO phonebook (person_id,first_name,last_name,phone_number) VALUES ($1,$2,$3,$4)",[id,person["firstname"],person["lastname"],person["phonenumber"]])
        rescue
            id = 0
        end
        return {"id"=>id}
    end

    def get_all_persons
        res = @connection.exec_params("SELECT * FROM phonebook")
        rows_to_hash(res)
    end

    def rows_to_hash(rows)
        hash = {}
        rows.each do |row|
            hash[row["person_id"]]=result_to_hash(row)
        end
        return hash

    end
    
    def search_persons(criterias)
        search = "SELECT * from phonebook WHERE"
        params=[]
        add_and=""
        criterias.each do |criteria|
            case (criteria[:name].downcase)
            when "firstname"
                search += "#{add_and} first_name LIKE $#{params.length+1}"
                params << escape(criteria[:criteria].gsub('*','%'))
                add_and = " AND"
            when "lastname"
                search += "#{add_and} last_name LIKE $#{params.length+1}"
                params << escape(criteria[:criteria].gsub('*','%'))
                add_and = " AND"
            end
        end
        res={}
        res=@connection.exec_params(search,params) if params != []
        return rows_to_hash(res)
    end

    def next_index
        res=@connection.exec_params("SELECT MAX(person_id) FROM phonebook")
        max = (res[0]["max"]).to_i + 1
    end

    def escape(str)
        PG::Connection.escape_string(str)
    end
    
    def close
        @connection.close if connection != nil
        @connection = nil
    end
end
