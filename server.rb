require 'sinatra'
require_relative 'phonebook'

phonebook = PhoneBook.new

get '/phonebook/person/:id' do
    phonebook.get_person(params['id'])
end

get '*' do
    page_missing
end

def page_missing
    status(404)
    body("Page not found!")
end
