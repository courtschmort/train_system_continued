class Train
  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id).to_i
  end

  def self.all()
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each() do |train|
      name = train.fetch("name")
      id = train.fetch("id").to_i
      trains.push(Train.new({:name => name, :id => id}))
    end
    trains
  end

  def self.random
    returned_trains = DB.exec("SELECT * FROM trains ORDER BY RANDOM() LIMIT 1;")
    trains = []
    returned_trains.each() do |train|
      name = train.fetch("name")
      id = train.fetch("id").to_i
      trains.push(Train.new({:name => name, :id => id}))
    end
    trains
  end

  def save
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(train_to_compare)
    if train_to_compare != nil
      self.name() == train_to_compare.name()
    else
      false
    end
  end

  def self.clear
    DB.exec("DELETE FROM trains *;")
  end

  def self.find(id)
    train = DB.exec("SELECT * FROM trains WHERE id = #{id};").first
    if train
      name = train.fetch("name")
      id = train.fetch("id").to_i
      Train.new({:name => name, :id => id})
    else
      nil
    end
  end

  def update(attributes)
    if (attributes.is_a? String)
      @name = attributes
      DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{@id};")
    else
    city_name = attributes.fetch(:city_name)
      if city_name != nil
      city = DB.exec("SELECT * FROM cities WHERE lower(name)='#{city_name.downcase}';").first
        if city != nil
          DB.exec("INSERT INTO cities_trains (train_id, city_id) VALUES (#{@id}, #{city['id'].to_i});")
        end
      end
    end
  end

  def delete
    DB.exec("DELETE FROM cities_trains WHERE train_id = #{@id};")
    DB.exec("DELETE FROM trains WHERE id = #{@id};")
  end

  def cities
    cities = []
    results = DB.exec("SELECT city_id FROM cities_trains WHERE train_id = #{@id};")
    results.each() do |result|
      city_id = result.fetch("city_id").to_i()
      city = DB.exec("SELECT * FROM cities WHERE id = #{city_id};")
      name = city.first().fetch("name")
      cities.push(City.new({:name => name, :id => city_id}))
    end
    cities
  end

end
