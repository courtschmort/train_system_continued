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

  # def self.alphabetize
  #   trains = self.all
  #   trains.sort { |a, b| a.name.downcase <=> b.name.downcase }
  # end


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

  def self.search_name(name)
    trains = self.all
    trains.select { |train| /#{name}/i.match? train.name }
  end

  def update(name)
    @name = name
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{id};")
  end

  def delete()
    DB.exec("DELETE FROM trains WHERE id = #{@id};")
  end

  # def songs
  #   Song.find_by_train(self.id)
  # end

end
