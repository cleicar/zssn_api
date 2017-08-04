class Survivor
  include Mongoid::Document
  
  field :name, type: String
  field :age, type: String
  field :gender, type: String
  field :last_location, type: Hash
end
