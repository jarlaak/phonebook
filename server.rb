require 'sinatra'
require_relative 'phonebook'

phonebook = PhoneBook.new

get '/phonebook/person/:id' do
    json=phonebook.get_person(params['id'])
    body(json)
    headers({"Content-Type" => " application/json"})
    if json == ""
        status(404)
        body("{}")
    end
end

post '/phonebook/person/' do
    request.body.rewind
    json = request.body.read
    id = phonebook.add_person(json)
    body(id.to_s)
end

get '*' do
    page_missing
end

def page_missing
    status(404)
    body("Page not found!")
end
