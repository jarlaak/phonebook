require 'sinatra/base'
require_relative 'phonebook'
require_relative 'database'

class PhoneBookServer < Sinatra::Base
    set(:bind=>"0.0.0.0")
    set(:reload_templates=>false)
    configure :production do
        set(:port=>80)
    end

    def initialize()
        if ( settings.production? && Process::Sys.getuid == 0)
            uid = Etc.getpwnam("phonebook").uid
            Process::Sys.setuid(uid)
        end
        database = Database.new
        @phonebook = PhoneBook.new(database)
    end
    
    get '/' do
        send_file('public/index.html')
    end
    
    get '/phonebook/person/search/' do
        return_json(@phonebook.get_all_persons)
    end
    
    get '/phonebook/person/search/:criterias' do
        criterias = parse_search_criterias(params["criterias"])
        json = @phonebook.search_persons(criterias)
        return_json(json)
    end
    
    get '/phonebook/person/:id' do
        json=@phonebook.get_person(params['id'])
        return_json(json)
    end
    
    post '/phonebook/person/' do
        request.body.rewind
        json = request.body.read
        id = @phonebook.add_person(json)
        status(404) if id == 0
        body(id.to_s)
    end
    
    get '/' do
        send_file('public/index.html')
    end
    
    def return_json(json)
        status = 200
        status = 404 if (json == "{}" || json == "[]" || json == "")
        [status,{"Content-Type" => " application/json"},json]
    end
    
    def parse_search_criterias(criterias)
        criterias.split(';').map do |criteria|
            components = criteria.split('=',2)
            search = {:name => components[0].downcase}
            search[:criteria]=components[1] if ( components.length > 1 )
            search
        end
    end
end

PhoneBookServer.run!
