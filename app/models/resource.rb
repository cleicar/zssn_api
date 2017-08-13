class Resource
  include Mongoid::Document

  field :type, type: String
  field :quantity, type: Integer
  field :points, type: Integer
  
  RESOURCES_TYPES = ['water', 'food', 'medication', 'ammunition']

  RESOURCES_POINTS = {
    water: 4,
    food: 3,
    medication: 2,
    ammunition: 1
  }

  belongs_to :survivor

  scope :water, -> do
    where(type: 'Water')
  end

  scope :food, -> do
    where(type: 'Food')
  end

  scope :medication, -> do
    where(type: 'Medication')
  end

  scope :ammunition, -> do
    where(type: 'Ammunition')
  end
end