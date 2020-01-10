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
  erb(:index)
end

get('/trains') do
    @trains = Train.all
  erb(:trains)
end

get('/trains/new') do
  erb(:new_train)
end

post('/trains') do
  name = params[:train_name]
  train = Train.new({:name => name, :id => nil})
  train.save()
  @trains = Train.all()
  erb(:trains)
end

get('/trains/:id') do
  @train = Train.find(params[:id].to_i())
  if @train == nil
    erb(:go_back)
  else
    erb(:train)
  end
end

get('/trains/:id/edit') do
  @train = Train.find(params[:id].to_i())
  erb(:edit_train)
end

patch('/trains/:id') do
  @train = Train.find(params[:id].to_i())
  @train.update({:name => params[:name], :city_name => params[:city_name], :id => nil})
  @trains = Train.all
  erb(:train)
end

delete('/trains/:id') do
  @train = Train.find(params[:id].to_i())
  @train.delete()
  @trains = Train.all
  erb(:trains)
end

post('trains/:id') do
  name = params[:city_name]
  city = City.new({:name => name, :id => nil})
  city.save
  @cities = City.all
  erb(:train)
end

get('/cities') do
    @cities = City.all
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

get('/cities/:id/edit') do
  @city = City.find(params[:id].to_i())
  erb(:edit_city)
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
  @city.update({:name => params[:name], :train_name => params[:train_name], :id => nil})
  @cities = City.all
  erb(:city)
end

delete('/cities/:id') do
  @city = City.find(params[:id].to_i())
  @city.delete()
  @cities = City.all
  erb(:cities)
end
