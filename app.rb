#!/usr/bin/env ruby
require('sinatra')
require('sinatra/reloader')
require('./lib/train')
require ('./lib/city')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "train_system"})

get('/') do
  erb(:trains)
end

# This route will show a list of all trains.
get('/trains') do
  if params["search"]
    @trains = Train.search_name(params[:search])
  # elsif params["alphabetize"]
  #   @trains = Train.alphabetize
  # elsif params["random"]
  #   @trains = Train.random
  else
    @trains = Train.all
  end
  erb(:trains)
end

# This will take us to a page with a form for adding a new train.
get('/trains/new') do
  erb(:new_train)
end

# This route will add an train to our list of trains. We can't access this by typing in the URL. In a future lesson, we will use a form that specifies a POST action to reach this route.
post('/trains') do
  name = params[:train_name]
  train = Train.new({:name => name, :id => nil})
  train.save()
  @trains = Train.all() # Adding this line will fix the error.
  erb(:trains)
end

# This route will show a specific train based on its ID. The value of ID here is #{params[:id]}.
get('/trains/:id') do
  @train = Train.find(params[:id].to_i())
  if @train == nil
    erb(:go_back)
  else
    erb(:train)
  end
end

# his will take us to a page with a form for updating an train with an ID of #{params[:id]}.
get('/trains/:id/edit') do
  @train = Train.find(params[:id].to_i())
  erb(:edit_train)
end

# This route will update an train. We can't reach it with a URL. In a future lesson, we will use a form that specifies a PATCH action to reach this route.
patch('/trains/:id') do
  if params[:buy]
    @train = Train.find(params[:id].to_i())
    @train.sold
  else
    @train = Train.find(params[:id].to_i())
    @train.update(params[:name])
  end
  @trains = Train.all
  erb(:trains)
end

# This route will delete an train. We can't reach it with a URL. In a future lesson, we will use a delete button that specifies a DELETE action to reach this route.
delete('/trains/:id') do
  @train = Train.find(params[:id].to_i())
  @train.delete()
  @trains = Train.all
  erb(:trains)
end

get('/cities') do
  if params["search"]
    @cities = City.search_name(params[:search])
  else
    @cities = City.all
  end
  erb(:cities)
end

get('/cities/new') do
  erb(:new_city)
end

get('/cities/:id') do
  @city= City.find(params[:id].to_i())
  if @city== nil
    erb(:go_back)
  else
    erb(:city)
  end
end

post '/cities/:id' do
    City.find(params[:id].to_i).add_train(params[:train_name])
    erb(:city)
    # redirect to "/cities/#{params[:id]}"
end


post('/cities') do
  name = params[:city_name]
  city = City.new({:name => name, :id => nil})
  city.save
  @cities = City.all
  erb(:cities)
end

patch('/cities/:id') do
  @city = City.find(params[:id].to_i())
  @city.update(params[:name])
  @cities = Train.all
  erb(:cities)
end

delete('/cities/:id') do
  @city = City.find(params[:id].to_i())
  @city.delete()
  @cities = City.all
  erb(:cities)
end
