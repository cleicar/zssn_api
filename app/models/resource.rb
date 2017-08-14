class Resource
  include Mongoid::Document

  field :type, type: String
  field :quantity, type: Integer
  field :points, type: Integer

  belongs_to :survivor
  
  RESOURCES_TYPES = ['water', 'food', 'medication', 'ammunition']

  RESOURCES_POINTS = {
    water: 4,
    food: 3,
    medication: 2,
    ammunition: 1
  }.with_indifferent_access
  
  RESOURCES_POINTS.keys.each do |resource_type|
    scope resource_type, -> { where(type: resource_type.capitalize) }
  end

  def self.points_sum(survivor_resources)
    survivor_resources.sum { |resource| 
      resource['quantity'].to_i * RESOURCES_POINTS[resource['type'].downcase]
    }
  end
end