require('rspec')
require('train')
require 'spec_helper'

describe '#Train' do

  describe('.all') do
    it("returns an empty array when there are no trains") do
      expect(Train.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an train") do
      train = Train.new({:name => "Hogwarts Express", :id => nil})
      train.save()
      train2 = Train.new({:name => "Flying Scotsman", :id => nil})
      train2.save()
      expect(Train.all).to(eq([train, train2]))
    end
  end

  describe('#==') do
    it("is the same train if it has the same attributes as another train") do
      train = Train.new({:name => "Flying Scotsman", :id => nil})
      train2 = Train.new({:name => "Flying Scotsman", :id => nil})
      expect(train).to(eq(train2))
    end
  end

  describe('.clear') do
    it("clears all trains") do
      train = Train.new({:name => "Hogwarts Express", :id => nil})
      train.save()
      train2 = Train.new({:name => "Flying Scotsman", :id => nil})
      train2.save()
      Train.clear()
      expect(Train.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds an train by id") do
      train = Train.new({:name => "Hogwarts Express", :id => nil})
      train.save()
      train2 = Train.new({:name => "Flying Scotsman", :id => nil})
      train2.save()
      # binding.pry
      expect(Train.find(train.id)).to(eq(train))
    end
  end

  describe('.search_name') do
    it("finds an train by name") do
      train = Train.new({:name => "Hogwarts Express", :id => nil})
      train.save()
      train2 = Train.new({:name => "Flying Scotsman", :id => nil})
      train2.save()
      expect(Train.search_name(train.name)).to(eq([train]))
    end
  end

  describe('#update') do
    it("updates an train by id") do
      train = Train.new({:name => "Hogwarts Express", :id => nil})
      train.save()
      train.update("Orient Express")
      expect(train.name).to(eq("Orient Express"))
    end
  end

  describe('#delete') do
    it("deletes an train by id") do
      train = Train.new({:name => "Hogwarts Express", :id => nil})
      train.save()
      train2 = Train.new({:name => "Flying Scotsman", :id => nil})
      train2.save()
      train.delete()
      expect(Train.all).to(eq([train2]))
    end
  end

end
