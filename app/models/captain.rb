class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #returns all captians of catamarans
    #to find the kind of boat you need to look in classifications
    #where classification is named catamaran
     includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    #returns all captains of sailboats
    #to find the kind of boat you need to look in classifications
    #where classification is named sailboat
    #.distinct ensures you dont return the same captian twice
     includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.motorboat_operators
    #returns captains of motorboats and sailboats
    #to find the kind of boat you need to look in classifications where classification is named motorboat
     includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
     where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    #returns people who are not captains of sailboats
    #.pluck is new
    #Use #pluck as a shortcut to select one or more attributes without loading a bunch of records just to grab the attributes you want.
     where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
