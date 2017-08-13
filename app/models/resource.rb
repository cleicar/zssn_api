class Resource
  include Mongoid::Document

  field :type, type: String
  field :quantity, type: Integer
  field :points, type: Integer
  
  RESOURCES_POINTS = {
    "water": 4,
    "food": 3,
    "medication": 2,
    "ammunition": 1
  }

  belongs_to :survivor
end