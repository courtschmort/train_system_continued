require 'rspec'
require 'city'
require 'train'
require 'pry'
require 'spec_helper'

describe '#City' do


  describe('#==') do
    it("is the same city if it has the same attributes as another city") do
      city = City.new({:name =>"Lisbon", :id => nil})
      city2 = City.new({:name =>"Lisbon", :id => nil})
      expect(city).to(eq(city2))
    end
  end
  #
  describe('.all') do
    it("returns a list of all cities") do
      city = City.new({:name => "Oporto", :id =>nil})
      city.save()
      city2 = City.new({:name =>"Lisbon", :id => nil})
      city2.save()
      expect(City.all).to(eq([city, city2]))
    end
  end

  describe('.clear') do
    it("clears all cities") do
      city = City.new({:name => "Oporto", :id =>nil})
      city.save()
      city2 = City.new({:name =>"Lisbon", :id => nil})
      city2.save()
      City.clear()
      expect(City.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves a city") do
      city = City.new({:name =>"Lisbon", :id => nil})
      city.save()
      expect(City.all).to(eq([city]))
    end
  end

  describe('.find') do
    it("finds a city by id") do
      city = City.new({:name => "Oporto", :id =>nil})
      city.save()
      city2 = City.new({:name =>"Lisbon", :id => nil})
      city2.save()
      expect(City.find(city.id)).to(eq(city))
    end
  end

  describe('#update') do
    it("adds a train to a city") do
      city = City.new({:name => "Oporto", :id => nil})
      city.save()
      train = Train.new({:name => "Hogwarts Express", :id => nil})
      train.save()
      city.update({:train_name => "Hogwarts Express"})
      expect(city.trains).to(eq([train]))
    end
  end

  describe('#delete') do
    it("deletes a city by id") do
      city = City.new({:name => "Oporto", :id =>nil})
      city.save()
      city2 = City.new({:name =>"Lisbon", :id => nil})
      city2.save()
      city.delete()
      expect(City.all).to(eq([city2]))
    end
  end

end
