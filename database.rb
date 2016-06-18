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
            id=res["person_id"]
            {"id" => id, "firstname"=>res["first_name"], "lastname"=>res["last_name"], "phonenumber"=>get_phone_numbers(id)}
        else
            {}
        end
    end

    def get_phone_numbers(id)
        begin
            res = @connection.exec_params("SELECT phone_number FROM phonenumber WHERE person_id=$1",[id])
            res.map { |r| r["phone_number"] }
        rescue
            []
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
            @connection.transaction do |conn|
                conn.exec_params("INSERT INTO phonebook (person_id,first_name,last_name) VALUES ($1,$2,$3)",[id,escape(person["firstname"]),escape(person["lastname"])])
                person["phonenumber"].each do |phonenumber|
                    conn.exec_params("INSERT INTO phonenumber VALUES ($1,$2)",[escape(phonenumber),id])
                end
            end
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
        rows.map do |row|
            result_to_hash(row)
        end
    end
    
    def search_persons(criterias)
        search = "SELECT * from phonebook WHERE"
        params=[]
        add_and=""
        criterias.each do |criteria|
            case (criteria[:name].downcase)
            when "firstname"
                if ( criteria.has_key?(:criteria) )
                     params << escape(criteria[:criteria].gsub('*','%'))
                     search += "#{add_and} first_name LIKE $#{params.length}"
                     add_and = " AND"
                end
            when "lastname"
                if ( criteria.has_key?(:criteria) )
                    params << escape(criteria[:criteria].gsub('*','%'))
                    search += "#{add_and} last_name LIKE $#{params.length}"
                    add_and = " AND"
                end
            else
                return []
            end
        end
        res=[]
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
